{pkgs, ...}: {
  services = {
    kanshi.enable = true;
  };

  # Used by kanshi-cycle.sh script.
  home.packages = [
    pkgs.bash
  ];

  # Used by kanshi-cycle.sh script.
  programs = {
    jq.enable = true;
  };
}
