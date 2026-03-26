# Source

- URL: https://wiki.hypr.land/Configuring/Master-Layout/
- Retrieved: 2026-03-05T12:11:39+01:00

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

Master Layout

</div>

</div>

<div class="content">

<div class="hx:flex hx:flex-col hx:sm:flex-row hx:items-start hx:sm:items-center hx:sm:justify-between hx:gap-4 hx:mb-4">

# Master Layout

</div>

The master layout makes one (or more) window(s) be the “master”, taking
(by default) the left part of the screen, and tiles the rest on the
right. You can change the orientation on a per-workspace basis if you
want to use anything other than the default left/right split.

<img
src="https://user-images.githubusercontent.com/43317083/179357849-321f042c-f536-44b3-9e6f-371df5321836.gif"
loading="lazy" alt="master1" />

## Config<span id="config" class="hx:absolute hx:-mt-20"></span> <a href="#config" class="subheading-anchor"
aria-label="Permalink for this section"></a>

*category name `master`*

| name | description | type | default |
|----|----|----|----|
| allow_small_split | enable adding additional master windows in a horizontal split style | bool | false |
| special_scale_factor | the scale of the special workspace windows. \[0.0 - 1.0\] | float | 1 |
| mfact | the size as a percentage of the master window, for example `mfact = 0.70` would mean 70% of the screen will be the master window, and 30% the slave \[0.0 - 1.0\] | floatvalue | 0.55 |
| new_status | `master`: new window becomes master; `slave`: new windows are added to slave stack; `inherit`: inherit from focused window | string | `slave` |
| new_on_top | whether a newly open window should be on the top of the stack | bool | false |
| new_on_active | `before`, `after`: place new window relative to the focused window; `none`: place new window according to the value of `new_on_top`. | string | `none` |
| orientation | default placement of the master area, can be left, right, top, bottom or center | string | left |
| slave_count_for_center_master | when using orientation=center, make the master window centered only when at least this many slave windows are open. (Set 0 to always_center_master) | int | 2 |
| center_master_fallback | Set fallback for center master when slaves are less than slave_count_for_center_master, can be left ,right ,top ,bottom | string | left |
| smart_resizing | if enabled, resizing direction will be determined by the mouse’s position on the window (nearest to which corner). Else, it is based on the window’s tiling position. | bool | true |
| drop_at_cursor | when enabled, dragging and dropping windows will put them at the cursor position. Otherwise, when dropped at the stack side, they will go to the top/bottom of the stack depending on new_on_top. | bool | true |
| always_keep_position | whether to keep the master window in its configured position when there are no slave windows | bool | false |

## Dispatchers<span id="dispatchers" class="hx:absolute hx:-mt-20"></span> <a href="#dispatchers" class="subheading-anchor"
aria-label="Permalink for this section"></a>

`layoutmsg` commands:

| command | description | params |
|----|----|----|
| swapwithmaster | swaps the current window with master. If the current window is the master, swaps it with the first child. | either `master` (new focus is the new master window), `child` (new focus is the new child) or `auto` (which is the default, keeps the focus of the previously focused window). Adding `ignoremaster` will ignore this dispatcher if master is already focused. |
| focusmaster | focuses the master window. | either `master` (focus stays on master), `auto` (default; focus first non-master window if already on master) or `previous` (remember current window when focusing master, if already on master, focus previous or fallback to `auto`). |
| cyclenext | focuses the next window respecting the layout | either `loop` (allow looping from the bottom of the pile back to master) or `noloop` (force stop at the bottom of the pile, like in DWM). `loop` is the default if left blank. |
| cycleprev | focuses the previous window respecting the layout | either `loop` (allow looping from master to the bottom of the pile) or `noloop` (force stop at master, like in DWM). `loop` is the default if left blank. |
| swapnext | swaps the focused window with the next window respecting the layout | either `loop` (allow swapping the bottom of the pile and master) or `noloop` (do not allow it, like in DWM). `loop` is the default if left blank. |
| swapprev | swaps the focused window with the previous window respecting the layout | either `loop` (allow swapping master and the bottom of the pile) or `noloop` (do not allow it, like in DWM). `loop` is the default if left blank. |
| addmaster | adds a master to the master side. That will be the active window, if it’s not a master, or the first non-master window. | none |
| removemaster | removes a master from the master side. That will be the active window, if it’s a master, or the last master window. | none |
| orientationleft | sets the orientation for the current workspace to left (master area left, slave windows to the right, vertically stacked) | none |
| orientationright | sets the orientation for the current workspace to right (master area right, slave windows to the left, vertically stacked) | none |
| orientationtop | sets the orientation for the current workspace to top (master area top, slave windows to the bottom, horizontally stacked) | none |
| orientationbottom | sets the orientation for the current workspace to bottom (master area bottom, slave windows to the top, horizontally stacked) | none |
| orientationcenter | sets the orientation for the current workspace to center (master area center, slave windows alternate to the left and right, vertically stacked) | none |
| orientationnext | cycle to the next orientation for the current workspace (clockwise) | none |
| orientationprev | cycle to the previous orientation for the current workspace (counter-clockwise) | none |
| orientationcycle | cycle to the next orientation from the provided list, for the current workspace | allowed values: `left`, `top`, `right`, `bottom`, or `center`. The values have to be separated by a space. If left empty, it will work like `orientationnext` |
| mfact | change mfact, the master split ratio | the new split ratio, a relative float delta (e.g `-0.2` or `+0.2`) or `exact` followed by a the exact float value between 0.0 and 1.0 |
| rollnext | rotate the next window in stack to be the master, while keeping the focus on master | none |
| rollprev | rotate the previous window in stack to be the master, while keeping the focus on master | none |

Parameters for the commands are separated by a single space.

<div class="hx:overflow-x-auto hx:mt-6 hx:flex hx:flex-col hx:rounded-lg hx:border hx:py-4 hx:px-4 hx:border-gray-200 hx:contrast-more:border-current hx:contrast-more:dark:border-current hx:border-blue-200 hx:bg-blue-100 hx:text-blue-900 hx:dark:border-blue-200/30 hx:dark:bg-blue-900/30 hx:dark:text-blue-200">

<img
src="data:image/svg+xml;base64,PHN2ZyBoZWlnaHQ9IjE2IiBjbGFzcz0iaHg6aW5saW5lLWJsb2NrIGh4OmFsaWduLW1pZGRsZSBoeDptci0yIiBmaWxsPSJub25lIiB2aWV3Ym94PSIwIDAgMjQgMjQiIHN0cm9rZS13aWR0aD0iMiIgc3Ryb2tlPSJjdXJyZW50Q29sb3IiIGFyaWEtaGlkZGVuPSJ0cnVlIj48cGF0aCBzdHJva2UtbGluZWNhcD0icm91bmQiIHN0cm9rZS1saW5lam9pbj0icm91bmQiIGQ9Ik0xMyAxNmgtMXYtNGgtMW0xLTRoLjAxTTIxIDEyQTkgOSAwIDExMyAxMmE5IDkgMCAwMTE4IDB6IiAvPjwvc3ZnPg=="
class="hx:inline-block hx:align-middle hx:mr-2" />Note

<div class="hx:w-full hx:min-w-0 hx:leading-7">

<div class="hx:mt-6 hx:leading-7 hx:first:mt-0">

Example usage:

<div class="hextra-code-block hx:relative hx:mt-6 hx:first:mt-0 hx:group/code">

<div>

<div class="highlight">

``` chroma
bind = MOD, KEY, layoutmsg, cyclenext
# behaves like xmonads promote feature (https://hackage.haskell.org/package/xmonad-contrib-0.17.1/docs/XMonad-Actions-Promote.html)
bind = MOD, KEY, layoutmsg, swapwithmaster master
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

## Workspace Rules<span id="workspace-rules" class="hx:absolute hx:-mt-20"></span> <a href="#workspace-rules" class="subheading-anchor"
aria-label="Permalink for this section"></a>

`layoutopt` rules:

| rule | description | type |
|----|----|----|
| orientation:\[o\] | Sets the orientation of a workspace. For available orientations, see [Config-\>orientation](#config) | string |

Example usage:

<div class="hextra-code-block hx:relative hx:mt-6 hx:first:mt-0 hx:group/code">

<div>

<div class="highlight">

``` chroma
workspace = 2, layoutopt:orientation:top
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

<div class="hx:mt-12 hx:mb-8 hx:block hx:text-xs hx:text-gray-500 hx:ltr:text-right hx:rtl:text-left hx:dark:text-gray-400">

Last updated on March 3, 2026

</div>

<div class="hx:mb-8 hx:flex hx:items-center hx:border-t hx:pt-8 hx:border-gray-200 hx:dark:border-neutral-800 hx:contrast-more:border-neutral-400 hx:dark:contrast-more:border-neutral-400 hx:print:hidden">

<a href="/Configuring/Dwindle-Layout/"
class="hx:flex hx:max-w-[50%] hx:items-center hx:gap-1 hx:py-4 hx:text-base hx:font-medium hx:text-gray-600 hx:transition-colors [word-break:break-word] hx:hover:text-primary-600 hx:dark:text-gray-300 hx:md:text-lg hx:ltr:pr-4 hx:rtl:pl-4"
title="Dwindle Layout"><img
src="data:image/svg+xml;base64,PHN2ZyBjbGFzcz0iaHg6aW5saW5lIGh4OmgtNSBoeDpzaHJpbmstMCBoeDpsdHI6cm90YXRlLTE4MCIgZmlsbD0ibm9uZSIgdmlld2JveD0iMCAwIDI0IDI0IiBzdHJva2Utd2lkdGg9IjIiIHN0cm9rZT0iY3VycmVudENvbG9yIiBhcmlhLWhpZGRlbj0idHJ1ZSI+PHBhdGggc3Ryb2tlLWxpbmVjYXA9InJvdW5kIiBzdHJva2UtbGluZWpvaW49InJvdW5kIiBkPSJNOSA1bDcgNy03IDciIC8+PC9zdmc+"
class="hx:inline hx:h-5 hx:shrink-0 hx:ltr:rotate-180" />Dwindle
Layout</a><a href="/Configuring/Scrolling-Layout/"
class="hx:flex hx:max-w-[50%] hx:items-center hx:gap-1 hx:py-4 hx:text-base hx:font-medium hx:text-gray-600 hx:transition-colors [word-break:break-word] hx:hover:text-primary-600 hx:dark:text-gray-300 hx:md:text-lg hx:ltr:ml-auto hx:ltr:pl-4 hx:ltr:text-right hx:rtl:mr-auto hx:rtl:pr-4 hx:rtl:text-left"
title="Scrolling Layout">Scrolling Layout<img
src="data:image/svg+xml;base64,PHN2ZyBjbGFzcz0iaHg6aW5saW5lIGh4OmgtNSBoeDpzaHJpbmstMCBoeDpydGw6LXJvdGF0ZS0xODAiIGZpbGw9Im5vbmUiIHZpZXdib3g9IjAgMCAyNCAyNCIgc3Ryb2tlLXdpZHRoPSIyIiBzdHJva2U9ImN1cnJlbnRDb2xvciIgYXJpYS1oaWRkZW49InRydWUiPjxwYXRoIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIgZD0iTTkgNWw3IDctNyA3IiAvPjwvc3ZnPg=="
class="hx:inline hx:h-5 hx:shrink-0 hx:rtl:-rotate-180" /></a>

</div>

</div>
