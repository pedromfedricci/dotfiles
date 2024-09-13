# Links:
# https://github.com/lwfinger/rtw89
# Fix BIOS issue:
# https://github.com/lwfinger/rtw89/issues/214#issuecomment-1406732718
# https://github.com/lwfinger/rtw89/issues/240#issuecomment-1519118474
# https://github.com/lwfinger/rtw89/issues/263#issuecomment-1825310346
# Nix stuff:
# https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/os-specific/linux/rtw89/default.nix#L33
# https://wiki.nixos.org/wiki/Linux_kernel # Loading out-of-kernel modules
# https://nlewo.github.io/nixos-manual-sphinx/configuration/linux-kernel.xml.html
{
  pkgs,
  stdenv,
  lib,
  fetchFromGitHub,
  kernel ? pkgs.linuxPackages_zen.kernel,
}: let
  modDestDir = "$out/lib/modules/${kernel.modDirVersion}/kernel/drivers/net/wireless/realtek/rtw89";
in
  stdenv.mkDerivation {
    pname = "rtw89";
    version = "unstable-2024-08-25";

    src = fetchFromGitHub {
      owner = "lwfinger";
      repo = "rtw89";
      rev = "d1fced1b8a741dc9f92b47c69489c24385945f6e";
      sha256 = "0brh6vl9ca7hjniyhgplr1184v4wkkzhjjqfbf6l14aa517bbnqy";
    };

    nativeBuildInputs = kernel.moduleBuildDependencies;
    makeFlags = kernel.makeFlags ++ ["KSRC=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"];

    enableParallelBuilding = true;

    installPhase = ''
      runHook preInstall

      mkdir -p ${modDestDir}
      find . -name '*.ko' -exec cp --parents {} ${modDestDir} \;
      find ${modDestDir} -name '*.ko' -exec xz -f {} \;

      runHook postInstall
    '';

    meta = with lib; {
      description = " Driver for Realtek 8852AE, 8852BE, and 8853CE, 802.11ax devices";
      homepage = "https://github.com/lwfinger/rtw89";
      license = with licenses; [gpl2Only];
      maintainers = with maintainers; [tvorog];
      platforms = platforms.linux;
      broken = kernel.kernelOlder "5.7";
      priority = -1;
    };
  }
