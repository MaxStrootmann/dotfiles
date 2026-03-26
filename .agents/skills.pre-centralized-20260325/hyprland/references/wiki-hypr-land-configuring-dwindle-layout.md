# Source

- URL: https://wiki.hypr.land/Configuring/Dwindle-Layout/
- Retrieved: 2026-03-05T12:11:38+01:00

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

Dwindle Layout

</div>

</div>

<div class="content">

<div class="hx:flex hx:flex-col hx:sm:flex-row hx:items-start hx:sm:items-center hx:sm:justify-between hx:gap-4 hx:mb-4">

# Dwindle Layout

</div>

Dwindle is a BSPWM-like layout, where every window on a workspace is a
member of a binary tree.

## Quirks<span id="quirks" class="hx:absolute hx:-mt-20"></span> <a href="#quirks" class="subheading-anchor"
aria-label="Permalink for this section"></a>

Dwindle splits are NOT PERMANENT. The split is determined dynamically
with the W/H ratio of the parent node. If W \> H, it’s side-by-side. If
H \> W, it’s top-and-bottom. You can make them permanent by enabling
`preserve_split`.

## Config<span id="config" class="hx:absolute hx:-mt-20"></span> <a href="#config" class="subheading-anchor"
aria-label="Permalink for this section"></a>

category name: `dwindle`

| name | description | type | default |
|----|----|----|----|
| pseudotile | enable pseudotiling. Pseudotiled windows retain their floating size when tiled. | bool | false |
| force_split | 0 -\> split follows mouse, 1 -\> always split to the left (new = left or top) 2 -\> always split to the right (new = right or bottom) | int | 0 |
| preserve_split | if enabled, the split (side/top) will not change regardless of what happens to the container. | bool | false |
| smart_split | if enabled, allows a more precise control over the window split direction based on the cursor’s position. The window is conceptually divided into four triangles, and cursor’s triangle determines the split direction. This feature also turns on preserve_split. | bool | false |
| smart_resizing | if enabled, resizing direction will be determined by the mouse’s position on the window (nearest to which corner). Else, it is based on the window’s tiling position. | bool | true |
| permanent_direction_override | if enabled, makes the preselect direction persist until either this mode is turned off, another direction is specified, or a non-direction is specified (anything other than l,r,u/t,d/b) | bool | false |
| special_scale_factor | specifies the scale factor of windows on the special workspace \[0 - 1\] | float | 1 |
| split_width_multiplier | specifies the auto-split width multiplier. Multiplying window size is useful on widescreen monitors where window W \> H even after several splits. | float | 1.0 |
| use_active_for_splits | whether to prefer the active window or the mouse position for splits | bool | true |
| default_split_ratio | the default split ratio on window open. 1 means even 50/50 split. \[0.1 - 1.9\] | float | 1.0 |
| split_bias | specifies which window will receive the split ratio. 0 -\> directional (the top or left window), 1 -\> the current window | int | 0 |
| precise_mouse_move | bindm movewindow will drop the window more precisely depending on where your mouse is. | bool | false |

## Bind Dispatchers<span id="bind-dispatchers" class="hx:absolute hx:-mt-20"></span> <a href="#bind-dispatchers" class="subheading-anchor"
aria-label="Permalink for this section"></a>

| dispatcher | description | params |
|----|----|----|
| pseudo | toggles the given window’s pseudo mode | left empty / `active` for current, or `window` for a specific window |

## Layout messages<span id="layout-messages" class="hx:absolute hx:-mt-20"></span> <a href="#layout-messages" class="subheading-anchor"
aria-label="Permalink for this section"></a>

Dispatcher `layoutmsg` params:

| param | description | args |
|----|----|----|
| togglesplit | toggles the split (top/side) of the current window. `preserve_split` must be enabled for toggling to work. | none |
| swapsplit | swaps the two halves of the split of the current window. | none |
| preselect | A one-time override for the split direction. (valid for the next window to be opened, only works on tiled windows) | direction |
| movetoroot | moves the selected window (active window if unspecified) to the root of its workspace tree. The default behavior maximizes the window in its current subtree. If `unstable` is provided as the second argument, the window will be swapped with the other subtree instead. It is not possible to only provide the second argument, but `movetoroot active unstable` will achieve the same result. | \[window, \[ string \]\] |

e.g.:

<div class="hextra-code-block hx:relative hx:mt-6 hx:first:mt-0 hx:group/code">

<div>

<div class="highlight">

``` chroma
bind = SUPER, A, layoutmsg, preselect l
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

<a href="/Configuring/Tearing/"
class="hx:flex hx:max-w-[50%] hx:items-center hx:gap-1 hx:py-4 hx:text-base hx:font-medium hx:text-gray-600 hx:transition-colors [word-break:break-word] hx:hover:text-primary-600 hx:dark:text-gray-300 hx:md:text-lg hx:ltr:pr-4 hx:rtl:pl-4"
title="Tearing"><img
src="data:image/svg+xml;base64,PHN2ZyBjbGFzcz0iaHg6aW5saW5lIGh4OmgtNSBoeDpzaHJpbmstMCBoeDpsdHI6cm90YXRlLTE4MCIgZmlsbD0ibm9uZSIgdmlld2JveD0iMCAwIDI0IDI0IiBzdHJva2Utd2lkdGg9IjIiIHN0cm9rZT0iY3VycmVudENvbG9yIiBhcmlhLWhpZGRlbj0idHJ1ZSI+PHBhdGggc3Ryb2tlLWxpbmVjYXA9InJvdW5kIiBzdHJva2UtbGluZWpvaW49InJvdW5kIiBkPSJNOSA1bDcgNy03IDciIC8+PC9zdmc+"
class="hx:inline hx:h-5 hx:shrink-0 hx:ltr:rotate-180" />Tearing</a><a href="/Configuring/Master-Layout/"
class="hx:flex hx:max-w-[50%] hx:items-center hx:gap-1 hx:py-4 hx:text-base hx:font-medium hx:text-gray-600 hx:transition-colors [word-break:break-word] hx:hover:text-primary-600 hx:dark:text-gray-300 hx:md:text-lg hx:ltr:ml-auto hx:ltr:pl-4 hx:ltr:text-right hx:rtl:mr-auto hx:rtl:pr-4 hx:rtl:text-left"
title="Master Layout">Master Layout<img
src="data:image/svg+xml;base64,PHN2ZyBjbGFzcz0iaHg6aW5saW5lIGh4OmgtNSBoeDpzaHJpbmstMCBoeDpydGw6LXJvdGF0ZS0xODAiIGZpbGw9Im5vbmUiIHZpZXdib3g9IjAgMCAyNCAyNCIgc3Ryb2tlLXdpZHRoPSIyIiBzdHJva2U9ImN1cnJlbnRDb2xvciIgYXJpYS1oaWRkZW49InRydWUiPjxwYXRoIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIgZD0iTTkgNWw3IDctNyA3IiAvPjwvc3ZnPg=="
class="hx:inline hx:h-5 hx:shrink-0 hx:rtl:-rotate-180" /></a>

</div>

</div>
