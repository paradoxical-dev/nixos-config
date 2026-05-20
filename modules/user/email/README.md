# Email

Sets up email syncing for different accounts on the host. Allows for per account configuration via the `accounts` option. See more details in the Options section.

TODO: add email clients

## Options

### `email.enable`

Enables the mail services

**Type**: `bool`

**Default**: `false`

---

### `email.maildirBase`

The base mail directory. Each account will have its own sub directory within this directory.

**Type**: `string`

**Default**: `~/Mail`

---

### `email.clients`

TODO

---

### `email.accounts`

This is where each desired account is configured. It will contain named sub modules with each one containing the configuration for that account using the options below.

The name of the configuration will be used as the accounts name and stored in the base mail directory. For an example see [my configuration](../../../hosts/TheBando/home.nix)

**Type**: `submodule`

**Default**: `{}`

#### `options.address`

Required field. The accounts email address

**Type**: `string`

#### `realName`

Required field. The accounts real name

**Type**: `string`

#### `imap.host`

Required field. The imap server's hostname

**Type**: `string`

#### `smtp.host`

Required field. The smtp server's hostname

**Type**: `string`

#### `primary`

Describes if this account is the primary account

**Type**: `bool`

**Default**: `false`

#### `mbsync.patterns`

The patterns to match for when syncing this accounts mail.

**Type**: `list[string]`

**Default**: `[ "*" ]`

#### `mbsync.expunge`

Describes when to expunge a deleted message

**Type**: `enum`

**Default**: `"both"`

**Values**: `"none" | "both" | "remote" | "local"`
