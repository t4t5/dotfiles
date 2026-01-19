# Install DaVinci Resolve on Omarchy (via Davincibox)

**Status: WORKING** on AMD Ryzen AI 5 340 with Radeon 840M (gfx1152)

Requires ROCm with `HSA_OVERRIDE_GFX_VERSION=11.0.0` workaround (treats gfx1152 as gfx1100).

---

## 1. Install required packages

```bash
sudo pacman -S podman distrobox lshw crun
```

## 2. Add yourself to required groups

```bash
sudo usermod -aG render,video $USER
```

Then **log out and back in** (or reboot).

## 3. Clone davincibox and install

```bash
git clone https://github.com/zelikos/davincibox.git
cd davincibox
# Download DaVinci Resolve Linux installer from Blackmagic's site,
# extract the .zip and move the .run file here
chmod +x setup.sh
./setup.sh DaVinci_Resolve_*.run
```

## 4. Install ROCm OpenCL inside the container

```bash
distrobox enter davincibox -- /bin/bash
sudo dnf install rocm-opencl
exit
```

## 5. Enable ROCm with GPU version override

The Radeon 840M (gfx1152) isn't officially supported by ROCm, but works when treated as gfx1100 (RDNA 3).

Edit the desktop launcher:

```bash
nano ~/.local/share/applications/DaVinciResolve.desktop
```

Change the `Exec` line to include `HSA_OVERRIDE_GFX_VERSION=11.0.0`:

```
Exec=distrobox-enter -n davincibox -- env HSA_OVERRIDE_GFX_VERSION=11.0.0 /usr/bin/run-davinci /opt/resolve/bin/resolve %u
```

## 6. Fix UI scaling for HiDPI displays

DaVinci Resolve will appear tiny on HiDPI displays with Hyprland. After launching:

1. Open a project (double-click any project)
2. Go to **DaVinci Resolve** menu (top left) → **Preferences**
3. Click **User** tab → **UI Settings**
4. Set **UI display scale factor** to **2** (or appropriate for your display)

## 7. Convert videos to supported codecs

The free version of DaVinci Resolve on Linux **does not support H.264/H.265 codecs** (licensing restriction). Convert videos before importing:

```bash
# MJPEG (simple, good compatibility)
ffmpeg -i input.mp4 -c:v mjpeg -q:v 3 -c:a pcm_s16le output.mov

# DNxHR (better quality, larger files)
ffmpeg -i input.mp4 -c:v dnxhd -profile:v dnxhr_hq -pix_fmt yuv422p -c:a pcm_s16le output.mov
```

## Troubleshooting

### What we tried that didn't work

- **Rusticl** (`RUSTICL_ENABLE=radeonsi`): Detects GPU but crashes in `clBuildProgram` during video playback
- **Pocl** (CPU OpenCL): DaVinci Resolve rejects CPU-based OpenCL emulation
- **ROCm without override**: Doesn't detect gfx1152 as a supported GPU

### The fix

`HSA_OVERRIDE_GFX_VERSION=11.0.0` tells ROCm to treat gfx1152 (RDNA 3.5) as gfx1100 (RDNA 3), which is officially supported.

## Sources

- https://github.com/zelikos/davincibox
- https://wiki.archlinux.org/title/DaVinci_Resolve
