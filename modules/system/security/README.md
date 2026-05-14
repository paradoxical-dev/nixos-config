# Security

Enables the installation and configuration of security packages on the system. Security packages inlude:

- [firewall](https://nixos.wiki/wiki/Firewall)
- [fail2ban](https://github.com/fail2ban/fail2ban)
- [unbound](https://www.nlnetlabs.nl/projects/unbound/about/)

Additionally, a `hardening` option is provided. This option enables the use of [nix-mineral](https://github.com/cynicsketch/nix-mineral/tree/main) to further harden the system. This includes options for networking, filesystem and kernel options.

## Options

### `security.firewall`

Enables the installation of a firewall

#### `enable`

Enables the installation of a firewall

**Type**: `bool`

**Default**: `false`

#### `allowSSH`

Enables SSH communications through the firewall

**Type**: `bool`

**Default**: `false`

#### `extraTCPPorts`

A list of additional TCP ports to allow through the firewall

**Type**: `list[port]`

**Default**: `[ ]`

#### `extraUDPPorts`

A list of additional UDP ports to allow through the Firewall

**Type**: `list[port]`

**Default**: `[ ]`

---

### `security.fail2ban`

Enables the installation of fail2ban, a service to block bad logins

#### `enable`

Enables the installation of fail2ban

**Type**: `bool`

**Default**: `false`

---

### `security.unbound`

Enables the installation of unbound, a DNS server

#### `enable`

Enables the installation of unbound

**Type**: `bool`

**Default**: `false`

---

### `security.hardening`

Enables the use of nix-mineral to further harden the system

#### `enable`

Enables the use of nix-mineral

**Type**: `bool`

**Default**: `false`

#### `preset`

The preset to use for nix-mineral. See [here](https://github.com/cynicsketch/nix-mineral) for more information

**Type**: `enum`

**Default**: `"compatibility"`

**Values**: `[ "compatibility", "maximum", "performance" ]`

