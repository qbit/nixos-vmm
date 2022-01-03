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

