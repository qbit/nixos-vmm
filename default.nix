{ config, pkgs, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages;
  boot.kernelModules = [ "virtio_vmmci" "vmm_clock" ];
  boot.blacklistedKernelModules = [ "intel_pmc" ];

  boot.kernelParams = [ "console=ttyS0,115200n8" ];
  boot.extraModulePackages = with pkgs.linuxPackages; [  virtio_vmmci vmm_clock ];
}
