# nixos-config

A modular configuration for [NixOS](https://nixos.org/), supporting multiple machines from a single repository

SCREENSHOTS HERE

# Introduction

This project is a collection of modules for an easy installation of NixOS across different machines.

Each module is a self-contained Nix expression that can be used to install the provided package(s). Each host will be contained within the [hosts](hosts/README.md) directory. The host's directory must also contain each of:

- [configuration.nix](hosts/TheBando/configuration.nix)
- [home.nix](hosts/TheBando/home.nix)
- [hardware-configuration.nix](hosts/TheBando/hardware-configuration.nix)

> [!WARNING]
> Hosts contained within the [hosts](hosts/README.md) directory must exactly match the desired hostname of the given machine.

## Structure

Modules are declared within the [modules](modules/README.md) directory within either the [system](modules/system/README.md) or [user](modules/user/README.md) sub directory.

Each module contained within either of these directories will also cotnain a `README` file covering the options provided, the packages it enables, and how to enable them.

# Installation

Installing this config *should* be as simple as:

1. Enable flakes

  Go to your base configuration.nix (/etc/nixos/configuration.nix) and enable the `experimental-features` option and set it to `nix-command flakes`.

2. Clone the repository

```bash
git clone https://github.com/paradoxical-dev/nixos-config.git <destination path>
```

3. Run `sudo nixos-rebuild switch --flake <repo path>`

> [!NOTE]
> Deppending on the cloned path, you will need to change the following option in your base home.nix:
> `userSettings` -> `dotfilesDir`
> Otherwise, the option will default to `/etc/nixos`

