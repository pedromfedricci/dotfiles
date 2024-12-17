{pkgs, ...}: {
  programs.atuin = {
    enable = true;
    package = pkgs.unstable.atuin;
    flags = [
      # "--disable-ctrl-r"
      "--disable-up-arrow"
    ];
  };
}
