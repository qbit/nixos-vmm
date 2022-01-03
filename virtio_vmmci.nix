{ stdenv, lib, fetchFromGitHub, kernel, kmod }:

stdenv.mkDerivation rec {
  name = "virtio_vmmci";
  version = "0.4.0";

  src = fetchFromGitHub {
    owner = "voutilad";
    repo = "virtio_vmmci";
    rev = "${version}";
    sha256 = "104xnpcy5kb4y7ipy1fx1v6byddzs63bv2dqjy3yl23n764fsy43";
  };

  hardeningDisable = [ "pic" "format" ];
  nativeBuildInputs = kernel.moduleBuildDependencies;

  extraConfig = ''
    CONFIG_RTC_HCTOSYS yes
  '';

  makeFlags = [
    "INSTALL_MOD_PATH=$(out)"
    "DEPMOD=echo"
    "KERNELRELEASE=${kernel.modDirVersion}"
    "KERNELDIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
  ];

  meta = with lib; {
    description = "An OpenBSD VMM Control Interface (vmmci) for Linux";
    homepage = "https://github.com/voutilad/virtio_vmmci";
    license = licenses.gpl2;
    maintainers = [ maintainers.makefu ];
    platforms = platforms.linux;
  };
}

