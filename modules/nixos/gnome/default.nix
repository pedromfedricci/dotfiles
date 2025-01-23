{lib, ...}: {
  # Power settings for laptop.
  # Links:
  # https://wiki.archlinux.org/title/GNOME#Power
  # https://discourse.nixos.org/t/changing-gdm-gsettings-declaratively/49579/5
  programs.dconf.profiles.gdm.databases = [
    {
      settings."org/gnome/settings-daemon/plugins/power" = {
        power-button-action = "suspend";
        sleep-inactive-ac-timeout = lib.gvariant.mkInt32 3600;
        sleep-inactive-ac-type = "hibernate";
        sleep-inactive-battery-timeout = lib.gvariant.mkInt32 1800;
        sleep-inactive-battery-type = "hibernate";
      };
      # To disable lock screen:
      # settings."org/gnome/desktop/" = {
      #   disable-lock-screen = true;
      # };
      # To keep the monitor active when the lid is closed:
      # settings."org/gnome/settings-daemon/plugin/xrandr" = {
      #   default-monitors-setup = "do-nothing";
      # };
    }
  ];
}
