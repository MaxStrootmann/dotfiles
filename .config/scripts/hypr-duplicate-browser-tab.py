#!/usr/bin/env python3

import json
import os
import random
import shutil
import subprocess
import sys
import time


SUPPORTED_WINDOW_CLASSES = {
    "google-chrome",
    "google-chrome-beta",
    "google-chrome-unstable",
    "chromium",
    "chromium-browser",
}


def notify(message: str) -> None:
    if shutil.which("notify-send"):
        subprocess.run(["notify-send", "Hypr Duplicate Tab", message], check=False)


def hyprctl_json(*args: str) -> dict:
    result = subprocess.run(
        ["hyprctl", "-j", *args],
        check=True,
        capture_output=True,
        text=True,
    )
    return json.loads(result.stdout)


def send_shortcut(shortcut: str) -> None:
    subprocess.run(
        ["hyprctl", "dispatch", "sendshortcut", shortcut],
        check=True,
        capture_output=True,
        text=True,
    )


def clipboard_text() -> tuple[bool, str]:
    if not shutil.which("wl-paste"):
        return False, ""

    types = subprocess.run(
        ["wl-paste", "--list-types"],
        check=False,
        capture_output=True,
        text=True,
    )
    if types.returncode != 0 or "text/plain" not in types.stdout:
        return False, ""

    content = subprocess.run(
        ["wl-paste", "--no-newline"],
        check=True,
        capture_output=True,
        text=True,
    )
    return True, content.stdout


def restore_clipboard(has_text: bool, content: str) -> None:
    if not has_text or not shutil.which("wl-copy"):
        return

    subprocess.run(["wl-copy", content], check=True, text=True)


def set_clipboard_text(content: str) -> None:
    if not shutil.which("wl-copy"):
        return

    subprocess.run(["wl-copy", content], check=True, text=True)


def browser_command(pid: int) -> str | None:
    try:
        return os.readlink(f"/proc/{pid}/exe")
    except OSError:
        return shutil.which("google-chrome-stable") or shutil.which("google-chrome")


def looks_like_url(value: str) -> bool:
    if not value or any(ch in value for ch in ("\n", "\r", "\t")):
        return False

    return (
        "://" in value
        or value.startswith(("chrome://", "chrome-extension://", "about:", "view-source:"))
        or "." in value
    )


def capture_active_tab_url() -> str:
    sentinel = f"hypr-duplicate-tab-{random.randrange(1_000_000_000)}"
    set_clipboard_text(sentinel)

    for _ in range(3):
        send_shortcut("CTRL,L,activewindow")
        time.sleep(0.12)
        send_shortcut("CTRL,C,activewindow")

        deadline = time.monotonic() + 1.0
        while time.monotonic() < deadline:
            _, candidate = clipboard_text()
            candidate = candidate.strip()
            if candidate and candidate != sentinel and looks_like_url(candidate):
                send_shortcut(",ESCAPE,activewindow")
                return candidate
            time.sleep(0.05)

        time.sleep(0.1)

    send_shortcut(",ESCAPE,activewindow")
    return ""


def main() -> int:
    try:
        active = hyprctl_json("activewindow")
    except subprocess.CalledProcessError:
        notify("Could not read the active window.")
        return 1

    window_class = (active.get("class") or "").lower()
    if window_class not in SUPPORTED_WINDOW_CLASSES:
        notify("Focus a Chrome or Chromium window first.")
        return 1

    command = browser_command(active["pid"])
    if not command:
        notify("Could not find the browser executable.")
        return 1

    had_clipboard_text, original_clipboard = clipboard_text()

    try:
        copied_url = capture_active_tab_url()
        if not copied_url:
            notify("Could not read the active tab URL.")
            return 1

        subprocess.Popen(
            [command, "--new-window", copied_url],
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
            start_new_session=True,
        )
        return 0
    finally:
        restore_clipboard(had_clipboard_text, original_clipboard)


if __name__ == "__main__":
    raise SystemExit(main())
