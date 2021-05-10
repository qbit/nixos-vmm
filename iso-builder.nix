{config, pkgs, ...}:

let
  vmmClock = config.boot.kernelPackages.callPackage ./vmm_clock.nix { };
  virtioVmmci = config.boot.kernelPackages.callPackage ./virtio_vmmci.nix { };

in {
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>
    <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = [ "virtio_vmmci" "vmm_clock" ]; 
  
  boot.kernelParams = [
    "console=ttyS0,115200n8"
  ];
  boot.extraModulePackages = [ virtioVmmci vmmClock ];

  environment.systemPackages = with pkgs; [ tmux vim mg ];
}

