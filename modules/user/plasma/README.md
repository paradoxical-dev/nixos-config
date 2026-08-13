# Plasma

Different from the system [plasma module](../../system/plasma), this module uses the plasma-manager module to declaratively set the plasma settings.

> [!note]
> This module does *not* include plugin settings or panel settings. These would need to be added manually and I couldn't be bothered to do so. See the wiki page on [plasma-manager](https://nixos.wiki/wiki/Plasma-Manager)

## Options

### `plasma.enable`

Enables the home-manager configuration of plasma settings using plasma-manager

**Type**: `bool`

**Default**: `false`
