# Browser

Installs the desired browser to the system. Currently supports:

- [Firefox](https://www.mozilla.org/en-US/firefox/new/)
- [Brave](https://brave.com/)
- [LibreWolf](https://librewolf.net/)

## Options

### `browser`

The desired browser to install. If multiple browsers are desired, then the individual `<browser>.enable` options are also provided.

**Type**: `enum`

**Default**: `null`

**Values**: `"firefox"` | `"brave"` | `"librewolf"`

### `firefox.enable`

Enabled the installation and configuration of Firefox

**Type**: `bool`

**Default**: `false`

### `brave.enable`

Enabled the installation and configuration of Brave

**Type**: `bool`

**Default**: `false`

### `librewolf.enable`

Enabled the installation and configuration of LibreWolf

**Type**: `bool`

**Default**: `false`
