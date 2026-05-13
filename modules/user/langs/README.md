# Languages

Defines what languages to install on the system, along with language specific packages. Each language submodule is defined in its respective nix file.

Also provides an option to install [Zeal](https://zealdocs.org/) for offline language documentation.

## Options

### `langs.zeal.enable`

Enables the installation of Zeal

**Type**: `bool`

**Default**: `false`

### `langs.python`

An attribute set to describe installing python on the system

#### `enable`

Enables the installation of python (uses the python3 package)

**Type**: `bool`

**Default**: `false`

#### `extraPackages`

A list of additional python packages to install

**Type**: `list[package]`

**Default**: `[ ]`

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

#### `extraPackages`

A list of additional nodejs packages to install

**Type**: `list[package]`

**Default**: `[ ]`

### `langs.rust`

An attribute set to describe installing rust on the system

#### `enable`

Enables the installation of rust

**Type**: `bool`

**Default**: `false`

#### `extraPackages`

A list of additional rust packages to install
