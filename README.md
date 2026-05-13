# nixos-config

A modular configuration for [NixOS](https://nixos.org/), supporting multiple machines from a single repository

SCREENSHOTS HERE

# Introduction

This project is a collection of modules for an easy installation of NixOS across different machines.

Each module is a self-contained Nix expression that can be used to install the provided package(s). Each host will be contained within the [hosts](hosts/) directory. The host's directory must also contain each of:

- [configuration.nix](hosts/TheBando/configuration.nix)
- [home.nix](hosts/TheBando/home.nix)
- [hardware-configuration.nix](hosts/TheBando/hardware-configuration.nix)

> [!WARNING]
> Hosts contained within the [hosts](hosts/) directory must exactly match the desired hostname of the given machine.

## Structure

Modules are declared within the [modules](modules/) directory within either the [system](modules/system/) or [user](modules/user/) sub directory.

Each module contained within either of these directories will also cotnain a `README` file covering the options provided, the packages it enables, and how to enable them.

# Installation

Installing this config *should* be as simple as:

1. Enable flakes

  Go to your base `configuration.nix` (`/etc/nixos/configuration.nix`) and enable the `experimental-features` option and set it to `nix-command flakes`:

  ```nix
  experimental-features = [ "nix-command" "flakes" ];
  ```

2. Fork the repository

> [!WARNING]
> REPLACE `<destination path>` with the path you want to clone the repository to

```bash
git clone https://github.com/paradoxical-dev/nixos-config.git <destination path>
```

3. Create your hosts directory and files

Within the repo, create a new host directory by copying the [TEMPLATE](hosts/TEMPLATE) directory and rename it to the systems hostname. For example if your hostname was Test:

```bash
# from within the repo's cloned directory
cp -r hosts/TEMPLATE hosts/Test
```

Then copy over the `hardware-configuration.nix` file

```bash
cp /etc/nixos/hardware-configuration.nix hosts/Test/hardware-configuration.nix
```

After that, you'll need to edit the `configuration.nix` and `home.nix` files within the host's directory. These files will define the packages that the system will install.

> [!NOTE]
> See my [configuration](hosts/TheBando/configuration.nix) and [home](hosts/TheBando/home.nix) files for examples

4. Run `sudo nixos-rebuild switch --flake <repo path>`

> [!NOTE]
> Depending on the cloned path, you will need to change the following option in your base home.nix:
> `userSettings` -> `dotfilesDir`
> Otherwise, the option will default to `/etc/nixos`

