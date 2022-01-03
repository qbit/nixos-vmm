# NixOS VMM

A nix expression to:
  - Build an install ISO for OpenBSD's VMM.
  - Configure a running system to use [vmm_clock](https://github.com/voutilad/vmm_clock) and [virtio_vmmci](https://github.com/voutilad/virtio_vmmci).

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

