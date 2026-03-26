#!/usr/bin/env python3

import json
import os
import socket
import subprocess
import sys
from typing import Any


EVENTS_TO_HANDLE = {
    "openwindow",
    "closewindow",
    "movewindow",
    "movewindowv2",
    "workspace",
    "workspacev2",
    "focusedmon",
    "focusedmonv2",
    "changefloatingmode",
}


def hyprctl_json(command: str) -> Any:
    result = subprocess.run(
        ["hyprctl", "-j", *command.split()],
        check=True,
        capture_output=True,
        text=True,
    )
    return json.loads(result.stdout)


def hyprctl(command: list[str]) -> None:
    subprocess.run(["hyprctl", *command], check=True, capture_output=True, text=True)


def active_scrolling_workspace_id() -> int | None:
    workspace = hyprctl_json("activeworkspace")
    if workspace.get("tiledLayout") != "scrolling":
        return None
    return workspace["id"]


def tiled_window_count(workspace_id: int) -> int:
    clients = hyprctl_json("clients")
    return sum(
        1
        for client in clients
        if client.get("workspace", {}).get("id") == workspace_id
        and not client.get("floating", False)
    )


def target_width(window_count: int) -> float | None:
    if window_count < 2:
        return None
    return max(0.1, round(1.0 / window_count, 6))


def apply_width() -> None:
    workspace_id = active_scrolling_workspace_id()
    if workspace_id is None:
        return

    window_count = tiled_window_count(workspace_id)
    width = target_width(window_count)
    if width is None:
        hyprctl(["dispatch", "layoutmsg", "fit all"])
        return

    hyprctl(["dispatch", "layoutmsg", f"colresize all {width}"])
    hyprctl(["dispatch", "layoutmsg", "fit all"])


def event_socket_path() -> str:
    runtime_dir = os.environ.get("XDG_RUNTIME_DIR")
    signature = os.environ.get("HYPRLAND_INSTANCE_SIGNATURE")
    if not runtime_dir or not signature:
        raise RuntimeError("Hyprland environment variables are not available")
    return os.path.join(runtime_dir, "hypr", signature, ".socket2.sock")


def main() -> int:
    try:
        apply_width()
        sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
        sock.connect(event_socket_path())
        buffer = ""

        while True:
            chunk = sock.recv(4096)
            if not chunk:
                return 0

            buffer += chunk.decode("utf-8", "replace")
            while "\n" in buffer:
                line, buffer = buffer.split("\n", 1)
                event_name = line.split(">>", 1)[0]
                if event_name in EVENTS_TO_HANDLE:
                    try:
                        apply_width()
                    except subprocess.CalledProcessError:
                        pass
    except KeyboardInterrupt:
        return 0
    except Exception as exc:
        print(f"hypr-scroll-width-sync: {exc}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    raise SystemExit(main())
