# nixos-config

A modular configuration for [NixOS](https://nixos.org/), able to be run on any system. 

Provides a set of modules for enabling/disabling parts of the system, so each install is exactly as described.

SCREENSHOTS HERE

# Introduction

This project is a collection of modules for an easy installation of NixOS across different machines.

Each module is a self-contained Nix expression that can be used to install the provided package(s). Each host will be contained within the [hosts](https://github.com/paradoxical-dev/nixos-config/tree/main/hosts/) directory. The host's directory must also contain each of:

- configuration.nix
- home.nix
- hardware-configuration.nix

> [!WARNING]
> Hosts contained within the [hosts](https://github.com/paradoxical-dev/nixos-config/tree/main/hosts/) directory must exactly match the desired hostname of the given machine.

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

