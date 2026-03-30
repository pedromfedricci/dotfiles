{
  # Zoxide:
  # https://github.com/ajeetdsouza/zoxide
  flake.homeModules.zoxide = {pkgs, ...}: {
    programs.zoxide = {
      enable = true;
      package = pkgs.zoxide;
      options = ["--cmd cd"];
    };
  };
}
