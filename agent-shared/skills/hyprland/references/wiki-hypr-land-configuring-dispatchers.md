# Source

- URL: https://wiki.hypr.land/Configuring/Dispatchers/
- Retrieved: 2026-03-05T12:11:40+01:00

<div id="content"
class="hx:w-full hx:min-w-0 hextra-max-content-width hx:px-6 hx:pt-4 hx:md:px-12"
role="main">

<div class="hx:mt-1.5 hx:flex hx:items-center hx:gap-1 hx:overflow-hidden hx:text-sm hx:text-gray-500 hx:dark:text-gray-400 hx:contrast-more:text-current">

<div class="hx:whitespace-nowrap hx:transition-colors hx:min-w-[24px] hx:overflow-hidden hx:text-ellipsis hx:hover:text-gray-900 hx:dark:hover:text-gray-100">

<a href="/Configuring/"
class="hx:inline-block hx:rounded-sm hx:hextra-focus-visible-inset">Configuring</a>

</div>

<img
src="data:image/svg+xml;base64,PHN2ZyBjbGFzcz0iaHg6dy0zLjUgaHg6c2hyaW5rLTAgaHg6cnRsOi1yb3RhdGUtMTgwIiBmaWxsPSJub25lIiB2aWV3Ym94PSIwIDAgMjQgMjQiIHN0cm9rZS13aWR0aD0iMiIgc3Ryb2tlPSJjdXJyZW50Q29sb3IiIGFyaWEtaGlkZGVuPSJ0cnVlIj48cGF0aCBzdHJva2UtbGluZWNhcD0icm91bmQiIHN0cm9rZS1saW5lam9pbj0icm91bmQiIGQ9Ik05IDVsNyA3LTcgNyIgLz48L3N2Zz4="
class="hx:w-3.5 hx:shrink-0 hx:rtl:-rotate-180" />

<div class="hx:whitespace-nowrap hx:transition-colors hx:font-medium hx:text-gray-700 hx:contrast-more:font-bold hx:contrast-more:text-current hx:dark:text-gray-100 hx:contrast-more:dark:text-current">

Dispatchers

</div>

</div>

<div class="content">

<div class="hx:flex hx:flex-col hx:sm:flex-row hx:items-start hx:sm:items-center hx:sm:justify-between hx:gap-4 hx:mb-4">

# Dispatchers

</div>

Please keep in mind some layout-specific dispatchers will be listed in
the layout pages (See the sidebar).

## Parameter explanation<span id="parameter-explanation" class="hx:absolute hx:-mt-20"></span> <a href="#parameter-explanation" class="subheading-anchor"
aria-label="Permalink for this section"></a>

| Param type | Description |
|----|----|
| window | a window. Any of the following: class regex (by default, optionally `class:`), `initialclass:` initial class regex, `title:` title regex, `initialtitle` initial title regex, `tag:` window tag regex, `pid:` the pid, `address:` the address, `activewindow` an active window, `floating` the first floating window on the current workspace, `tiled` the first tiled window on the current workspace |
| workspace | see [below](#workspaces). |
| direction | `l` `r` `u` `d` left right up down |
| monitor | One of: direction, ID, name, `current`, relative (e.g. `+1` or `-1`) |
| resizeparams | relative pixel delta vec2 (e.g. `10 -10`), optionally a percentage of the window size (e.g. `20 25%`) or `exact` followed by an exact vec2 (e.g. `exact 1280 720`), optionally a percentage of the screen size (e.g. `exact 50% 50%`) |
| floatvalue | a relative float delta (e.g `-0.2` or `+0.2`) or `exact` followed by a the exact float value (e.g. `exact 0.5`) |
| zheight | `top` or `bottom` |
| mod | `SUPER`, `SUPER_ALT`, etc. |
| key | `g`, `code:42`, `42` or mouse clicks (`mouse:272`) |

## List of Dispatchers<span id="list-of-dispatchers" class="hx:absolute hx:-mt-20"></span> <a href="#list-of-dispatchers" class="subheading-anchor"
aria-label="Permalink for this section"></a>

| Dispatcher | Description | Params |
|----|----|----|
| exec | executes a shell command | command (supports rules, see [below](#executing-with-rules)) |
| execr | executes a raw shell command (does not support rules) | command |
| pass | passes the key (with mods) to a specified window. Can be used as a workaround to global keybinds not working on Wayland. | window |
| sendshortcut | sends specified keys (with mods) to an optionally specified window. Can be used like pass | mod, key\[, window\] |
| sendkeystate | Send a key with specific state (down/repeat/up) to a specified window (window must keep focus for events to continue). | mod, key, state, window |
| killactive | closes (not kills) the active window | none |
| forcekillactive | kills the active window | none |
| closewindow | closes a specified window | window |
| killwindow | kills a specified window | window |
| signal | sends a signal to the active window | signal |
| signalwindow | sends a signal to a specified window | `window,signal`, e.g.`class:Alacritty,9` |
| workspace | changes the workspace | workspace |
| movetoworkspace | moves the focused window to a workspace | workspace OR `workspace,window` for a specific window |
| movetoworkspacesilent | same as above, but doesn’t switch to the workspace | workspace OR `workspace,window` for a specific window |
| togglefloating | toggles the current window’s floating state | left empty / `active` for current, or `window` for a specific window |
| setfloating | sets the current window’s floating state to true | left empty / `active` for current, or `window` for a specific window |
| settiled | sets the current window’s floating state to false | left empty / `active` for current, or `window` for a specific window |
| fullscreen | sets the focused window’s fullscreen mode | `mode action`, where mode can be 0 - fullscreen (takes your entire screen) or 1 - maximize (keeps gaps and bar(s)), while action is optional and can be `toggle` (default), `set` or `unset`. |
| fullscreenstate | sets the focused window’s fullscreen mode and the one sent to the client | `internal client action`, where internal (the hyprland window) and client (the application) can be `-1` - current, `0` - none, `1` - maximize, `2` - fullscreen, `3` - maximize and fullscreen. action is optional and can be `toggle` (default) or `set`. |
| dpms | sets all monitors’ DPMS status. Do not use with a keybind directly. | `on`, `off`, or `toggle`. For specific monitor add monitor name after a space |
| forceidle | sets elapsed time for all idle timers, ignoring idle inhibitors. Timers return to normal behavior upon the next activity. Do not use with a keybind directly. | floatvalue (number of seconds) |
| pin | pins a window (i.e. show it on all workspaces) *note: floating only* | left empty / `active` for current, or `window` for a specific window |
| movefocus | moves the focus in a direction | direction |
| movewindow | moves the active window in a direction or to a monitor. For floating windows, moves the window to the screen edge in that direction | direction or `mon:` and a monitor, optionally followed by a space and `silent` to prevent the focus from moving with the window |
| swapwindow | swaps the active window with another window in the given direction or with a specific window | direction or `window` |
| centerwindow | center the active window *note: floating only* | none (for monitor center) or 1 (to respect monitor reserved area) |
| resizeactive | resizes the active window | resizeparams |
| moveactive | moves the active window | resizeparams |
| resizewindowpixel | resizes a selected window | `resizeparams,window`, e.g. `100 100,^(kitty)$` |
| movewindowpixel | moves a selected window | `resizeparams,window` |
| cyclenext | focuses the next window (on a workspace, if `visible` is not provided) | none (for next) or `prev` (for previous) additionally `tiled` for only tiled, `floating` for only floating. `prev tiled` is ok. `visible` for all monitors cycling. `visible prev floating` is ok. if `hist` arg provided - focus order will depends on focus history. All other modifiers is also working for it, `visible next floating hist` is ok. |
| swapnext | swaps the focused window with the next window on a workspace | none (for next) or `prev` (for previous) |
| tagwindow | apply tag to current or the first window matching | `tag [window]`, e.g. `+code ^(foot)$`, `music` |
| focuswindow | focuses the first window matching | window |
| focusmonitor | focuses a monitor | monitor |
| movecursortocorner | moves the cursor to the corner of the active window | direction, 0 - 3, bottom left - 0, bottom right - 1, top right - 2, top left - 3 |
| movecursor | moves the cursor to a specified position | `x y` |
| renameworkspace | rename a workspace | `id name`, e.g. `2 work` |
| exit | exits the compositor with no questions asked. It’s recommended to use `hyprshutdown` instead of this. | none |
| forcerendererreload | forces the renderer to reload all resources and outputs | none |
| movecurrentworkspacetomonitor | Moves the active workspace to a monitor | monitor |
| focusworkspaceoncurrentmonitor | Focuses the requested workspace on the current monitor, swapping the current workspace to a different monitor if necessary. If you want XMonad/Qtile-style workspace switching, replace `workspace` in your config with this. | workspace |
| moveworkspacetomonitor | Moves a workspace to a monitor | workspace and a monitor separated by a space |
| swapactiveworkspaces | Swaps the active workspaces between two monitors | two monitors separated by a space |
| bringactivetotop | *Deprecated* in favor of alterzorder. Brings the current window to the top of the stack | none |
| alterzorder | Modify the window stack order of the active or specified window. Note: this cannot be used to move a floating window behind a tiled one. | zheight\[,window\] |
| togglespecialworkspace | toggles a special workspace on/off | none (for the first) or name for named (name has to be a special workspace’s name) |
| focusurgentorlast | Focuses the urgent window or the last window | none |
| togglegroup | toggles the current active window into a group | none |
| changegroupactive | switches to the next window in a group. | b - back, f - forward, or index start at 1 |
| focuscurrentorlast | Switch focus from current to previously focused window | none |
| lockgroups | Locks the groups (all groups will not accept new windows) | `lock` for locking, `unlock` for unlocking, `toggle` for toggle |
| lockactivegroup | Lock the focused group (the current group will not accept new windows or be moved to other groups) | `lock` for locking, `unlock` for unlocking, `toggle` for toggle |
| moveintogroup | Moves the active window into a group in a specified direction. No-op if there is no group in the specified direction. | direction |
| moveoutofgroup | Moves the active window out of a group. No-op if not in a group | left empty / `active` for current, or `window` for a specific window |
| movewindoworgroup | Behaves as `moveintogroup` if there is a group in the given direction. Behaves as `moveoutofgroup` if there is no group in the given direction relative to the active group. Otherwise behaves like `movewindow`. | direction |
| movegroupwindow | Swaps the active window with the next or previous in a group | `b` for back, anything else for forward |
| denywindowfromgroup | Prohibit the active window from becoming or being inserted into group | `on`, `off` or, `toggle` |
| setignoregrouplock | Temporarily enable or disable binds:ignore_group_lock | `on`, `off`, or `toggle` |
| global | Executes a Global Shortcut using the GlobalShortcuts portal. See [here](../Binds/#global-keybinds) | name |
| submap | Change the current mapping group. See [Submaps](../Binds/#submaps) | `reset` or name |
| event | Emits a custom event to socket2 in the form of `custom>>yourdata` | the data to send |
| setprop | Sets a window property | `window property value` |
| toggleswallow | If a window is swallowed by the focused window, unswallows it. Execute again to swallow it back | none |

<div class="hx:overflow-x-auto hx:mt-6 hx:flex hx:flex-col hx:rounded-lg hx:border hx:py-4 hx:px-4 hx:border-gray-200 hx:contrast-more:border-current hx:contrast-more:dark:border-current hx:border-amber-200 hx:bg-amber-100 hx:text-amber-900 hx:dark:border-amber-200/30 hx:dark:bg-amber-900/30 hx:dark:text-amber-200">

<img
src="data:image/svg+xml;base64,PHN2ZyBoZWlnaHQ9IjE2IiBjbGFzcz0iaHg6aW5saW5lLWJsb2NrIGh4OmFsaWduLW1pZGRsZSBoeDptci0yIiBmaWxsPSJub25lIiB2aWV3Ym94PSIwIDAgMjQgMjQiIHN0cm9rZS13aWR0aD0iMiIgc3Ryb2tlPSJjdXJyZW50Q29sb3IiIGFyaWEtaGlkZGVuPSJ0cnVlIj48cGF0aCBzdHJva2UtbGluZWNhcD0icm91bmQiIHN0cm9rZS1saW5lam9pbj0icm91bmQiIGQ9Ik0xMiA5djJtMCA0aC4wMW0tNi45MzggNGgxMy44NTZjMS41NC4wIDIuNTAyLTEuNjY3IDEuNzMyLTNMMTMuNzMyIDRjLS43Ny0xLjMzMy0yLjY5NC0xLjMzMy0zLjQ2NC4wTDMuMzQgMTZjLS43NyAxLjMzMy4xOTIgMyAxLjczMiAzeiIgLz48L3N2Zz4="
class="hx:inline-block hx:align-middle hx:mr-2" />Warning

<div class="hx:w-full hx:min-w-0 hx:leading-7">

<div class="hx:mt-6 hx:leading-7 hx:first:mt-0">

[uwsm](../../Useful-Utilities/Systemd-start) users should avoid using
`exit` dispatcher, or terminating Hyprland process directly, as exiting
Hyprland this way removes it from under its clients and interferes with
ordered shutdown sequence. Use `exec, uwsm stop` (or
<a href="https://github.com/Vladimir-csp/uwsm#how-to-stop"
target="_blank" rel="noopener">other variants</a>) which will gracefully
bring down graphical session (and login session bound to it, if any). If
you experience problems with units entering inconsistent states,
affecting subsequent sessions, use `exec, loginctl terminate-user ""`
instead (terminates all units of the user).

It’s also strongly advised to replace the `exit` dispatcher inside
`hyprland.conf` keybinds section accordingly.

</div>

</div>

</div>

<div class="hx:overflow-x-auto hx:mt-6 hx:flex hx:flex-col hx:rounded-lg hx:border hx:py-4 hx:px-4 hx:border-gray-200 hx:contrast-more:border-current hx:contrast-more:dark:border-current hx:border-amber-200 hx:bg-amber-100 hx:text-amber-900 hx:dark:border-amber-200/30 hx:dark:bg-amber-900/30 hx:dark:text-amber-200">

<img
src="data:image/svg+xml;base64,PHN2ZyBoZWlnaHQ9IjE2IiBjbGFzcz0iaHg6aW5saW5lLWJsb2NrIGh4OmFsaWduLW1pZGRsZSBoeDptci0yIiBmaWxsPSJub25lIiB2aWV3Ym94PSIwIDAgMjQgMjQiIHN0cm9rZS13aWR0aD0iMiIgc3Ryb2tlPSJjdXJyZW50Q29sb3IiIGFyaWEtaGlkZGVuPSJ0cnVlIj48cGF0aCBzdHJva2UtbGluZWNhcD0icm91bmQiIHN0cm9rZS1saW5lam9pbj0icm91bmQiIGQ9Ik0xMiA5djJtMCA0aC4wMW0tNi45MzggNGgxMy44NTZjMS41NC4wIDIuNTAyLTEuNjY3IDEuNzMyLTNMMTMuNzMyIDRjLS43Ny0xLjMzMy0yLjY5NC0xLjMzMy0zLjQ2NC4wTDMuMzQgMTZjLS43NyAxLjMzMy4xOTIgMyAxLjczMiAzeiIgLz48L3N2Zz4="
class="hx:inline-block hx:align-middle hx:mr-2" />Warning

<div class="hx:w-full hx:min-w-0 hx:leading-7">

<div class="hx:mt-6 hx:leading-7 hx:first:mt-0">

It is NOT recommended to set DPMS or forceidle with a keybind directly,
as it might cause undefined behavior. Instead, consider something like

<div class="hextra-code-block hx:relative hx:mt-6 hx:first:mt-0 hx:group/code">

<div>

<div class="highlight">

``` chroma
bind = MOD, KEY, exec, sleep 1 && hyprctl dispatch dpms off
```

</div>

</div>

<div class="hextra-code-copy-btn-container hx:opacity-0 hx:transition hx:group-hover/code:opacity-100 hx:flex hx:gap-1 hx:absolute hx:m-[11px] hx:right-0 hx:top-0">

<div class="hextra-copy-icon hx:group-[.copied]/copybtn:hidden hx:pointer-events-none hx:h-4 hx:w-4">

</div>

<div class="hextra-success-icon hx:hidden hx:group-[.copied]/copybtn:block hx:pointer-events-none hx:h-4 hx:w-4">

</div>

</div>

</div>

</div>

</div>

</div>

### Grouped (tabbed) windows<span id="grouped-tabbed-windows" class="hx:absolute hx:-mt-20"></span> <a href="#grouped-tabbed-windows" class="subheading-anchor"
aria-label="Permalink for this section"></a>

Hyprland allows you to make a group from the current active window with
the `togglegroup` bind dispatcher.

A group is like i3wm’s “tabbed” container. It takes the space of one
window, and you can change the window to the next one in the tabbed
“group” with the `changegroupactive` bind dispatcher.

The new group’s border colors are configurable with the appropriate
`col.` settings in the `group` config section.

You can lock a group with the `lockactivegroup` dispatcher in order to
stop new windows from entering this group. In addition, the `lockgroups`
dispatcher can be used to toggle an independent global group lock that
will prevent new windows from entering any groups, regardless of their
local group lock stat.

You can prevent a window from being added to a group or becoming a group
with the `denywindowfromgroup` dispatcher. `movewindoworgroup` will
behave like `movewindow` if the current active window or window in
direction has this property set.

## Workspaces<span id="workspaces" class="hx:absolute hx:-mt-20"></span> <a href="#workspaces" class="subheading-anchor"
aria-label="Permalink for this section"></a>

You have nine choices:

- ID: e.g. `1`, `2`, or `3`

- Relative ID: e.g. `+1`, `-3` or `+100`

- workspace on monitor, relative with `+` or `-`, absolute with `~`:
  e.g. `m+1`, `m-2` or `m~3`

- workspace on monitor including empty workspaces, relative with `+` or
  `-`, absolute with `~`: e.g. `r+1` or `r~3`

- open workspace, relative with `+` or `-`, absolute with `~`: e.g.
  `e+1`, `e-10`, or `e~2`

- Name: e.g. `name:Web`, `name:Anime` or `name:Better anime`

- Previous workspace: `previous`, or `previous_per_monitor`

- First available empty workspace: `empty`, suffix with `m` to only
  search on monitor. and/or `n` to make it the *next* available empty
  workspace. e.g. `emptynm`

- Special Workspace: `special` or `special:name` for named special
  workspaces.

<div class="hx:overflow-x-auto hx:mt-6 hx:flex hx:flex-col hx:rounded-lg hx:border hx:py-4 hx:px-4 hx:border-gray-200 hx:contrast-more:border-current hx:contrast-more:dark:border-current hx:border-amber-200 hx:bg-amber-100 hx:text-amber-900 hx:dark:border-amber-200/30 hx:dark:bg-amber-900/30 hx:dark:text-amber-200">

<img
src="data:image/svg+xml;base64,PHN2ZyBoZWlnaHQ9IjE2IiBjbGFzcz0iaHg6aW5saW5lLWJsb2NrIGh4OmFsaWduLW1pZGRsZSBoeDptci0yIiBmaWxsPSJub25lIiB2aWV3Ym94PSIwIDAgMjQgMjQiIHN0cm9rZS13aWR0aD0iMiIgc3Ryb2tlPSJjdXJyZW50Q29sb3IiIGFyaWEtaGlkZGVuPSJ0cnVlIj48cGF0aCBzdHJva2UtbGluZWNhcD0icm91bmQiIHN0cm9rZS1saW5lam9pbj0icm91bmQiIGQ9Ik0xMiA5djJtMCA0aC4wMW0tNi45MzggNGgxMy44NTZjMS41NC4wIDIuNTAyLTEuNjY3IDEuNzMyLTNMMTMuNzMyIDRjLS43Ny0xLjMzMy0yLjY5NC0xLjMzMy0zLjQ2NC4wTDMuMzQgMTZjLS43NyAxLjMzMy4xOTIgMyAxLjczMiAzeiIgLz48L3N2Zz4="
class="hx:inline-block hx:align-middle hx:mr-2" />Warning

<div class="hx:w-full hx:min-w-0 hx:leading-7">

<div class="hx:mt-6 hx:leading-7 hx:first:mt-0">

`special` is supported ONLY on `movetoworkspace` and
`movetoworkspacesilent`.  
Any other dispatcher will result in undocumented behavior.

</div>

</div>

</div>

<div class="hx:overflow-x-auto hx:mt-6 hx:flex hx:flex-col hx:rounded-lg hx:border hx:py-4 hx:px-4 hx:border-gray-200 hx:contrast-more:border-current hx:contrast-more:dark:border-current hx:border-amber-200 hx:bg-amber-100 hx:text-amber-900 hx:dark:border-amber-200/30 hx:dark:bg-amber-900/30 hx:dark:text-amber-200">

<img
src="data:image/svg+xml;base64,PHN2ZyBoZWlnaHQ9IjE2IiBjbGFzcz0iaHg6aW5saW5lLWJsb2NrIGh4OmFsaWduLW1pZGRsZSBoeDptci0yIiBmaWxsPSJub25lIiB2aWV3Ym94PSIwIDAgMjQgMjQiIHN0cm9rZS13aWR0aD0iMiIgc3Ryb2tlPSJjdXJyZW50Q29sb3IiIGFyaWEtaGlkZGVuPSJ0cnVlIj48cGF0aCBzdHJva2UtbGluZWNhcD0icm91bmQiIHN0cm9rZS1saW5lam9pbj0icm91bmQiIGQ9Ik0xMiA5djJtMCA0aC4wMW0tNi45MzggNGgxMy44NTZjMS41NC4wIDIuNTAyLTEuNjY3IDEuNzMyLTNMMTMuNzMyIDRjLS43Ny0xLjMzMy0yLjY5NC0xLjMzMy0zLjQ2NC4wTDMuMzQgMTZjLS43NyAxLjMzMy4xOTIgMyAxLjczMiAzeiIgLz48L3N2Zz4="
class="hx:inline-block hx:align-middle hx:mr-2" />Warning

<div class="hx:w-full hx:min-w-0 hx:leading-7">

<div class="hx:mt-6 hx:leading-7 hx:first:mt-0">

Numerical workspaces (e.g. `1`, `2`, `13371337`) are allowed **ONLY**
between 1 and 2147483647 (inclusive).  
Neither `0` nor negative numbers are allowed.

</div>

</div>

</div>

## Special Workspace<span id="special-workspace" class="hx:absolute hx:-mt-20"></span> <a href="#special-workspace" class="subheading-anchor"
aria-label="Permalink for this section"></a>

A special workspace is what is called a “scratchpad” in some other
places. A workspace that you can toggle on/off on any monitor.

<div class="hx:overflow-x-auto hx:mt-6 hx:flex hx:flex-col hx:rounded-lg hx:border hx:py-4 hx:px-4 hx:border-gray-200 hx:contrast-more:border-current hx:contrast-more:dark:border-current hx:border-blue-200 hx:bg-blue-100 hx:text-blue-900 hx:dark:border-blue-200/30 hx:dark:bg-blue-900/30 hx:dark:text-blue-200">

<img
src="data:image/svg+xml;base64,PHN2ZyBoZWlnaHQ9IjE2IiBjbGFzcz0iaHg6aW5saW5lLWJsb2NrIGh4OmFsaWduLW1pZGRsZSBoeDptci0yIiBmaWxsPSJub25lIiB2aWV3Ym94PSIwIDAgMjQgMjQiIHN0cm9rZS13aWR0aD0iMiIgc3Ryb2tlPSJjdXJyZW50Q29sb3IiIGFyaWEtaGlkZGVuPSJ0cnVlIj48cGF0aCBzdHJva2UtbGluZWNhcD0icm91bmQiIHN0cm9rZS1saW5lam9pbj0icm91bmQiIGQ9Ik0xMyAxNmgtMXYtNGgtMW0xLTRoLjAxTTIxIDEyQTkgOSAwIDExMyAxMmE5IDkgMCAwMTE4IDB6IiAvPjwvc3ZnPg=="
class="hx:inline-block hx:align-middle hx:mr-2" />Note

<div class="hx:w-full hx:min-w-0 hx:leading-7">

<div class="hx:mt-6 hx:leading-7 hx:first:mt-0">

You can define multiple named special workspaces, but the amount of
those is limited to 97 at a time.

</div>

</div>

</div>

For example, to move a window/application to a special workspace you can
use the following syntax:

<div class="hextra-code-block hx:relative hx:mt-6 hx:first:mt-0 hx:group/code">

<div>

<div class="highlight">

``` chroma
bind = SUPER, C, movetoworkspace, special
#The above syntax will move the window to a special workspace upon pressing 'SUPER'+'C'.
#To see the hidden window you can use the togglespecialworkspace dispatcher mentioned above.
```

</div>

</div>

<div class="hextra-code-copy-btn-container hx:opacity-0 hx:transition hx:group-hover/code:opacity-100 hx:flex hx:gap-1 hx:absolute hx:m-[11px] hx:right-0 hx:top-0">

<div class="hextra-copy-icon hx:group-[.copied]/copybtn:hidden hx:pointer-events-none hx:h-4 hx:w-4">

</div>

<div class="hextra-success-icon hx:hidden hx:group-[.copied]/copybtn:block hx:pointer-events-none hx:h-4 hx:w-4">

</div>

</div>

</div>

## Executing with rules<span id="executing-with-rules" class="hx:absolute hx:-mt-20"></span> <a href="#executing-with-rules" class="subheading-anchor"
aria-label="Permalink for this section"></a>

The `exec` dispatcher supports adding rules. Please note some windows
might work better, some worse. It records the PID of the spawned process
and uses that. For example, if your process forks and then the fork
opens a window, this will not work.

The syntax is:

<div class="hextra-code-block hx:relative hx:mt-6 hx:first:mt-0 hx:group/code">

<div>

<div class="highlight">

``` chroma
bind = mod, key, exec, [rules...] command
```

</div>

</div>

<div class="hextra-code-copy-btn-container hx:opacity-0 hx:transition hx:group-hover/code:opacity-100 hx:flex hx:gap-1 hx:absolute hx:m-[11px] hx:right-0 hx:top-0">

<div class="hextra-copy-icon hx:group-[.copied]/copybtn:hidden hx:pointer-events-none hx:h-4 hx:w-4">

</div>

<div class="hextra-success-icon hx:hidden hx:group-[.copied]/copybtn:block hx:pointer-events-none hx:h-4 hx:w-4">

</div>

</div>

</div>

For example:

<div class="hextra-code-block hx:relative hx:mt-6 hx:first:mt-0 hx:group/code">

<div>

<div class="highlight">

``` chroma
bind = SUPER, E, exec, [workspace 2 silent; float; move 0 0] kitty
```

</div>

</div>

<div class="hextra-code-copy-btn-container hx:opacity-0 hx:transition hx:group-hover/code:opacity-100 hx:flex hx:gap-1 hx:absolute hx:m-[11px] hx:right-0 hx:top-0">

<div class="hextra-copy-icon hx:group-[.copied]/copybtn:hidden hx:pointer-events-none hx:h-4 hx:w-4">

</div>

<div class="hextra-success-icon hx:hidden hx:group-[.copied]/copybtn:block hx:pointer-events-none hx:h-4 hx:w-4">

</div>

</div>

</div>

### setprop<span id="setprop" class="hx:absolute hx:-mt-20"></span> <a href="#setprop" class="subheading-anchor"
aria-label="Permalink for this section"></a>

Props are any of the *dynamic effects* of [Window
Rules](../Window-Rules#dynamic-effects).

For example:

<div class="hextra-code-block hx:relative hx:mt-6 hx:first:mt-0 hx:group/code">

<div>

<div class="highlight">

``` chroma
address:0x13371337 no_anim 1
address:0x13371337 no_max_size 0
address:0x13371337 opaque toggle
address:0x13371337 immediate unset
address:0x13371337 border_size relative -2
address:0x13371337 rounding_power relative 0.1
```

</div>

</div>

<div class="hextra-code-copy-btn-container hx:opacity-0 hx:transition hx:group-hover/code:opacity-100 hx:flex hx:gap-1 hx:absolute hx:m-[11px] hx:right-0 hx:top-0">

<div class="hextra-copy-icon hx:group-[.copied]/copybtn:hidden hx:pointer-events-none hx:h-4 hx:w-4">

</div>

<div class="hextra-success-icon hx:hidden hx:group-[.copied]/copybtn:block hx:pointer-events-none hx:h-4 hx:w-4">

</div>

</div>

</div>

Some props are expanded from their window rule parents which take
multiple arguments:

- `border_color` -\> `active_border_color`, `inactive_border_color`
- `opacity` -\> `opacity`, `opacity_inactive`, `opacity_fullscreen`,
  `opacity_override`, `opacity_inactive_override`,
  `opacity_fullscreen_override`

### Fullscreenstate<span id="fullscreenstate" class="hx:absolute hx:-mt-20"></span> <a href="#fullscreenstate" class="subheading-anchor"
aria-label="Permalink for this section"></a>

`fullscreenstate internal client`

The `fullscreenstate` dispatcher decouples the state that Hyprland
maintains for a window from the fullscreen state that is communicated to
the client.

`internal` is a reference to the state maintained by Hyprland.

`client` is a reference to the state that the application receives.

| Value | State | Description |
|----|----|----|
| -1 | Current | Maintains the current fullscreen state. |
| 0 | None | Window allocates the space defined by the current layout. |
| 1 | Maximize | Window takes up the entire working space, keeping the margins. |
| 2 | Fullscreen | Window takes up the entire screen. |
| 3 | Maximize and Fullscreen | The state of a fullscreened maximized window. Works the same as fullscreen. |

For example:

`fullscreenstate 2 0` Fullscreens the application and keeps the client
in non-fullscreen mode.

This can be used to prevent Chromium-based browsers from going into
presentation mode when they detect they have been fullscreened.

`fullscreenstate 0 2` Keeps the window non-fullscreen, but the client
goes into fullscreen mode within the window.

</div>

<div class="hx:mt-12 hx:mb-8 hx:block hx:text-xs hx:text-gray-500 hx:ltr:text-right hx:rtl:text-left hx:dark:text-gray-400">

Last updated on March 3, 2026

</div>

<div class="hx:mb-8 hx:flex hx:items-center hx:border-t hx:pt-8 hx:border-gray-200 hx:dark:border-neutral-800 hx:contrast-more:border-neutral-400 hx:dark:contrast-more:border-neutral-400 hx:print:hidden">

<a href="/Configuring/Binds/"
class="hx:flex hx:max-w-[50%] hx:items-center hx:gap-1 hx:py-4 hx:text-base hx:font-medium hx:text-gray-600 hx:transition-colors [word-break:break-word] hx:hover:text-primary-600 hx:dark:text-gray-300 hx:md:text-lg hx:ltr:pr-4 hx:rtl:pl-4"
title="Binds"><img
src="data:image/svg+xml;base64,PHN2ZyBjbGFzcz0iaHg6aW5saW5lIGh4OmgtNSBoeDpzaHJpbmstMCBoeDpsdHI6cm90YXRlLTE4MCIgZmlsbD0ibm9uZSIgdmlld2JveD0iMCAwIDI0IDI0IiBzdHJva2Utd2lkdGg9IjIiIHN0cm9rZT0iY3VycmVudENvbG9yIiBhcmlhLWhpZGRlbj0idHJ1ZSI+PHBhdGggc3Ryb2tlLWxpbmVjYXA9InJvdW5kIiBzdHJva2UtbGluZWpvaW49InJvdW5kIiBkPSJNOSA1bDcgNy03IDciIC8+PC9zdmc+"
class="hx:inline hx:h-5 hx:shrink-0 hx:ltr:rotate-180" />Binds</a><a href="/Configuring/Window-Rules/"
class="hx:flex hx:max-w-[50%] hx:items-center hx:gap-1 hx:py-4 hx:text-base hx:font-medium hx:text-gray-600 hx:transition-colors [word-break:break-word] hx:hover:text-primary-600 hx:dark:text-gray-300 hx:md:text-lg hx:ltr:ml-auto hx:ltr:pl-4 hx:ltr:text-right hx:rtl:mr-auto hx:rtl:pr-4 hx:rtl:text-left"
title="Window Rules">Window Rules<img
src="data:image/svg+xml;base64,PHN2ZyBjbGFzcz0iaHg6aW5saW5lIGh4OmgtNSBoeDpzaHJpbmstMCBoeDpydGw6LXJvdGF0ZS0xODAiIGZpbGw9Im5vbmUiIHZpZXdib3g9IjAgMCAyNCAyNCIgc3Ryb2tlLXdpZHRoPSIyIiBzdHJva2U9ImN1cnJlbnRDb2xvciIgYXJpYS1oaWRkZW49InRydWUiPjxwYXRoIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIgZD0iTTkgNWw3IDctNyA3IiAvPjwvc3ZnPg=="
class="hx:inline hx:h-5 hx:shrink-0 hx:rtl:-rotate-180" /></a>

</div>

</div>
