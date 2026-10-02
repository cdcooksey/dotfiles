# dotfiles

Managed with [yadm](https://yadm.io). Shared between Arch Linux (personal) and macOS (work); per-host files use yadm alternates (`##hostname.<host>`).

## Setup on a new Arch machine

```sh
yadm clone <repo-url>
sudo pacman -S --needed \
  hyprland xdg-desktop-portal-hyprland xdg-desktop-portal-gtk hypridle \
  dms-shell-hyprland matugen inter-font \
  fuzzel ghostty yazi firefox \
  pipewire-pulse wireplumber pavucontrol playerctl brightnessctl \
  grim slurp wl-clipboard \
  iwd rclone
yadm bootstrap
```

`yadm bootstrap --check` shows what bootstrap would do without doing it. It installs no packages, so the `pacman` step comes first.

## Dependencies

### Desktop (Hyprland + DankMaterialShell)

| Package | Used by |
| --- | --- |
| `hyprland` | Compositor, `.config/hypr/` |
| `xdg-desktop-portal-hyprland`, `xdg-desktop-portal-gtk` | `.config/xdg-desktop-portal/hyprland-portals.conf` |
| `hypridle` | Idle lock, screen off, suspend (`.config/hypr/hypridle.conf`) |
| `dms-shell-hyprland` | Bar, notifications, wallpaper. Pulls in `dms-shell` and `quickshell`. Started by `dms run` in `.config/hypr/hyprland/autostart.lua` |
| `matugen` | DMS theme generation, including the fuzzel colours from `.config/matugen/` |
| `inter-font` | Font for fuzzel. DMS bundles its own copy, but fuzzel needs it installed system-wide |

### Apps bound in Hyprland

| Package | Used by |
| --- | --- |
| `fuzzel` | Launcher, `SUPER + space` |
| `ghostty` | Terminal, `SUPER + return` |
| `yazi` | File manager, `SUPER + E` |
| `firefox` | Browser, autostarted |

### Media and hardware keys

| Package | Used by |
| --- | --- |
| `pipewire-pulse`, `wireplumber` | Volume keys (`wpctl`) |
| `pavucontrol` | Audio mixer |
| `playerctl` | Media keys |
| `brightnessctl` | Brightness keys |

### Screenshots

| Package | Used by |
| --- | --- |
| `grim`, `slurp`, `wl-clipboard` | `PRINT` key, `.local/bin/screenshot` |

### System

| Package | Used by |
| --- | --- |
| `iwd` | Networking; DMS network widget |
| `rclone` | iCloud sync (`.config/systemd/user/rclone-icloud-bisync.*`) |

## Notes

- **DMS owns notifications.** Don't install `dunst` alongside it: dunst is D-Bus activated and can grab the notification name before DMS starts.
- **`.config/fuzzel/colors.ini` is generated** by DMS via matugen. Don't track it; run `dms restart` if it's missing.
- **`hyprlock` is not installed**, but `.config/hypr/hypridle.conf` calls it as `lock_cmd`. Either install it or switch the lock to DMS.
