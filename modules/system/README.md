# System Modules

Contains the modules for installing packages on the system level. Each option provided is described within the `README` of the containing modules directory.

Within this directory there is also a [default.nix](./default.nix) file. This file imports every module within this directory to define the available optoins within `systemSettings`.

Also contained in this directory is the [configuration.nix](./configuration.nix) file. This file describes the base packages and default system nix options for every install.

## Modules

- [audio](./audio/)
- [bluetooth](./bluetooth/)
- [documentation](./documentation/) 
- [fonts](./fonts/)
- [gnome](./gnome/)
- [kernel](./kernel/)
- [nix](./nix/)
- [printing](./printing/)
- [users](./users/)
