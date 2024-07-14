{pkgs, ...}: {
  programs.atuin = {
    enable = true;
    package = pkgs.unstable.atuin;
    enableZshIntegration = true;
    flags = ["--disable-up-arrow"];
  };
}
