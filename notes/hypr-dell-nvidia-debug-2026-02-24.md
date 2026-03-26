# Hyprland Dell Monitor + NVIDIA Debug Log (2026-02-24)

## System Context
- Laptop: Acer Aspire 7 (Intel iGPU + NVIDIA GTX 1650)
- Distro/session: Omarchy + Hyprland
- External monitor: Dell U2723QE

## Symptoms Reported
- External Dell monitor felt slow/laggy.
- YouTube playback was somewhat laggy.
- Performance issue was worse at 4K fractional scale.

## Baseline Findings
- Hyprland monitor config was:
  - `HDMI-A-1,3840x2160@60,scale 1.666667`
  - `eDP-1,1920x1080@60,scale 1.25`
- Hyprland had explicit Intel KMS override and CPU cursor settings in `~/.config/hypr/hyprland.conf`.
- Live monitor output showed direct scanout blocked by software/cursor path.

## Changes Applied

### 1) Commented these lines in `~/.config/hypr/hyprland.conf`
- `env = WLR_DRM_DEVICES,/dev/dri/by-path/pci-0000:00:02.0-card`
- `no_hardware_cursors = 1`
- `use_cpu_buffer = true`

Result:
- Slight improvement.
- Subjective reduction in “hardware spinning up” when moving cursor.

### 2) Changed Dell mode in `~/.config/hypr/monitors.conf`
From:
- `monitor=HDMI-A-1,3840x2160@60,0x0,1.666667`

To:
- `monitor=HDMI-A-1,2560x1440@60,0x0,1`

Result:
- Major performance improvement.
- Desktop became much faster/smoother.

## Current Known-Good State
- `~/.config/hypr/monitors.conf`
  - `monitor=HDMI-A-1,2560x1440@60,0x0,1`
- `~/.config/hypr/hyprland.conf`
  - Intel KMS override commented out
  - CPU cursor lines commented out

## Backups Created
- `.config/hypr/hyprland.conf.bak.1771856814`
- `.config/hypr/monitors.conf.bak.1771857254`

## How to Reload Hyprland
```bash
hyprctl reload
```

## Rollback Commands

### Roll back only monitor resolution/scale
```bash
cp .config/hypr/monitors.conf.bak.1771857254 .config/hypr/monitors.conf
hyprctl reload
```

### Roll back hyprland.conf cursor/DRM changes
```bash
cp .config/hypr/hyprland.conf.bak.1771856814 .config/hypr/hyprland.conf
hyprctl reload
```

## Recommended Next Step
- Keep current performance profile (`1440p@60`, scale `1`) as default.
- Optional quality test: try `4K@60` with integer scale `2` (usually smoother than fractional `1.67`, but larger UI).

## Follow-up Deep Dive (2026-03-25)

### Hardware / Routing Facts Confirmed Locally
- Laptop model from `hostnamectl`: Acer Aspire A715-74G.
- GPUs from `lspci`:
  - Intel UHD Graphics 630 at `0000:00:02.0`
  - NVIDIA GeForce GTX 1650 Mobile / Max-Q at `0000:01:00.0`
- DRM ownership from `/sys/class/drm`:
  - `card1-HDMI-A-1` belongs to `0000:01:00.0` (NVIDIA)
  - `card2-eDP-1` belongs to `0000:00:02.0` (Intel)
- External monitor detected by Hyprland:
  - `HDMI-A-1` = Dell U2723QE
  - Available mode includes `3840x2160@60`
- Internal panel detected by Hyprland:
  - `eDP-1` = AU Optronics 1920x1080@60

### Software State Confirmed
- Hyprland: `0.54.1`
- Aquamarine: `0.10.0`
- NVIDIA driver: `nvidia-open-dkms 590.48.01`
- `nvidia_drm modeset=1` is configured in `/etc/modprobe.d/nvidia.conf`
- Early NVIDIA KMS modules are included in `/etc/mkinitcpio.conf`
- Hyprland reports `Explicit sync: supported`
- Old forced Intel KMS path and CPU cursor workaround remain disabled in `~/.config/hypr/hyprland.conf`

### Key Conclusions
- The HDMI port is physically wired to the NVIDIA GPU on this laptop.
- The internal laptop panel is physically wired to the Intel iGPU.
- This means the HDMI monitor cannot be "moved" to Intel in software.
- Acer's official A715-74G spec page lists the USB-C port only as `USB 3.1 Gen 1 (up to 5 Gbps)`, with no DisplayPort alt-mode mentioned, so there is no obvious alternate USB-C display path to test.
- The previous lag at `3840x2160@60` with fractional scale matches Hyprland's own performance guidance: if Hyprland feels laggy, prefer integer scaling such as `1` or `2`.

### Config Change Added
- Added `~/.config/uwsm/env-hyprland` with:
  - `export AQ_DRM_DEVICES=/dev/dri/by-path/pci-0000:01:00.0-card:/dev/dri/by-path/pci-0000:00:02.0-card`
- Rationale:
  - Hyprland's current NVIDIA guidance says to try changing the primary GPU with `AQ_DRM_DEVICES` when monitors attached to the NVIDIA GPU are slow or broken on hybrid systems.
  - This makes the NVIDIA GPU primary for the compositor on next session start, which should favor the external HDMI monitor.

### Planned Test Order
1. Restart the Hyprland session so `AQ_DRM_DEVICES` takes effect.
2. Test the current known-good mode first: `2560x1440@60`, scale `1`.
3. If smooth, test `3840x2160@60`, scale `2`.
4. Avoid returning to fractional scaling on the Dell unless there is a strong reason.
5. Only if the HDMI monitor is still laggy after the primary-GPU change, test the documented fallback:
   - `export AQ_FORCE_LINEAR_BLIT=0`

### Expected Tradeoff
- Making NVIDIA primary should help the HDMI monitor, but may make the internal Intel-driven panel the less optimal path.

## Hardware Options Research (2026-03-25)

### USB-C Display Output
- Official Acer A715-74G product specs list:
  - `USB Type-C: Yes`
  - `USB Type-C Detail: USB 3.1 Gen 1 (up to 5 Gbps)`
- The official A715-74G user manual describes the USB-C port as:
  - USB 3.1 Gen 1 only
  - up to 3 A at 5 V DC for USB charging
- The same manual does **not** mention DisplayPort over USB-C, Thunderbolt, USB4, or DC-in over USB-C for this model.
- The manual also notes that with some USB Type-C adapters, some functions may be disabled, specifically mentioning Thunderbolt video support in the generic USB-C section.
- Local Linux evidence matches this:
  - no `/sys/class/typec` entries
  - no Thunderbolt controller in `lspci`

Conclusion:
- There is no credible evidence that this laptop's USB-C port supports native DisplayPort alt mode.
- A passive USB-C -> DisplayPort or USB-C -> HDMI video adapter is therefore very unlikely to work as a true GPU display output on this model.

### HDMI Rewire / Board Mod
- Local DRM routing proves the HDMI connector is attached to the NVIDIA GPU.
- The internal panel is attached to the Intel GPU.
- No Acer documentation found for a user-accessible mux, graphics switch, or alternate HDMI routing path on this model.

Conclusion:
- Rewiring the HDMI port to Intel would be a motherboard-level hardware mod, not a practical service action.
- In practice, this would mean custom board rework or replacing the motherboard with a different design, which is not realistic for this machine.

### Realistic Hardware-Side Alternatives
1. Check BIOS for a `Discrete`, `dGPU only`, or mux-like graphics option.
   - No proof found that this model has one, but this is the only plausible hardware/firmware switch worth checking.
2. Use the existing HDMI path, but tune the software stack for the NVIDIA-driven external monitor.
   - This is the current approach (`AQ_DRM_DEVICES`, integer scaling, avoid 4K fractional scaling).
3. Use a USB graphics dock/adapter based on DisplayLink as a last resort.
   - This is not native DP alt mode.
   - Official Linux support is Ubuntu-focused and comes with extra limitations, so it should be treated as a compromise path, not a clean fix.

### Bottom Line
- Native USB-C video output: unlikely / effectively no.
- HDMI reroute to Intel: no practical path.
- Best realistic path: optimize the existing NVIDIA HDMI route, or test whether BIOS exposes a dGPU-only mode.

## Working Profiles (2026-03-25)

### Profile A: Smoothest General Setup
- Monitor config:
  - `monitor=HDMI-A-1,2560x1440@60,0x0,1`
- Result:
  - Best overall smoothness on this laptop
  - Lower rendering cost than 4K
- App-specific adjustments:
  - No special Chrome scaling needed
  - Ghostty can use the normal/larger font preference if desired

### Profile B: 4K Usable Setup
- Monitor config:
  - `monitor=HDMI-A-1,3840x2160@60,0x0,2`
- Result:
  - Better sharpness than 1440p
  - Still somewhat heavier / laggier than the 1440p profile
- Required app-side tweaks that made this feel right:
  - `~/.config/ghostty/config`
    - `font-size = 9`
  - `~/.config/chrome-flags.conf`
    - `--force-device-scale-factor=0.85`
- Why:
  - At Hyprland `scale 2`, Ghostty and Chrome otherwise looked too large compared with the visual feel of the 1440p setup.

### If Switching Back to 1440p
- Revert monitor config to:
  - `monitor=HDMI-A-1,2560x1440@60,0x0,1`
- Then consider reverting these app-specific overrides:
  - Ghostty:
    - Increase `font-size` again if `9` feels too small at 1440p
  - Chrome:
    - Remove or comment out `--force-device-scale-factor=0.85` in `~/.config/chrome-flags.conf`
    - Otherwise Chrome will likely look too small at 1440p

### Recommendation
- Keep two mental profiles:
  - `1440p = default smooth profile`
  - `4K scale 2 = acceptable sharpness profile, but requires smaller app UI overrides`

## Community / Repair Scene Summary (2026-03-25)

### What Owners Actually Do
- RAM upgrades are common and well documented.
- SSD/NVMe and 2.5" storage upgrades are common.
- Fan, battery, keyboard, Wi-Fi card, thermal paste, and panel replacements are all normal DIY topics for this laptop family.
- Repair forums also discuss board-level diagnostics for dead boards using schematics and boardview files.

### What People Talk About But Do Not Commonly Do
- Adding DisplayPort or Thunderbolt to the USB-C port
- Retrofitting a MUX / switchable-graphics feature
- Rewiring the HDMI port to the Intel GPU
- Cross-swapping motherboards between nearby Aspire 7 variants as a reliable upgrade path

### Representative Forum Findings
- Acer Community threads confirm repeated owner frustration with the USB-C port being data-only and not supporting display output.
- Acer Community replies also state that Aspire 7 boards do not have the MUX feature on these models.
- There are forum discussions about replacing the whole mainboard or trying nearby board variants, but even the encouraging replies stop short of guaranteeing success.
- Users do report active USB graphics adapters as a workaround for extra monitors, but with substantial limitations such as low refresh rate.

### Practical Conclusion
- There is a real DIY scene for maintenance and repair on this laptop.
- There is **not** a well-established DIY path for changing the display topology of this machine.

## NVIDIA Idle / Performance Research (2026-03-26)

### Local Facts
- AC power was online during testing.
- `powerprofilesctl` was already set to `performance`.
- NVIDIA live state with the HDMI monitor attached:
  - `runtime_status=active`
  - `power/control=on`
  - `P8`
  - graphics clock `300 MHz`
  - memory clock `405 MHz`
  - power draw about `4.7 W`
- `nvidia-smi` reported:
  - `Idle: Active`
  - no software power cap active
  - no thermal slowdown active
  - current/default power limit already `50 W`
- `nvidia-smi pmon` showed the NVIDIA GPU being used by Hyprland/Xorg-side display/compositor processes, not by Chrome video decoding directly.
- `/proc/driver/nvidia/gpus/0000:01:00.0/power` reported:
  - `Runtime D3 status: Disabled by default`
  - `Notebook Dynamic Boost: Not Supported`

### What NVIDIA's Own Docs Say
- RTD3 / full runtime low-power behavior:
  - The general NVIDIA README says RTD3 exists for Turing+ in supported configurations.
  - But the same README's open-kernel-module limitations state RTD3 is only supported on Ampere and above for the open modules.
- Dynamic Boost / `nvidia-powerd`:
  - NVIDIA documents this as Ampere-or-newer only.
  - Therefore it does not apply to this GTX 1650 mobile system.
- Persistence mode:
  - NVIDIA documents it as a way to keep device state initialized and reduce re-initialization overhead.
  - It is not a "high performance on AC" mode.
- PowerMizer:
  - NVIDIA documents that notebook GPUs adjust clocks based on workload.
  - Low clocks in P8 under light desktop work are normal behavior by themselves.

### Conclusion
- The NVIDIA GPU staying awake while directly driving the HDMI monitor is expected.
- The GPU idling in `P8` at low clocks during light desktop use is normal and not, by itself, proof of a fault.
- The main supported NVIDIA laptop performance daemon (`nvidia-powerd`) is not available on this hardware generation.
- Power limit tuning is not promising here because the card is already at its default maximum limit and is not being capped.
- Persistence mode is not the right tool for this lag problem.

### Practical Reading of the Situation
- The lag is more likely tied to the general 4K external display/compositor path than to the NVIDIA GPU "idling too hard".
- There is no clean supported "when on charger + external monitor, force NVIDIA high performance" feature available on this GTX 1650 Linux setup.
- The remaining way to test the hypothesis would be a manual, experimental clock-lock test with `nvidia-smi`, but that would be a blunt experiment rather than a proper supported policy feature.
