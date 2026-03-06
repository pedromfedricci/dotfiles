# Links:
# https://nixos.wiki/wiki/Bluetooth
# https://mynixos.com/nixpkgs/options/hardware.bluetooth
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    bluez-experimental
  ];

  services.blueman.enable = false;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        # Shows battery charge of connected devices on supported
        # Bluetooth adapters. Defaults to 'false'.
        Experimental = true;

        # When enabled other devices can connect faster to us, however
        # the tradeoff is increased power consumption. Defaults to
        # 'false'.
        FastConnectable = false;
      };
      Policy = {
        # Enable all controllers when they are found. This includes
        # adapters present on start as well as adapters that are plugged
        # in later on. Defaults to 'true'.
        AutoEnable = true;
      };
    };
  };
}
