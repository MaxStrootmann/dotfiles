#!/usr/bin/env python3

import json
import os
import subprocess
import sys
from pathlib import Path
from typing import Any

WIDTH_RATIO = 2 / 5
STATE_FILE = Path(os.environ.get("XDG_RUNTIME_DIR", "/tmp")) / "hypr-toggle-nice-width.json"


def hyprctl_json(*args: str) -> Any:
    result = subprocess.run(
        ["hyprctl", "-j", *args],
        check=True,
        capture_output=True,
        text=True,
    )
    return json.loads(result.stdout)


def hyprctl(*args: str) -> None:
    subprocess.run(["hyprctl", *args], check=True, capture_output=True, text=True)


def load_state() -> dict[str, Any]:
    try:
        return json.loads(STATE_FILE.read_text())
    except (FileNotFoundError, json.JSONDecodeError):
        return {}


def save_state(state: dict[str, Any]) -> None:
    if state:
        STATE_FILE.write_text(json.dumps(state))
    else:
        STATE_FILE.unlink(missing_ok=True)


def active_window() -> dict[str, Any] | None:
    window = hyprctl_json("activewindow")
    if not window.get("address") or not window.get("mapped"):
        return None
    return window


def active_monitor(window: dict[str, Any]) -> dict[str, Any]:
    monitor_id = window.get("monitor")
    monitors = hyprctl_json("monitors")
    for monitor in monitors:
        if monitor.get("id") == monitor_id:
            return monitor
    raise RuntimeError(f"active monitor not found: {monitor_id}")


def restore(window: dict[str, Any], saved: dict[str, Any]) -> None:
    if saved.get("floating"):
        if not window.get("floating"):
            hyprctl("dispatch", "togglefloating", "active")
        x, y = saved["at"]
        width, height = saved["size"]
        hyprctl("dispatch", "resizeactive", "exact", str(width), str(height))
        hyprctl("dispatch", "moveactive", "exact", str(x), str(y))
    elif window.get("floating"):
        hyprctl("dispatch", "togglefloating", "active")


def apply_nice_width(window: dict[str, Any]) -> dict[str, Any]:
    monitor = active_monitor(window)
    width = int(round(monitor["width"] * WIDTH_RATIO))
    height = int(window["size"][1])
    x = int(round(monitor["x"] + (monitor["width"] - width) / 2))
    y = int(window["at"][1])

    # Keep the window vertically on-screen if the previous tiled geometry was tight.
    min_y = int(monitor["y"])
    max_y = int(monitor["y"] + monitor["height"] - height)
    y = max(min_y, min(y, max_y))

    saved = {
        "floating": bool(window.get("floating")),
        "at": window["at"],
        "size": window["size"],
    }

    if not window.get("floating"):
        hyprctl("dispatch", "togglefloating", "active")

    hyprctl("dispatch", "resizeactive", "exact", str(width), str(height))
    hyprctl("dispatch", "moveactive", "exact", str(x), str(y))
    return saved


def main() -> int:
    try:
        window = active_window()
        if window is None:
            return 0

        address = window["address"]
        state = load_state()

        if address in state:
            restore(window, state.pop(address))
        else:
            state[address] = apply_nice_width(window)

        save_state(state)
        return 0
    except Exception as exc:
        print(f"hypr-toggle-nice-width: {exc}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    raise SystemExit(main())
