#!/usr/bin/env python3

import os
import sys
import subprocess
import logging
from pathlib import Path
from typing import List, Optional

# Set up logging
LOG_FILE = "/tmp/kitty-sessioniser.log"
logging.basicConfig(
    level=logging.DEBUG,
    format='%(asctime)s - %(message)s',
    handlers=[
        logging.FileHandler(LOG_FILE, mode='w'),
        logging.StreamHandler()
    ]
)
logger = logging.getLogger(__name__)


def abbreviate_path(input_path: str) -> str:
    """Abbreviate path by shortening intermediate directories to first letter."""
    home = os.path.expanduser("~")

    # Check if path starts with HOME directory
    if input_path.startswith(home):
        # Replace HOME with ~
        remaining = input_path[len(home):]

        # If it's just HOME, return ~
        if not remaining:
            return "~"

        # Remove leading slash if present
        remaining = remaining.lstrip("/")

        # If no remaining path, return ~
        if not remaining:
            return "~"

        # Split remaining path into components
        components = remaining.split("/")
        result = "~"

        # Filter out empty components first
        non_empty_components = [c for c in components if c]

        for i, component in enumerate(non_empty_components):
            # Keep the last component unchanged
            if i == len(non_empty_components) - 1:
                result += f"/{component}"
            # Abbreviate intermediate components to first letter
            else:
                result += f"/{component[0]}"

        return result
    else:
        # For non-home paths, abbreviate all but the last component
        components = input_path.split("/")
        result_parts = []

        for i, component in enumerate(components):
            # Skip empty components (from leading /)
            if not component:
                continue

            # Keep the last component unchanged
            if i == len(components) - 1:
                result_parts.append(component)
            # Abbreviate intermediate components to first letter
            else:
                result_parts.append(component[0])

        return "/" + "/".join(result_parts) if result_parts else "/"


def list_projects() -> List[str]:
    """List all project directories."""
    home = os.path.expanduser("~")
    projects = [
        f"{home}/aincrad",
        f"{home}/.aws",
        f"{home}/.kube",
    ]

    # Define search paths with exclusions for faster search
    search_configs = [
        (f"{home}/root/work", 1,
         [".git", "node_modules", ".cache", "target", "build"]),
        (f"{home}/root/play", 1,
         [".git", "node_modules", ".cache", "target", "build"]),
        (f"{home}/root/play/labs", 2,
         [".git", "node_modules", ".cache", "target", "build"]),
        (f"{home}/root/play/codingchallenges.fyi", 2,
         [".git", "node_modules", ".cache", "target", "build"]),
    ]

    for search_path, max_depth, excludes in search_configs:
        if os.path.exists(search_path):
            try:
                # Build fd command with excludes for better performance
                cmd = ["fd", ".", search_path, "-d",
                       str(max_depth), "-t", "d", "-H"]

                # Add excludes
                for exclude in excludes:
                    cmd.extend(["-E", exclude])

                result = subprocess.run(
                    cmd,
                    capture_output=True,
                    text=True,
                    check=True
                )
                projects.extend(result.stdout.strip().split("\n"))
            except subprocess.CalledProcessError:
                logger.warning(f"fd command failed for {search_path}")
            except FileNotFoundError:
                logger.warning("fd command not found, falling back to find")
                # Fallback to find command with excludes
                try:
                    exclude_args = []
                    for exclude in excludes:
                        exclude_args.extend(
                            ["-not", "-path", f"*/{exclude}/*"])

                    result = subprocess.run(
                        ["find", search_path, "-maxdepth",
                            str(max_depth), "-type", "d"] + exclude_args,
                        capture_output=True,
                        text=True,
                        check=True
                    )
                    projects.extend(result.stdout.strip().split("\n"))
                except subprocess.CalledProcessError:
                    logger.warning(f"find command failed for {search_path}")

    # Remove empty strings and duplicates
    return list(filter(None, set(projects)))


def find_existing_window(abbreviated_path: str, selected_path: str) -> Optional[str]:
    """Find existing kitty window with the given path."""
    try:
        # Get kitty window info using kitten @ ls
        result = subprocess.run(
            ["kitten", "@", "ls"],
            capture_output=True,
            text=True,
            check=True
        )

        import json
        kitty_data = json.loads(result.stdout)

        logger.debug(f"Looking for path: '{selected_path}'")

        # Search through all OS windows and tabs to find matching cwd
        matching_platform_window_id = None
        for os_window in kitty_data:
            platform_window_id = os_window.get("platform_window_id")
            logger.debug(f"Checking OS window with platform_window_id: {
                         platform_window_id}")

            for tab in os_window.get("tabs", []):
                for window in tab.get("windows", []):
                    cwd = window.get("cwd", "")
                    logger.debug(f"  Checking window cwd: '{cwd}'")

                    # Check if this window's cwd matches our selected path (normalize trailing slash)
                    if cwd.rstrip('/') == selected_path.rstrip('/'):
                        matching_platform_window_id = platform_window_id
                        logger.debug(f"Found matching cwd in platform window: {
                                     platform_window_id}")
                        break
                if matching_platform_window_id:  # Found a match in this OS window
                    break
            if matching_platform_window_id:  # Found a match
                break

        if not matching_platform_window_id:
            logger.debug("No matching platform window found")
            return None

        # Now get aerospace window IDs and find the one that corresponds to our platform window
        aerospace_result = subprocess.run(
            ["aerospace", "list-windows", "--monitor", "all",
                "--app-bundle-id", "net.kovidgoyal.kitty"],
            capture_output=True,
            text=True,
            check=True
        )

        logger.debug(f"Aerospace output:\n{aerospace_result.stdout}")

        # Match the aerospace window ID by checking if it matches our platform window ID
        for line in aerospace_result.stdout.strip().split("\n"):
            if str(matching_platform_window_id) in line:
                window_id = line.split()[0]
                logger.debug(
                    f"Found matching aerospace window ID: {window_id}")
                return window_id

        logger.debug("No matching aerospace window found")
        return None
    except subprocess.CalledProcessError as e:
        logger.warning(f"Command failed: {e}")
        return None
    except FileNotFoundError:
        logger.warning("Command not found")
        return None
    except json.JSONDecodeError as e:
        logger.warning(f"Failed to parse kitten @ ls output: {e}")
        return None


def focus_window(window_id: str) -> bool:
    """Focus the aerospace window with given ID."""
    try:
        result = subprocess.run(
            ["aerospace", "focus", "--window-id", window_id],
            check=True
        )
        logger.debug(f"Successfully focused window {window_id}")
        return True
    except subprocess.CalledProcessError as e:
        logger.warning(f"Failed to focus window {window_id}: {e}")
        return False


def launch_new_window(selected_path: str) -> bool:
    """Launch new kitty window in the selected directory."""
    try:
        result = subprocess.run(
            ["kitten", "@", "launch",
                f"--cwd={selected_path}", "--type=os-window"],
            check=True
        )
        logger.debug(f"Successfully launched new window for {selected_path}")
        return True
    except subprocess.CalledProcessError as e:
        logger.warning(f"Failed to launch new window: {e}")
        return False


def find_and_open_projects():
    """Main function to find and open projects."""
    logger.debug("Starting find_and_open_projects()")

    # Get list of projects
    projects = list_projects()
    logger.debug(f"Found {len(projects)} projects")

    if not projects:
        logger.error("No projects found")
        sys.exit(1)

    # Choose a project with fzf
    logger.debug("Launching fzf for project selection")
    try:
        process = subprocess.run(
            ["fzf"],
            input="\n".join(projects),
            text=True,
            capture_output=True,
            check=True
        )
        selected = process.stdout.strip()
    except subprocess.CalledProcessError:
        logger.debug("Empty selection, exiting")
        print("Empty selection, exiting")
        sys.exit(1)
    except FileNotFoundError:
        logger.error("fzf command not found")
        sys.exit(1)

    if not selected:
        logger.debug("Empty selection, exiting")
        print("Empty selection, exiting")
        sys.exit(1)

    logger.debug(f"Selected project: {selected}")
    selected_abbreviated = abbreviate_path(selected)
    logger.debug(f"Abbreviated path: {selected_abbreviated}")
    print(f"selected: {selected_abbreviated}, {selected}")

    # Check if kitty window already exists
    window_id = find_existing_window(selected_abbreviated, selected)

    if window_id:
        logger.debug(
            f"Found existing window, focusing aerospace window ID: {window_id}")
        focus_window(window_id)
    else:
        logger.debug("No existing window found, creating new kitty window")
        launch_new_window(selected)

    logger.debug("Script completed")


if __name__ == "__main__":
    find_and_open_projects()
