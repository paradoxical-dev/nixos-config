# Modules

Contains 2 sub directories, [system](./system/) and [user](./user/). Each of these directories contain modules for installing packages on the system or user level.

Each module defined in the [user](./user/) directory will be assigned under the `userSettings` option of the host's `home.nix` file and each module defined in the [system](./system/) directory will be assigned under the `systemSettings` option of the host's `configuration.nix` file

