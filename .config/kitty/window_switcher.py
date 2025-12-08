#!/usr/bin/env python3
"""
Kitty window switcher kitten - displays overlay with window list
Usage: Map to a keybinding in kitty.conf:
    map cmd+shift+w kitten window_switcher.py
"""

import sys
import json
import subprocess
from typing import List, Dict, Optional


def get_windows_in_current_tab() -> List[Dict]:
    """Get list of windows in the currently active tab"""
    try:
        result = subprocess.run(
            ['kitty', '@', 'ls'],
            capture_output=True,
            text=True,
            check=True
        )
        data = json.loads(result.stdout)

        # Find the focused tab
        for os_window in data:
            for tab in os_window['tabs']:
                if tab['is_focused']:
                    return tab['windows']

        return []
    except (subprocess.CalledProcessError, json.JSONDecodeError, KeyError):
        return []


def truncate_string(s: str, max_len: int) -> str:
    """Truncate string to max length with ellipsis"""
    if len(s) <= max_len:
        return s
    return s[:max_len-3] + '...'


def display_window_list(windows: List[Dict]) -> None:
    """Display formatted window list as overlay"""
    if not windows:
        print("\n  No windows found in current tab\n")
        return

    # Calculate width for the box
    max_title_len = 50
    box_width = max_title_len + 10

    # Header
    print("\n")
    print("  ┌─" + " Windows " + "─" * (box_width - 12) + "┐")

    # Window list
    for i, window in enumerate(windows, 1):
        title = window.get('title', 'Unknown')
        is_active = window.get('is_focused', False)

        # Get first word of title or process name
        title_parts = title.split()
        short_title = title_parts[0] if title_parts else title

        # Truncate if too long
        short_title = truncate_string(short_title, max_title_len)

        # Active indicator
        indicator = "*" if is_active else " "

        # Format line
        line = f"  │ {i}. {short_title}{indicator}"
        padding = " " * (box_width - len(line) + 2)
        print(line + padding + "│")

    # Footer
    print("  └" + "─" * box_width + "┘")
    print("\n  Type window number (1-9) to switch, ESC or q to cancel\n")


def main(args: List[str]) -> Optional[str]:
    """Main kitten entry point"""
    windows = get_windows_in_current_tab()

    if not windows:
        print("\n  No windows in current tab\n")
        input("  Press Enter to close...")
        return None

    display_window_list(windows)

    # Get user input
    try:
        choice = input("  Select: ").strip()

        if choice in ['q', 'Q', '\x1b']:  # q or ESC
            return None

        if choice.isdigit():
            idx = int(choice) - 1
            if 0 <= idx < len(windows):
                # Return the window ID to focus
                return str(windows[idx]['id'])

    except (KeyboardInterrupt, EOFError):
        return None

    return None


def handle_result(args: List[str], result: Optional[str], target_window_id: int, boss) -> None:
    """Handle the result from main() - called by kitty after kitten closes"""
    if result and result.isdigit():
        window_id = int(result)
        # Focus the selected window using kitty remote control
        boss.call_remote_control(None, ('focus-window', '--match', f'id:{window_id}'))


if __name__ == '__main__':
    main(sys.argv[1:])
