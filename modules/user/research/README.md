# Research

Enables a bundle of packages commonly used for research.

Packages include:

- [pandoc](https://pandoc.org/)
- [zotero](https://www.zotero.org/)
- [texlive](https://www.tug.org/texlive/)

## Options

### `research.enable`

Enabled the package bundle

**Type**: `bool`

**Default**: `false`

### `research.texlivePackages`

A list of texlive packages to include

**Type**: `list[package]`

**Default**: `[ pkgs.texliveSmall ]`
