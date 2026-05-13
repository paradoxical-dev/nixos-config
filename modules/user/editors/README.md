# Editors

Provides a list of different text editors to instal;. Including:

- [Neovim](https://neovim.io/)
- [Emacs](https://www.gnu.org/software/emacs/)
- [VSCodium](https://vscodium.com/)
- [Zed](https://zed.dev/)

Most if not all of the configuration of my editors is handled outside of home-manager, however you can view the contents in each of the respective sub modules in this directory.

## Options

### `editors`

List of desired editors to install

**Type**: `list[enum]`

**Default**: `[ "nvim" ]`

**Values**: `"nvim"` | `"emacs"` | `"zed"` | `"vscodium"`
