# Kitty Terminal Setup Guide

Complete guide for setting up and using Kitty terminal with this configuration on a new computer.

## Table of Contents
- [First-Time Installation](#first-time-installation)
- [Font Requirements](#font-requirements)
- [Configuration Overview](#configuration-overview)
- [Theme Switching](#theme-switching)
- [Keybinding Reference](#keybinding-reference)
- [Tmux Integration](#tmux-integration)
- [Platform Differences](#platform-differences)
- [Customization](#customization)
- [FAQ](#faq)

---

## First-Time Installation

### Prerequisites
Before using this kitty configuration, ensure you have:
- Kitty terminal installed (v0.26.0 or later)
- FiraCode Nerd Font installed
- This dotfiles repository cloned to `~/dotfiles`

### Step 1: Install Kitty

#### macOS
```bash
brew install kitty
```

#### Debian/Ubuntu
```bash
sudo apt install kitty
```

#### Fedora
```bash
sudo dnf install kitty
```

#### Arch Linux
```bash
sudo pacman -S kitty
```

### Step 2: Install FiraCode Nerd Font

#### macOS (Homebrew)
```bash
brew tap homebrew/cask-fonts
brew install --cask font-fira-code-nerd-font
```

#### Linux (Manual)
```bash
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip
unzip FiraCode.zip
rm FiraCode.zip
fc-cache -fv
```

**Verify font installation:**
```bash
fc-list | grep -i "fira.*nerd"
```

### Step 3: Link Configuration

#### Automated (Recommended)
```bash
cd ~/dotfiles
./setup.sh
```

#### Manual
```bash
# Create kitty config directory
mkdir -p ~/.config/kitty

# Create symlink to main config
ln -sf ~/dotfiles/kitty/.config/kitty/kitty.conf ~/.config/kitty/kitty.conf

# Optional: Link entire kitty directory for themes and scripts
ln -sf ~/dotfiles/kitty/.config/kitty/* ~/.config/kitty/
```

### Step 4: Verify Installation

```bash
# Launch kitty
kitty

# Check configuration
kitty --debug-config | grep "config_path"

# Should show: config_path = /Users/YOUR_USERNAME/.config/kitty/kitty.conf
```

---

## Font Requirements

### Why FiraCode Nerd Font?

This configuration requires **FiraCode Nerd Font** for:
- **Programming ligatures** (`->`, `=>`, `>=`, `!=`, etc.)
- **Nerd Font icons** (file icons, git symbols, etc.)
- **Excellent readability** (designed for code)
- **Multiple weights** (Light, Regular, Medium, Bold)

### Without Proper Font

If you don't have the font installed, you'll see:
- Broken icons (appearing as `?` or squares)
- Missing ligatures (you'll see separate characters instead of combined symbols)
- Possible layout issues

### Alternative Fonts

If you want to use a different font, edit `kitty.conf` line 8:

```bash
# Change from:
font_family     FiraCode Nerd Font

# To one of:
font_family     JetBrains Mono Nerd Font
font_family     Hack Nerd Font
font_family     Source Code Pro Nerd Font
font_family     Cascadia Code Nerd Font
```

**Important:** Must be a Nerd Font variant for icon support!

---

## Configuration Overview

### Key Features

#### Visual Enhancements
- **Tab bar:** Powerline style with slanted edges at top
- **Transparency:** 88% opacity for modern look
- **Ligatures:** Enabled for better code display
- **Cursor:** Block style with 0.5s blink interval

#### Performance
- **Scrollback:** 50,000 lines (extensive history)
- **GPU acceleration:** Native kitty feature
- **Shell integration:** Enhanced prompt and command tracking

#### Usability
- **Copy-on-select:** Automatic clipboard copy when selecting text
- **URL detection:** Click URLs to open in browser
- **Tmux-friendly:** All shortcuts use Cmd/Alt to avoid conflicts

### Configuration Structure

```
~/.config/kitty/
├── kitty.conf           # Main configuration (184 lines)
├── themes/              # Color schemes
│   ├── monokai-pro.conf        (default)
│   ├── gruvbox-dark.conf
│   ├── tokyo-night.conf
│   ├── catppuccin-mocha.conf
│   ├── nord.conf
│   └── dracula.conf
├── switch-theme.sh      # Theme switching script
├── README.md           # Usage reference
└── SETUP.md           # This file
```

### Configuration Sections

The `kitty.conf` is organized into clear sections:

1. **Fonts** (Lines 6-18) - Font family, size, ligatures
2. **Cursor** (Lines 22-25) - Cursor appearance and behavior
3. **Scrollback** (Lines 29-31) - History buffer settings
4. **Mouse & Selection** (Lines 35-44) - Mouse behavior, URL handling
5. **Window Layout** (Lines 48-56) - Transparency, padding, borders
6. **Tab Bar** (Lines 60-74) - Tab appearance and formatting
7. **Color Scheme** (Lines 78-89) - Theme inclusion
8. **Advanced** (Lines 93-102) - Shell integration, remote control
9. **Performance** (Lines 106-109) - Rendering settings
10. **Bell** (Lines 113-117) - Notification settings
11. **Keybindings** (Lines 121-164) - All keyboard shortcuts
12. **OS-Specific** (Lines 168-172) - macOS settings
13. **Clipboard** (Lines 176-177) - Clipboard controls

---

## Theme Switching

### Available Themes

| Theme | Description | Colors |
|-------|-------------|--------|
| **Monokai Pro** | Vibrant, modern (default) | Purple/pink accents |
| **Gruvbox Dark** | Warm, retro | Earthy tones |
| **Tokyo Night** | Clean, modern | Blue/purple night sky |
| **Catppuccin Mocha** | Soothing pastels | Warm, cozy colors |
| **Nord** | Arctic palette | North-bluish theme |
| **Dracula** | Classic dark | Vibrant purple accents |

### Method 1: Keyboard Shortcut (Easiest)

Press `Cmd+Shift+T` (macOS) or `Ctrl+Shift+T` (Linux)

This opens the kitty themes kitten with a visual selector.

### Method 2: Command Line Script

```bash
# List available themes
~/.config/kitty/switch-theme.sh

# Switch to a theme
~/.config/kitty/switch-theme.sh tokyo
~/.config/kitty/switch-theme.sh gruvbox
~/.config/kitty/switch-theme.sh catppuccin
~/.config/kitty/switch-theme.sh nord
~/.config/kitty/switch-theme.sh dracula
~/.config/kitty/switch-theme.sh monokai
```

The script will automatically reload kitty if possible.

### Method 3: Manual Edit

1. Open `~/.config/kitty/kitty.conf`
2. Find line 89: `include ./themes/monokai-pro.conf`
3. Change to desired theme:
   ```conf
   include ./themes/tokyo-night.conf
   ```
4. Reload kitty: `Cmd+Shift+R` (macOS) or `Ctrl+Shift+F5` (Linux)

### Theme Preview

To preview themes without permanently switching:

```bash
# Preview a theme temporarily
kitty +kitten themes --reload-in=all Tokyo Night
```

### Creating Custom Themes

1. Create a new file in `~/.config/kitty/themes/`:
   ```bash
   touch ~/.config/kitty/themes/my-theme.conf
   ```

2. Define colors (see existing themes for format):
   ```conf
   # My Custom Theme
   background #1a1b26
   foreground #c0caf5
   cursor #c0caf5

   # 16 colors (color0 through color15)
   color0 #15161e
   # ... etc
   ```

3. Update `switch-theme.sh` to include your theme:
   ```bash
   # Add to THEMES array
   ["mytheme"]="themes/my-theme.conf"
   ```

4. Switch to it:
   ```bash
   ~/.config/kitty/switch-theme.sh mytheme
   ```

---

## Keybinding Reference

All keybindings use `Cmd` on macOS to avoid conflicts with tmux's `Ctrl+s` prefix.

### Tab Management

| Shortcut | Action | Description |
|----------|--------|-------------|
| `Cmd+T` | New tab | Create new tab in current directory |
| `Cmd+W` | Close tab | Close current tab |
| `Cmd+Shift+]` | Next tab | Switch to next tab |
| `Cmd+Shift+[` | Previous tab | Switch to previous tab |
| `Cmd+1-9` | Go to tab N | Jump directly to tab 1-9 |

### Font Size

| Shortcut | Action |
|----------|--------|
| `Cmd+=` | Increase font size |
| `Cmd+-` | Decrease font size |
| `Cmd+0` | Reset to default size |

### Navigation & Scrolling

| Shortcut | Action | Description |
|----------|--------|-------------|
| `Cmd+K` | Previous prompt | Scroll to previous shell prompt |
| `Cmd+J` | Next prompt | Scroll to next shell prompt |
| `Cmd+Shift+H` | Show scrollback | Open scrollback in pager (less) |
| `Cmd+L` | Clear screen | Clear screen and scrollback |

### Clipboard

| Shortcut | Action |
|----------|--------|
| `Cmd+C` | Copy | Copy selected text |
| `Cmd+V` | Paste | Paste from clipboard |

**Note:** Copy-on-select is enabled, so simply selecting text copies it automatically!

### Utilities

| Shortcut | Action | Description |
|----------|--------|-------------|
| `Cmd+Shift+R` | Reload config | Apply config changes without restart |
| `Cmd+Shift+T` | Theme selector | Open theme switching kitten |
| `Cmd+N` | New window | Open new OS window |

### Mouse Actions

- **Left click URL:** Open in default browser
- **Select text:** Automatically copies to clipboard
- **Middle click:** Paste from clipboard
- **Shift+Click:** Extend selection

---

## Tmux Integration

This kitty configuration is designed to work seamlessly with tmux.

### No Conflicts

- **Tmux prefix:** `Ctrl+S` (custom, not default `Ctrl+B`)
- **Kitty shortcuts:** Use `Cmd` key (macOS) or `Alt` (Linux)
- **No overlap:** You can use both simultaneously

### When to Use Which

**Use Kitty tabs when:**
- You want native OS integration
- You need GPU acceleration for each session
- You want independent processes
- You're working locally

**Use Tmux splits when:**
- You need session persistence
- You want to attach/detach sessions
- You're working on remote servers
- You need advanced pane management

### Combined Workflow

```
Kitty Window
├── Tab 1: Local development
│   └── Tmux session: dev
│       ├── Pane 1: Editor
│       ├── Pane 2: Server
│       └── Pane 3: Logs
├── Tab 2: Remote server
│   └── Tmux session: production
│       └── Pane 1: SSH session
└── Tab 3: Documentation
    └── Single shell (no tmux)
```

### Tmux Keybindings (Custom Prefix)

| Shortcut | Action |
|----------|--------|
| `Ctrl+S` | Tmux prefix (not `Ctrl+B`!) |
| `Ctrl+S then C` | New tmux window |
| `Ctrl+S then \|` | Vertical split |
| `Ctrl+S then -` | Horizontal split |
| `Ctrl+S then H/J/K/L` | Navigate panes (vim-style) |

---

## Platform Differences

### macOS (Default)

**Keybindings:** Uses `Cmd` key for all shortcuts

**Clipboard:** Native `pbcopy`/`pbpaste` integration

**Font paths:** `~/Library/Fonts/NerdFonts/`

**No changes needed** - configuration is optimized for macOS!

### Linux

**Keybindings:** Need to change from `Cmd` to `Alt` or `Ctrl+Shift`

#### Adjust Keybindings for Linux

Edit `~/.config/kitty/kitty.conf` and replace:

```bash
# Find and replace in keybindings section (lines 121-164)
# Change from:
map cmd+t new_tab
map cmd+w close_tab
# etc...

# To:
map alt+t new_tab
map alt+w close_tab
# OR
map ctrl+shift+t new_tab
map ctrl+shift+w close_tab
# etc...
```

**Quick replacement command:**
```bash
# Backup first
cp ~/.config/kitty/kitty.conf ~/.config/kitty/kitty.conf.backup

# Replace all cmd+ with alt+
sed -i 's/map cmd+/map alt+/g' ~/.config/kitty/kitty.conf

# OR replace with ctrl+shift+
sed -i 's/map cmd+/map ctrl+shift+/g' ~/.config/kitty/kitty.conf
```

**Clipboard tools:**

- **X11:** Install `xclip`
  ```bash
  sudo apt install xclip
  ```

- **Wayland:** Install `wl-clipboard`
  ```bash
  sudo apt install wl-clipboard
  ```

**Font paths:** `~/.local/share/fonts/`

---

## Customization

### Change Font Size

Edit line 11 in `kitty.conf`:
```conf
font_size       14.0    # Change from 12.0
```

### Adjust Transparency

Edit line 49 in `kitty.conf`:
```conf
background_opacity      0.95    # Change from 0.88
                                # 0.0 = fully transparent
                                # 1.0 = fully opaque
```

### Disable Ligatures

Edit line 18 in `kitty.conf`:
```conf
disable_ligatures always    # Change from 'never'
```

### Change Tab Bar Position

Edit line 61 in `kitty.conf`:
```conf
tab_bar_edge bottom    # Change from 'top'
```

### Disable Copy-on-Select

Edit line 41 in `kitty.conf`:
```conf
copy_on_select no    # Change from 'yes'
```

### Increase Scrollback

Edit line 30 in `kitty.conf`:
```conf
scrollback_lines 100000    # Change from 50000
# Or use -1 for unlimited (uses more memory)
```

### Change Cursor Style

Edit line 23 in `kitty.conf`:
```conf
cursor_shape beam       # Options: block, beam, underline
```

### Add Custom Keybindings

Add to the keybindings section (after line 164):
```conf
# Custom keybindings
map cmd+shift+enter new_window_with_cwd
map cmd+shift+n launch --cwd=current
```

---

## FAQ

### Q: Why do I see broken icons or squares?

**A:** You don't have a Nerd Font installed. Install FiraCode Nerd Font:
```bash
# macOS
brew install --cask font-fira-code-nerd-font

# Linux
# See Font Installation section in main INSTALL.md
```

### Q: How do I reload configuration without restarting?

**A:** Press `Cmd+Shift+R` (macOS) or `Ctrl+Shift+F5` (Linux)

Or run:
```bash
kitty @ load-config
```

### Q: Can I use kitty's built-in window splitting instead of tmux?

**A:** Yes! But this configuration is optimized for tmux usage. To enable kitty splits:

Add to `kitty.conf`:
```conf
map cmd+d new_window_with_cwd
map cmd+shift+d launch --location=split
```

### Q: Theme changed but colors didn't update

**A:** Reload configuration:
- Press `Cmd+Shift+R`
- Or restart kitty

If still not working:
```bash
# Verify theme file exists
ls ~/.config/kitty/themes/

# Check include statement
grep "include" ~/.config/kitty/kitty.conf
```

### Q: How do I make kitty my default terminal?

**macOS:**
1. System Settings → Desktop & Dock
2. Default web browser dropdown → (no similar option exists)
3. Use `cmd+space` to launch kitty via Spotlight
4. Or set in iTerm2 replacement settings if migrating

**Linux:**
```bash
# Debian/Ubuntu
sudo update-alternatives --config x-terminal-emulator

# Select kitty from the list
```

### Q: Can I use multiple configuration files?

**A:** Yes! Use `include` directive:

```conf
# In kitty.conf
include ./custom-keybindings.conf
include ./custom-colors.conf
```

### Q: How do I report issues with kitty configuration?

**A:** Create an issue in the dotfiles repository:
https://github.com/kevin7070/dotfiles/issues

For kitty itself:
https://github.com/kovidgoyal/kitty/issues

### Q: How do I export my current theme as a config file?

**A:** Use kitty's built-in command:
```bash
kitty +kitten themes --dump-theme > ~/.config/kitty/themes/my-current.conf
```

### Q: Does this work on Windows?

**A:** Kitty doesn't officially support Windows. Use WSL2 with Linux installation method.

---

## Performance Tips

### Speed Up Startup

```conf
# Add to kitty.conf
startup_session none
```

### Reduce Memory Usage

```conf
# Lower scrollback
scrollback_lines 10000

# Disable features you don't use
update_check_interval 0
```

### Improve Rendering

```conf
# Adjust repaint delay
repaint_delay 8    # Lower = more responsive, higher CPU

# Sync to monitor
sync_to_monitor yes
```

---

## Additional Resources

- **Kitty Documentation:** https://sw.kovidgoyal.net/kitty/
- **Kitty Kittens (Plugins):** https://sw.kovidgoyal.net/kitty/kittens_intro.html
- **Nerd Fonts:** https://www.nerdfonts.com/
- **Main Installation Guide:** See `INSTALL.md` in dotfiles root
- **Configuration Reference:** See `README.md` in this directory

---

## Troubleshooting

### Kitty won't start

```bash
# Check for syntax errors
kitty --debug-config

# Start with default config
kitty --config=/dev/null
```

### Font issues

```bash
# List available fonts
kitty +list-fonts

# Test font rendering
kitty +kitten unicode_input
```

### Theme not applying

```bash
# Verify theme path
cat ~/.config/kitty/kitty.conf | grep include

# Test theme directly
kitty --config=NONE -o "include ~/.config/kitty/themes/tokyo-night.conf"
```

### Keybindings not working

```bash
# Show current key mapping
kitty --debug-keyboard

# Test in new window
kitty --session=none
```

---

**Last Updated:** 2025-11-06
**Configuration Version:** 1.0
**Kitty Version Required:** 0.26.0+
