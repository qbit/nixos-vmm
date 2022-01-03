{ stdenv, lib, fetchFromGitHub, kernel, kmod }:

stdenv.mkDerivation rec {
  name = "vmm_clock";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "voutilad";
    repo = "vmm_clock";
    rev = "${version}";
    # nix-prefetch-url --unpack https://github.com/voutilad/vmm_clock/archive/master.zip
    sha256 = "0hg7ywznh6v11fywsz6f7w298bxph0wwm046zqaqncjvr4aizla4";
  };

  hardeningDisable = [ "pic" "format" ];
  nativeBuildInputs = kernel.moduleBuildDependencies;

  extraConfig = ''
    CONFIG_RTC_HCTOSYS yes
  '';

  makeFlags = [
    "DEPMOD=echo"
    "INSTALL_MOD_PATH=$(out)"
    "KERNELRELEASE=${kernel.modDirVersion}"
    "KERNELDIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
  ];

  meta = with lib; {
    description =
      "Experimental implementation of a kvmclock-derived clocksource for Linux guests under OpenBSD's hypervisor";
    homepage = "https://github.com/voutilad/vmm_clock";
    license = licenses.gpl2;
    maintainers = [ maintainers.makefu ];
    platforms = platforms.linux;
  };
}

