# Codex CLI Troubleshooting

## Image paste fails in Codex CLI (Ghostty)

### Symptoms

- Text paste in Codex works with `Ctrl+V`.
- Image paste in Codex fails or does not trigger image attach.
- `wl-paste --list-types` shows `image/png`.
- Same workflow works in Alacritty but not Ghostty.

### Root cause

Ghostty was intercepting `Ctrl+V` at terminal level:

```ini
keybind = control+v=paste_from_clipboard
```

That prevents Codex from reliably receiving the `Ctrl+V` key event used for image-attach handling.

### Fix

Use terminal paste on `Ctrl+Shift+V` instead, and leave `Ctrl+V` for apps:

```ini
keybind = control+shift+v=paste_from_clipboard
```

Applied in:

- `~/.config/ghostty/config`

### Reload

- Ghostty command palette: `Ctrl+Shift+P` -> `Reload Config`
- Or fully restart Ghostty.
