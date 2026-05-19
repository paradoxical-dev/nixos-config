# Editors

Provides a list of different text editors to instal;. Including:

- [Neovim](https://neovim.io/)
- [Emacs](https://www.gnu.org/software/emacs/)
- [VSCodium](https://vscodium.com/)
- [Zed](https://zed.dev/)

Most if not all of the configuration of my editors is handled outside of home-manager, however you can view the contents in each of the respective sub modules in this directory.

> [!NOTE]
>Some extra modules (like emacs) also include other special options.
>

Additionally, I have my personal configs for emacs, neovim and vscodium here  respectively

- [emacs](https://github.com/paradoxical-dev/nexus)
- [neovim](https://github.com/paradoxical-dev/neovim)
- [vscodium](https://github.com/paradoxical-dev/TheForge/tree/main/devices/desktop/configs/VSCodium)

## Options

### `editors`

List of desired editors to install

**Type**: `list[enum]`

**Default**: `[ "nvim" ]`

**Values**: `"nvim"` | `"emacs"` | `"zed"` | `"vscodium"`

### `emacs`

Attribute set with Emacs specific options

#### `mail`

Whether to enable mail capabilities in emacs.

**Type**: `bool`

**Default**: `fale`

#### `eaf.enable`

Enable the [Emacs-Application-Framework](https://github.com/emacs-eaf/emacs-application-framework)

**Type**: `bool`

**Default**: `false`

#### `eaf.apps`

List of EAF apps to include with eaf

**Type**: `list[pkg]`

**Default**: `with pkgs.emacsPackages; [ eaf-browser ]`

#### `extraPkgs`

A list of emacs packages to be installed with the default emacs installation.

**Type**: `list[pkg]`

**Default**: `[]`

> [!NOTE]
> Must be within the `emacsPackages` package set.
