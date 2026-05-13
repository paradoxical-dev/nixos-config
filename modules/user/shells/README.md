# Shells

Install and configure the desired shell(s). Supported shells include:

- [bash](https://www.gnu.org/software/bash/)
- [zsh](https://zsh.sourceforge.io/)
- [nushell](https://www.nushell.sh/)

Along with the shell configurations, a submodule for [starship](https://starship.rs/) is included for prompt customization

## Options

### `shells`

A list of shells to install and configure. 

**Type**: `list[enum]`

**Default**: `[ "zsh" ]`

**Values**: `"bash"` | `"zsh"` | `"nushell"`
