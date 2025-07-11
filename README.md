# Personal Dotfiles

A comprehensive collection of configuration files for a modern Linux desktop environment using Hyprland, Neovim, and various productivity tools.

## 🚀 Features

- **Hyprland**: Wayland compositor with custom scripts for system management
- **Neovim**: Modern text editor with Lua-based configuration
- **Kitty**: GPU-accelerated terminal emulator
- **Zsh**: Enhanced shell with PowerLevel10k theme and autocomplete
- **Rofi**: Application launcher and menu system
- **Mako**: Notification daemon for Wayland
- **Additional tools**: GTK themes, Zathura PDF viewer, Ranger file manager, MPV media player

## 📋 Table of Contents

- [Installation](#installation)
- [Components](#components)
- [Usage](#usage)
- [Scripts](#scripts)
- [Customization](#customization)
- [Troubleshooting](#troubleshooting)
- [Dependencies](#dependencies)

## 🔧 Installation

### Prerequisites

Ensure you have the following packages installed:

```bash
# Arch Linux / Manjaro
sudo pacman -S hyprland kitty neovim zsh rofi mako brightnessctl pamixer wpctl

# Additional dependencies
sudo pacman -S fzf ranger zathura mpv gtk3 gtk4
```

### Quick Setup

1. **Clone the repository:**
   ```bash
   git clone https://github.com/subraths/dotfiles.git
   cd dotfiles
   ```

2. **Run the installation script:**
   ```bash
   ./install.sh
   ```

3. **Manual installation (if preferred):**
   ```bash
   # Backup existing configs
   mkdir -p ~/.config/backup
   cp -r ~/.config/hypr ~/.config/backup/ 2>/dev/null || true
   cp -r ~/.config/nvim ~/.config/backup/ 2>/dev/null || true
   cp -r ~/.config/kitty ~/.config/backup/ 2>/dev/null || true
   
   # Create symlinks
   ln -sf "$(pwd)/hypr" ~/.config/
   ln -sf "$(pwd)/nvim" ~/.config/
   ln -sf "$(pwd)/kitty" ~/.config/
   ln -sf "$(pwd)/zsh/zshrc" ~/.zshrc
   ln -sf "$(pwd)/zsh/zshenv" ~/.zshenv
   ln -sf "$(pwd)/zsh/zprofile" ~/.zprofile
   ln -sf "$(pwd)/rofi" ~/.config/
   ln -sf "$(pwd)/mako" ~/.config/
   ln -sf "$(pwd)/ranger" ~/.config/
   ln -sf "$(pwd)/zathura" ~/.config/
   ln -sf "$(pwd)/mpv" ~/.config/
   ln -sf "$(pwd)/gtk-3.0" ~/.config/
   ln -sf "$(pwd)/gtk-4.0" ~/.config/
   ```

## 📦 Components

### Hyprland Configuration

**Location:** `hypr/`

- **hyprland.conf**: Main configuration file with window rules, animations, and keybinds
- **keybinds.conf**: Custom keyboard shortcuts
- **hyprpaper.conf**: Wallpaper configuration
- **hypridle.conf**: Idle management
- **hyprlock.conf**: Screen lock configuration
- **hyprsunset.conf**: Blue light filter settings

### Scripts

**Location:** `hypr/scripts/`

| Script | Purpose | Usage |
|--------|---------|-------|
| `brightness.sh` | Monitor brightness control | `brightness.sh --inc/--dec/--get` |
| `volume.sh` | Audio volume management | `volume.sh --inc/--dec/--toggle/--get` |
| `mic.sh` | Microphone control | `mic.sh --toggle` |
| `temperature.sh` | Color temperature adjustment | `temperature.sh --inc/--dec` |
| `bat-notify.sh` | Battery level notifications | Runs as daemon |
| `connect-wifi.sh` | WiFi connection helper | `connect-wifi.sh` |
| `connect-bluetooth.sh` | Bluetooth management | `connect-bluetooth.sh` |
| `waybar-starter.sh` | Status bar initialization | Auto-runs on startup |
| `resetxdgportal.sh` | XDG portal reset for screenshare | Auto-runs on startup |
| `gtk_theme_picker.sh` | GTK theme selection | `gtk_theme_picker.sh` |

### Neovim Configuration

**Location:** `nvim/`

- Modern Lua-based configuration
- LSP support with language servers
- Plugin management with lazy.nvim
- Custom keybindings and UI enhancements

### Terminal Setup

**Kitty** (`kitty/`):
- Custom color scheme and fonts
- Optimized for performance
- Integration with system theme

**Zsh** (`zsh/`):
- PowerLevel10k theme for enhanced prompt
- Autocomplete and syntax highlighting
- Custom aliases and functions
- History management

## 🎮 Usage

### Key Bindings (Hyprland)

| Combination | Action |
|-------------|--------|
| `Super + Return` | Open terminal (Kitty) |
| `Super + Q` | Close window |
| `Super + D` | Application launcher (Rofi) |
| `Super + F` | Toggle fullscreen |
| `Super + V` | Toggle floating |
| `Super + 1-9` | Switch to workspace |
| `Super + Shift + 1-9` | Move window to workspace |
| `Super + H/J/K/L` | Navigate windows |
| `Super + Shift + H/J/K/L` | Move windows |

### Volume and Brightness

- **Volume**: `Super + Plus/Minus` or use `volume.sh` script
- **Brightness**: `Super + F1/F2` or use `brightness.sh` script
- **Microphone**: `Super + M` or use `mic.sh` script

### Custom Aliases (Zsh)

```bash
ra          # Open Ranger file manager
ya          # Open Yazi file manager  
ta          # Attach to tmux session
books       # Navigate to books directory
git plog    # Pretty git log with graph
ex <file>   # Universal extractor function
```

## 🔨 Scripts Details

### Brightness Control (`brightness.sh`)

- Automatically detects maximum brightness
- Shows visual notifications with icons
- Supports increment/decrement/get operations

### Volume Control (`volume.sh`)

- Uses WirePlumber (wpctl) for audio control
- Mute detection and toggle functionality
- Visual feedback with notifications

### Battery Monitor (`bat-notify.sh`)

- Continuous monitoring daemon
- Multiple alert levels (low, normal, critical)
- Charging status notifications

## 🎨 Customization

### Modifying Configurations

1. **Hyprland settings**: Edit `hypr/hyprland.conf`
2. **Keybindings**: Modify `hypr/keybinds.conf`
3. **Colors/Themes**: Update GTK configs in `gtk-3.0/` and `gtk-4.0/`
4. **Terminal colors**: Edit `kitty/kitty.conf`
5. **Shell prompt**: Configure in `zsh/` files

### Adding New Scripts

1. Create script in `hypr/scripts/`
2. Make executable: `chmod +x script_name.sh`
3. Add keybinding in `hypr/keybinds.conf`
4. Follow existing script patterns for consistency

### Theme Customization

- **GTK themes**: Use `lxappearance` or edit GTK config files
- **Icon themes**: Place in `~/.icons/` and update GTK settings
- **Wallpapers**: Update `hypr/hyprpaper.conf`

## 🐛 Troubleshooting

### Common Issues

1. **Scripts not working**:
   ```bash
   # Check if scripts are executable
   chmod +x hypr/scripts/*.sh
   
   # Verify dependencies
   which brightnessctl wpctl pamixer
   ```

2. **Hyprland not starting**:
   ```bash
   # Check logs
   journalctl -u hyprland
   
   # Verify config syntax
   hyprctl reload
   ```

3. **Audio/Brightness controls not responding**:
   ```bash
   # Test commands directly
   wpctl get-volume @DEFAULT_AUDIO_SINK@
   brightnessctl get
   ```

4. **Notifications not showing**:
   ```bash
   # Restart mako
   killall mako && mako &
   ```

### Log Files

- Hyprland logs: `~/.local/share/hyprland/hyprland.log`
- Application logs: Check with `journalctl -f`

## 📋 Dependencies

### Required Packages

```bash
# Core system
hyprland hyprpaper hypridle hyprlock hyprsunset
kitty neovim zsh

# Audio/Media
pipewire wireplumber pamixer
mpv

# Utilities
brightnessctl rofi mako
fzf ranger zathura
thunar blueman-manager

# Development (for Neovim)
nodejs npm python python-pip
ripgrep fd tree-sitter

# Fonts and Themes
ttf-fira-code noto-fonts
gtk3 gtk4 qt5ct
```

### Optional Enhancements

```bash
# Additional tools
yazi tmux
zen-browser-bin  # AUR
lxsession lxappearance

# PowerLevel10k theme
zsh-theme-powerlevel10k
zsh-autocomplete
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Test your changes thoroughly
4. Update documentation if needed
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [Hyprland](https://hyprland.org/) - Amazing Wayland compositor
- [Neovim](https://neovim.io/) - Extensible text editor
- [PowerLevel10k](https://github.com/romkatv/powerlevel10k) - Zsh theme
- Community dotfiles for inspiration and best practices

---

*Last updated: $(date)*