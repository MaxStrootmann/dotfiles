# Source

- URL: https://wiki.hypr.land/Configuring/Workspace-Rules/
- Retrieved: 2026-03-05T12:11:37+01:00

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

Workspace Rules

</div>

</div>

<div class="content">

<div class="hx:flex hx:flex-col hx:sm:flex-row hx:items-start hx:sm:items-center hx:sm:justify-between hx:gap-4 hx:mb-4">

# Workspace Rules

</div>

You can set workspace rules to achieve workspace-specific behaviors. For
instance, you can define a workspace where all windows are drawn without
borders or gaps.

For layout-specific rules, see the specific layout page. For example:
[Master Layout-\>Workspace Rules](../Master-Layout#workspace-rules).

### Workspace selectors<span id="workspace-selectors" class="hx:absolute hx:-mt-20"></span> <a href="#workspace-selectors" class="subheading-anchor"
aria-label="Permalink for this section"></a>

Workspaces that have already been created can be targeted by workspace
selectors, e.g. `r[2-4] w[t1]`.

Selectors have props separated by a space. No spaces are allowed inside
props themselves.

Props:

- `r[A-B]` - ID range from A to B inclusive
- `s[bool]` - Whether the workspace is special or not
- `n[bool]`, `n[s:string]`, `n[e:string]` - named actions. `n[bool]` -\>
  whether a workspace is a named workspace, `s` and `e` are starts and
  ends with respectively
- `m[monitor]` - Monitor selector
- `w[(flags)A-B]`, `w[(flags)X]` - Prop for window counts on the
  workspace. A-B is an inclusive range, X is a specific number. Flags
  can be omitted. It can be `t` for tiled-only, `f` for floating-only,
  `g` to count groups instead of windows, `v` to count only visible
  windows, and `p` to count only pinned windows.
- `f[-1]`, `f[0]`, `f[1]`, `f[2]` - fullscreen state of the workspace.
  `-1`: no fullscreen, `0`: fullscreen, `1`: maximized, `2`, fullscreen
  without fullscreen state sent to the window.

### Syntax<span id="syntax" class="hx:absolute hx:-mt-20"></span> <a href="#syntax" class="subheading-anchor"
aria-label="Permalink for this section"></a>

<div class="hextra-code-block hx:relative hx:mt-6 hx:first:mt-0 hx:group/code">

<div>

<div class="highlight">

``` chroma
workspace = WORKSPACE, RULES
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

- WORKSPACE is a valid workspace identifier (see
  [Dispatchers-\>Workspaces](../Dispatchers#workspaces)). This field is
  mandatory. This *can be* a workspace selector, but please note
  workspace selectors can only match *existing* workspaces.
- RULES is one (or more) rule(s) as described here in [rules](#rules).

### Examples<span id="examples" class="hx:absolute hx:-mt-20"></span> <a href="#examples" class="subheading-anchor"
aria-label="Permalink for this section"></a>

<div class="hextra-code-block hx:relative hx:mt-6 hx:first:mt-0 hx:group/code">

<div>

<div class="highlight">

``` chroma
workspace = name:myworkspace, gapsin:0, gapsout:0
workspace = 3, rounding:false, bordersize:0
workspace = w[tg1-4], shadow:false
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

#### Smart gaps<span id="smart-gaps" class="hx:absolute hx:-mt-20"></span> <a href="#smart-gaps" class="subheading-anchor"
aria-label="Permalink for this section"></a>

To replicate “smart gaps” / “no gaps when only” from other
WMs/Compositors, use this bad boy:

<div class="hextra-code-block hx:relative hx:mt-6 hx:first:mt-0 hx:group/code">

<div>

<div class="highlight">

``` chroma
workspace = w[tv1], gapsout:0, gapsin:0
workspace = f[1], gapsout:0, gapsin:0
windowrule = border_size 0, match:float 0, match:workspace w[tv1]
windowrule = rounding 0, match:float 0, match:workspace w[tv1]
windowrule = border_size 0, match:float 0, match:workspace f[1]
windowrule = rounding 0, match:float 0, match:workspace f[1]
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

#### Smart gaps (ignoring special workspaces)<span id="smart-gaps-ignoring-special-workspaces" class="hx:absolute hx:-mt-20"></span> <a href="#smart-gaps-ignoring-special-workspaces"
class="subheading-anchor" aria-label="Permalink for this section"></a>

You can combine workspace selectors for more fine-grained control, for
example, to ignore special workspaces:

<div class="hextra-code-block hx:relative hx:mt-6 hx:first:mt-0 hx:group/code">

<div>

<div class="highlight">

``` chroma
workspace = w[tv1]s[false], gapsout:0, gapsin:0
workspace = f[1]s[false], gapsout:0, gapsin:0
windowrule = border_size 0, match:float 0, match:workspace w[tv1]s[false]
windowrule = rounding 0, match:float 0, match:workspace w[tv1]s[false]
windowrule = border_size 0, match:float 0, match:workspace f[1]s[false]
windowrule = rounding 0, match:float 0, match:workspace f[1]s[false]
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

## Rules<span id="rules" class="hx:absolute hx:-mt-20"></span> <a href="#rules" class="subheading-anchor"
aria-label="Permalink for this section"></a>

| Rule | Description | type |
|----|----|----|
| monitor:\[m\] | Binds a workspace to a monitor. See [syntax](#syntax) and [Monitors](../Monitors). | string |
| default:\[b\] | Whether this workspace should be the default workspace for the given monitor | bool |
| gapsin:\[x\] | Set the gaps between windows (equivalent to [General-\>gaps_in](../Variables#general)) | int |
| gapsout:\[x\] | Set the gaps between windows and monitor edges (equivalent to [General-\>gaps_out](../Variables#general)) | int |
| bordersize:\[x\] | Set the border size around windows (equivalent to [General-\>border_size](../Variables#general)) | int |
| border:\[b\] | Whether to draw borders or not | bool |
| shadow:\[b\] | Whether to draw shadows or not | bool |
| rounding:\[b\] | Whether to draw rounded windows or not | bool |
| decorate:\[b\] | Whether to draw window decorations or not | bool |
| persistent:\[b\] | Keep this workspace alive even if empty and inactive | bool |
| on-created-empty:\[c\] | A command to be executed once a workspace is created empty (i.e. not created by moving a window to it). See the [command syntax](../Dispatchers#executing-with-rules) | string |
| defaultName:\[s\] | A default name for the workspace. | string |
| layout:\[s\] | The layout to use for this workspace. | string |

### Example Rules<span id="example-rules" class="hx:absolute hx:-mt-20"></span> <a href="#example-rules" class="subheading-anchor"
aria-label="Permalink for this section"></a>

<div class="hextra-code-block hx:relative hx:mt-6 hx:first:mt-0 hx:group/code">

<div>

<div class="highlight">

``` chroma
workspace = 3, rounding:false, decorate:false
workspace = name:coding, rounding:false, decorate:false, gapsin:0, gapsout:0, border:false, monitor:DP-1
workspace = 8,bordersize:8
workspace = name:Hello, monitor:DP-1, default:true
workspace = name:gaming, monitor:desc:Chimei Innolux Corporation 0x150C, default:true
workspace = 5, on-created-empty:[float] firefox
workspace = special:scratchpad, on-created-empty:foot
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

<a href="/Configuring/Window-Rules/"
class="hx:flex hx:max-w-[50%] hx:items-center hx:gap-1 hx:py-4 hx:text-base hx:font-medium hx:text-gray-600 hx:transition-colors [word-break:break-word] hx:hover:text-primary-600 hx:dark:text-gray-300 hx:md:text-lg hx:ltr:pr-4 hx:rtl:pl-4"
title="Window Rules"><img
src="data:image/svg+xml;base64,PHN2ZyBjbGFzcz0iaHg6aW5saW5lIGh4OmgtNSBoeDpzaHJpbmstMCBoeDpsdHI6cm90YXRlLTE4MCIgZmlsbD0ibm9uZSIgdmlld2JveD0iMCAwIDI0IDI0IiBzdHJva2Utd2lkdGg9IjIiIHN0cm9rZT0iY3VycmVudENvbG9yIiBhcmlhLWhpZGRlbj0idHJ1ZSI+PHBhdGggc3Ryb2tlLWxpbmVjYXA9InJvdW5kIiBzdHJva2UtbGluZWpvaW49InJvdW5kIiBkPSJNOSA1bDcgNy03IDciIC8+PC9zdmc+"
class="hx:inline hx:h-5 hx:shrink-0 hx:ltr:rotate-180" />Window
Rules</a><a href="/Configuring/Animations/"
class="hx:flex hx:max-w-[50%] hx:items-center hx:gap-1 hx:py-4 hx:text-base hx:font-medium hx:text-gray-600 hx:transition-colors [word-break:break-word] hx:hover:text-primary-600 hx:dark:text-gray-300 hx:md:text-lg hx:ltr:ml-auto hx:ltr:pl-4 hx:ltr:text-right hx:rtl:mr-auto hx:rtl:pr-4 hx:rtl:text-left"
title="Animations">Animations<img
src="data:image/svg+xml;base64,PHN2ZyBjbGFzcz0iaHg6aW5saW5lIGh4OmgtNSBoeDpzaHJpbmstMCBoeDpydGw6LXJvdGF0ZS0xODAiIGZpbGw9Im5vbmUiIHZpZXdib3g9IjAgMCAyNCAyNCIgc3Ryb2tlLXdpZHRoPSIyIiBzdHJva2U9ImN1cnJlbnRDb2xvciIgYXJpYS1oaWRkZW49InRydWUiPjxwYXRoIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIgZD0iTTkgNWw3IDctNyA3IiAvPjwvc3ZnPg=="
class="hx:inline hx:h-5 hx:shrink-0 hx:rtl:-rotate-180" /></a>

</div>

</div>
