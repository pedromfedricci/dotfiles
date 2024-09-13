# Driver for device 10a5:9800 from FPC is not supported by libfprint since it is
# proprietary, and the FPC driver does not supports libfprint-TOD to be loaded
# as an external shared library.
# See discussion:
# https://gitlab.freedesktop.org/libfprint/libfprint/-/merge_requests/396
# https://gitlab.freedesktop.org/libfprint/libfprint/-/merge_requests/432
# Lenovo:
# https://pcsupport.lenovo.com/us/en/products/laptops-and-netbooks/thinkpad-edge-laptops/thinkpad-e14-gen-4-type-21eb-and-21ec/downloads/ds560939-elan-fingerprint-driver-for-ubuntu-2204-thinkpad-e14-gen-4-e15-gen-4
{pkgs, ...}: let
  fpcbep = pkgs.fetchzip {
    url = "https://download.lenovo.com/pccbbs/mobiles/r1slm01w.zip";
    hash = "sha256-/buXlp/WwL16dsdgrmNRxyudmdo9m1HWX0eeaARbI3Q=";
    stripRoot = false;
  };
  libfprint = pkgs.libfprint.overrideAttrs (attrs: {
    patches =
      attrs.patches
      or []
      ++ [
        (pkgs.fetchpatch {
          url = "https://gitlab.freedesktop.org/libfprint/libfprint/-/merge_requests/396.patch";
          sha256 = "sha256-+5B5TPrl0ZCuuLvKNsGtpiU0OiJO7+Q/iz1+/2U4Taw=";
        })
      ];
    postPatch =
      (attrs.postPatch or "")
      + ''
        substituteInPlace meson.build \
          --replace "find_library('fpcbep', required: true)" "find_library('fpcbep', required: true, dirs: '$out/lib')"
      '';
    preConfigure =
      (attrs.preConfigure or "")
      + ''
        install -D "${fpcbep}/FPC_driver_linux_27.26.23.39/install_fpc/libfpcbep.so" "$out/lib/libfpcbep.so"
      '';
    postInstall =
      (attrs.postInstall or "")
      + ''
        install -Dm644 "${fpcbep}/FPC_driver_linux_libfprint/install_libfprint/lib/udev/rules.d/60-libfprint-2-device-fpc.rules" "$out/lib/udev/rules.d/60-libfprint-2-device-fpc.rules"
        substituteInPlace "$out/lib/udev/rules.d/70-libfprint-2.rules" --replace "/bin/sh" "${pkgs.runtimeShell}"
      '';
  });
  fprintd = pkgs.fprintd.override {inherit libfprint;};
in {
  services.fprintd = {
    enable = true;
    package = fprintd;
    # tod.enable = true;
  };
  services.udev.packages = [libfprint];
}
