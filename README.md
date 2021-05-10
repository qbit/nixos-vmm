# NixOS VMM

A nix expression to build OpenBSD VMM friendly ISOs.

## What it does:

- Configures NixOS to use the serial console: `console=ttyS0,115200n8`.
- Installs the [vmm_clock](https://github.com/voutilad/vmm_clock) and [virtio_vmmci](https://github.com/voutilad/virtio_vmmci) kernel modules.
- Installs `tmux`, `vim` and `mg` into the ram disk for usage during the
  install.

## Building

```
nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage -I nixos-config=iso-builder.nix
```

Will result in:

```
% ls result/iso
nixos-20.09.4064.1b688ca59ba-x86_64-linux.iso
%
```
