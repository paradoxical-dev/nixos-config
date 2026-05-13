# CLI

This module provides two different options for cli packages to install on the system

- **Base**
    This installs base cli packages I have on almost every system. The list includes:
     - bat
     - bottom
     - brightnessctl
     - eza
     - fd 
     - file
     - hwinfo
     - jiq
     - jq 
     - lazygit
     - libnotify
     - ripgrep
     - ripgrep-all
     - rsync
     - smartmontools
     - tealdeer
     - unzip
     - w3m
     - zip

     On top of this, the base bundle will enable options for fzf and tmux. The modules for those can be found in their respective sub directories.

- **Extra**
    This includes some extra, less necessary cli tools, mostly just for aesthetic reasons

    - figlet
    - cahfa
    - fastfetch

## Options

### `cli`

The desired cli package bundle to install

**Type**: `enum`

**Default**: `null`

**Values**: `"base"` | `"extra"`
