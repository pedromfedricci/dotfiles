{
  # Links:
  # https://man.archlinux.org/man/extra/swayidle/swayidle.1.en
  # https://mynixos.com/home-manager/options/services.swayidle
  # https://wiki.nixos.org/wiki/Swayidle
  #
  # https://niri-wm.github.io/niri/IPC.html
  # https://docs.noctalia.dev/getting-started/keybinds/system-controls/
  flake.homeModules.swayidle = {
    pkgs,
    inputs,
    ...
  }: let
    noctalia_pkg = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;
    niri_pkg = pkgs.niri;
    systemd_pkg = pkgs.systemd;
  in {
    home.packages = with pkgs; [
      brightnessctl
    ];

    services.swayidle = let
      noctalia = "${noctalia_pkg}/bin/noctalia-shell";
      toast = msg: "${noctalia} ipc call toast send '{\"title\": \"${msg}\"}'";
      lock = "${noctalia} ipc call lockScreen lock";

      niri = "${niri_pkg}/bin/niri";
      display = status: "${niri} msg action power-${status}-monitors";

      systemctl = "${systemd_pkg}/bin/systemctl";
      suspend-then-hibernate = "${systemctl} suspend-then-hibernate";
    in {
      enable = true;
      timeouts = [
        # {
        #   timeout = 10;
        #   command = "brightnessctl -s set 10";
        #   resumeCommand = "brightnessctl -r";
        # }
        {
          timeout = 590;
          command = toast "Locking in 10 seconds";
        }
        {
          timeout = 600; # 10 minutes.
          command = lock;
        }
        {
          timeout = 900; # 15 minutes.
          command = display "off";
        }
        {
          timeout = 1800; # 30 minutes.
          command = suspend-then-hibernate;
        }
      ];
      events = [
        {
          # Lock before sleep.
          event = "before-sleep";
          command = lock;
        }
        {
          # Turn monitors on after resume.
          event = "after-resume";
          command = display "on";
        }
      ];
    };
  };
}
