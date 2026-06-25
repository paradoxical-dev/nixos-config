# Niri

This module is meant to be enabled in tandem with the [system niri module](../../system/niri) and handles the configuration for the compositor as well as (optionally) [noctalia](https://noctalia.dev/).

It configures some defaults for the niri compositor including keybindings and extra DE apps to install.

## Options

### `niri.enable`

Enables the home-manager configuration of niri

**Type**: `bool`

**Default**: `false`

### `niri.noctalia.enable`

Enables noctalia shell for niri at startup

**Type**: `bool`

**Default**: `false`
