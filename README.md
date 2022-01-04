# NixOS VMM

A nix expression to:
  - Build an install ISO for OpenBSD's VMM.
  - Configure a running system to use [vmm_clock](https://github.com/voutilad/vmm_clock) and [virtio_vmmci](https://github.com/voutilad/virtio_vmmci).

## What it does:

Creates a NixOS install ISO or system with the following pre-configured for OpenBSD's
VMM:

- NixOS will use the serial console: `console=ttyS0,115200n8`.
- [vmm_clock](https://github.com/voutilad/vmm_clock) and [virtio_vmmci](https://github.com/voutilad/virtio_vmmci) kernel modules are installed.
- Installs `tmux`, `vim` and `mg` into the ram disk for usage during the
  install.

## Using via configuration.nix

```
{ config, lib, ... }:

let
  ...
  openbsdVMM = builtins.fetchGit {
    url = "https://github.com/qbit/nixos-vmm.git";
    ref = "refs/tags/v1.0.0";
  };
  ...

in {
  imports =
  [
    ...
    (import "${openbsdVMM}")
    ...
  ];
  ...
}
```

## Building an ISO

```
nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage -I nixos-config=iso-builder.nix
```

Will result in:

```
% ls result/iso
nixos-20.09.4064.1b688ca59ba-x86_64-linux.iso
%
```

### Pre-built ISO

If you don't have an existing NixOS machine to build the ISO with, here is a pre-built ISO that can be used:

| File | Purpose |
| --- | --- |
| [nixos-21.11.334934.8a053bc2255-x86_64-linux.iso](https://deftly.net/nixos-21.11.334934.8a053bc2255-x86_64-linux.iso) | Minimal install ISO with vmm kernel modules |
| [nixos-21.11.334934.8a053bc2255-x86_64-linux.iso.sha256](https://deftly.net/nixos-21.11.334934.8a053bc2255-x86_64-linux.iso.sha256) | SHA256 signature for the ISO |
| [nixos-21.11.334934.8a053bc2255-x86_64-linux.iso.sha256.asc](https://deftly.net/nixos-21.11.334934.8a053bc2255-x86_64-linux.iso.sha256.asc) | GPG Signature for the sha256 file |


