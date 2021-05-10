# NixOS VMM

A nix expression to build OpenBSD VMM friendly ISOs.

## Building

```
 nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage -I nixos-config=iso-builder.nix
```
