# Languages

Defines what languages to install on the system, along with language specific packages. Each language submodule is defined in its respective nix file.

Also provides an option to install [Zeal](https://zealdocs.org/) for offline language documentation.

## Options

### `langs.zeal.enable`

Enables the installation of Zeal

**Type**: `bool`

**Default**: `false`

---

### `langs.python`

An attribute set to describe installing python on the system

#### `enable`

Enables the installation of python (uses the python3 package)

**Type**: `bool`

**Default**: `false`

#### `lsp.enable`

Enable installing a python LSP

**Type**: `bool`

**Default**: `false`

#### `lsp.packages`

A list of python LSPs to install

**Type**: `list[package]`

**Default**: `[ pkgs.pyright ]`

#### `formatter.enable`

Enable installing a python formatter

**Type**: `bool`

**Default**: `false`

#### `formatter.packages`

A list of python formatters to install

**Type**: `list[package]`

**Default**: `[ pkgs.ruff ]`

#### `extraPackages`

A list of additional python packages to install. Packages must be within the `python3Packages` package set. See an example in my [home.nix](../../../hosts/TheBando/home.nix)

**Type**: `list[package]`

**Default**: `[ ]`

---

### `langs.node`

An attribute set to describe installing nodejs on the system

#### `enable`

Enables the installation of nodejs

**Type**: `bool`

**Default**: `false`

#### `nodemon.enable`

Enables the systemwide installation of nodemon

**Type**: `bool`

**Default**: `false`

#### `lsp.enable`

Enable installing a JS/TS LSP

**Type**: `bool`

**Default**: `false`

#### `lsp.packages`

A list of JS/TS LSPs to install

**Type**: `list[package]`

**Default**: `[ pkgs.typescript pkgs.typescript-language-server ]`

#### `formatter.enable`

Enable installing a JS/TS formatter

**Type**: `bool`

**Default**: `false`

#### `formatter.packages`

A list of JS/TS formatters to install

**Type**: `list[package]`

**Default**: `[ pkgs.prettier ]`

#### `extraPackages`

A list of additional nodejs packages to install

**Type**: `list[package]`

**Default**: `[ ]`

---

### `langs.rust`

An attribute set to describe installing rust on the system

#### `enable`

Enables the installation of rust

**Type**: `bool`

**Default**: `false`

#### `lsp.enable`

Enable installing a rust LSP

**Type**: `bool`

**Default**: `false`

#### `lsp.packages`

A list of rust LSPs to install

**Type**: `list[package]`

**Default**: `[ pkgs.rust-analyzer ]`

#### `formatter.enable`

Enable installing a rust formatter

**Type**: `bool`

**Default**: `false`

#### `formatter.packages`

A list of rust formatters to install

**Type**: `list[package]`

**Default**: `[ pkgs.rustfmt ]`

#### `extraPackages`

A list of additional rust packages to install

---

### `langs.lua`

An attribute set to describe installing lua on the system

#### `enable`

Enables the installation of language

**Type**: `bool`

**Default**: `false`

#### `lsp.enable`

Enable installing a lua LSP

**Type**: `bool`

**Default**: `false`

#### `lsp.packages`

A list of lua LSPs to install

**Type**: `list[package]`

**Default**: `[ pkgs.lua-language-server ]`

#### `formatter.enable`

Enable installing a lua formatter

**Type**: `bool`

**Default**: `false`

#### `formatter.packages`

A list of lua formatters to install

**Type**: `list[package]`

**Default**: `[ pkgs.stylua ]
