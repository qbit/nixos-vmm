{ config, pkgs, ... }:

let
  vmmClock = config.boot.kernelPackages.callPackage ./vmm_clock.nix { };
  virtioVmmci = config.boot.kernelPackages.callPackage ./virtio_vmmci.nix { };
in {
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = [ "virtio_vmmci" "vmm_clock" ];

  boot.kernelParams = [ "console=ttyS0,115200n8" ];
  boot.extraModulePackages = [ virtioVmmci vmmClock ];
}
