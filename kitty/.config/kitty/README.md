# Kitty Terminal Configuration

Enhanced kitty terminal configuration with theme management, tmux-friendly keybindings, and optimized settings.

## Quick Setup

### First Time Setup
New to this configuration? See the detailed [Setup Guide (SETUP.md)](./SETUP.md) for complete installation instructions.

**Quick Steps:**
1. **Install dependencies:**
   ```bash
   # macOS
   brew install kitty
   brew install --cask font-fira-code-nerd-font

   # Linux (Debian/Ubuntu)
   sudo apt install kitty
   # See SETUP.md for font installation
   ```

2. **Link configuration:**
   ```bash
   # Using automated setup script (recommended)
   cd ~/dotfiles
   ./setup.sh

   # Or manual symlink
   ln -sf ~/dotfiles/kitty/.config/kitty/kitty.conf ~/.config/kitty/kitty.conf
   ```

3. **Restart kitty** or press `Cmd+Shift+R` to reload

### Already Installed?
- **Change theme:** Press `Cmd+Shift+T` or run `~/.config/kitty/switch-theme.sh tokyo`
- **See all shortcuts:** Jump to [Keybindings](#️-tmux-friendly-keybindings) section below
- **Customize:** See [Customization Tips](#customization-tips) section

### Additional Documentation
- **[SETUP.md](./SETUP.md)** - Detailed first-time setup, font installation, platform differences
- **[INSTALL.md](../../../INSTALL.md)** - Complete dotfiles installation guide with dependencies

---

## Features

### 🎨 Theme Management
- **6 Popular Themes Included:**
  - Monokai Pro (Filter Spectrum) - *default*
  - Gruvbox Dark
  - Tokyo Night
  - Catppuccin Mocha
  - Nord
  - Dracula

### ⌨️ Tmux-Friendly Keybindings
All keybindings use `Cmd` key to avoid conflicts with tmux (Ctrl+b):

**Tab Management:**
- `Cmd+T` - New tab
- `Cmd+W` - Close tab
- `Cmd+Shift+]` - Next tab
- `Cmd+Shift+[` - Previous tab
- `Cmd+1-9` - Jump to tab 1-9

**Font Size:**
- `Cmd+=` - Increase font size
- `Cmd+-` - Decrease font size
- `Cmd+0` - Reset font size

**Navigation:**
- `Cmd+K` - Scroll to previous prompt
- `Cmd+J` - Scroll to next prompt
- `Cmd+Shift+H` - Show scrollback in pager
- `Cmd+L` - Clear screen and scrollback

**Utilities:**
- `Cmd+Shift+R` - Reload config
- `Cmd+Shift+T` - Open theme selector
- `Cmd+N` - New OS window

### ✨ Visual Enhancements
- **Styled Tab Bar:** Powerline style with slanted edges
- **Font Ligatures:** Enabled for FiraCode Nerd Font
- **Cursor:** Block cursor with blink
- **Transparency:** 0.88 background opacity
- **URL Handling:** Click URLs to open, curly underline style

### 🚀 Performance & Features
- **Shell Integration:** Enhanced prompt and command tracking
- **Large Scrollback:** 50,000 lines (up from 10k)
- **Copy on Select:** Automatic clipboard copy
- **Remote Control:** Enabled for scripting
- **Visual Bell:** Tab notifications for background activity

## Theme Switching

### Method 1: Using the Script
```bash
# List available themes
~/.config/kitty/switch-theme.sh

# Switch to a theme
~/.config/kitty/switch-theme.sh tokyo
~/.config/kitty/switch-theme.sh gruvbox
~/.config/kitty/switch-theme.sh catppuccin
```

### Method 2: Using Kitty Themes Kitten
Press `Cmd+Shift+T` to open the theme selector.

### Method 3: Manual Configuration
Edit `~/.config/kitty/kitty.conf` and change the include line:
```conf
include ./themes/tokyo-night.conf
```

Then reload: `Cmd+Shift+R`

## Configuration Structure

```
~/.config/kitty/
├── kitty.conf          # Main configuration file
├── themes/             # Theme directory
│   ├── monokai-pro.conf
│   ├── gruvbox-dark.conf
│   ├── tokyo-night.conf
│   ├── catppuccin-mocha.conf
│   ├── nord.conf
│   └── dracula.conf
├── switch-theme.sh     # Theme switching script
└── README.md          # This file
```

## Customization Tips

### Add Your Own Theme
1. Create a new `.conf` file in `themes/` directory
2. Define colors (see existing themes for format)
3. Update `switch-theme.sh` to include your theme
4. Switch to it using the script or manually

### Adjust Tab Bar Position
Change in `kitty.conf`:
```conf
tab_bar_edge top    # or bottom
```

### Change Opacity
Adjust transparency in `kitty.conf`:
```conf
background_opacity 0.88    # 0.0 (transparent) to 1.0 (opaque)
```

### Disable Ligatures
If you prefer no ligatures:
```conf
disable_ligatures always
```

## Requirements

- Kitty 0.26.0+
- FiraCode Nerd Font (or change font_family in config)
- macOS (keybindings use Cmd key; adjust for Linux)

## References

- [Kitty Documentation](https://sw.kovidgoyal.net/kitty/)
- [Kitty Themes](https://github.com/kovidgoyal/kitty-themes)
