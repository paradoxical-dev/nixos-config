# Terminals

Provides a list of different terminal emulators to install and configure. Including:

- [Kitty](https://sw.kovidgoyal.net/kitty/)
- [Ghostty](https://ghostty.org/)

Configurations for each of these can be found within their respective nix file. Additionally, theme files are sourced outside of the generated config for easier theme switching. These theme files are stored in the respective sub directory.

## Options

### `terminals`

The desired terminal to install. If multiple terminals are desired, then the individual `<terminal>.enable` options are also provided.

**Type**: `enum`

**Default**: `null`

**Values**: `"kitty"` | `"ghostty"`

### `ghostty.enable`

Enabled the installation and configuration of ghostty

**Type**: `bool`

**Default**: `false`

### `kitty.enable`

Enabled the installation and configuration of Kitty

**Type**: `bool`

**Default**: `false`
