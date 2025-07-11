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

        for i, component in enumerate(components):
            # Skip empty components
            if not component:
                continue

            # Keep the last component unchanged
            if i == len(components) - 1:
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
    projects = []

    # Define search paths
    search_paths = [
        (f"{home}", 1),
        (f"{home}/root", 1),
        (f"{home}/root/work", 1),
        (f"{home}/root/play", 1),
        (f"{home}/root/play/labs", 2),
        (f"{home}/root/play/codingchallenges.fyi", 2),
    ]

    for search_path, max_depth in search_paths:
        if os.path.exists(search_path):
            try:
                result = subprocess.run(
                    ["fd", ".", search_path, "-d",
                        str(max_depth), "-t", "d", "-H"],
                    capture_output=True,
                    text=True,
                    check=True
                )
                projects.extend(result.stdout.strip().split("\n"))
            except subprocess.CalledProcessError:
                logger.warning(f"fd command failed for {search_path}")
            except FileNotFoundError:
                logger.warning("fd command not found, falling back to find")
                # Fallback to find command
                try:
                    result = subprocess.run(
                        ["find", search_path, "-maxdepth",
                            str(max_depth), "-type", "d"],
                        capture_output=True,
                        text=True,
                        check=True
                    )
                    projects.extend(result.stdout.strip().split("\n"))
                except subprocess.CalledProcessError:
                    logger.warning(f"find command failed for {search_path}")

    # Remove empty strings and duplicates
    return list(filter(None, set(projects)))


def find_existing_window(abbreviated_path: str) -> Optional[str]:
    """Find existing kitty window with the given abbreviated path."""
    try:
        # Get all windows
        result = subprocess.run(
            ["aerospace", "list-windows", "--all"],
            capture_output=True,
            text=True,
            check=True
        )

        # Filter for kitty windows with matching path
        for line in result.stdout.strip().split("\n"):
            if "kitty" in line.lower() and line.endswith(abbreviated_path):
                window_id = line.split()[0]
                logger.debug(f"Found existing window ID: {window_id}")
                return window_id

        return None
    except subprocess.CalledProcessError as e:
        logger.warning(f"aerospace command failed: {e}")
        return None
    except FileNotFoundError:
        logger.warning("aerospace command not found")
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
    window_id = find_existing_window(selected_abbreviated)

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
