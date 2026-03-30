{
  # Fish:
  # https://fishshell.com/
  # Docs:
  # https://fishshell.com/docs/current/index.html
  flake.homeModules.fish = {pkgs, ...}: {
    programs.fish = {
      enable = true;
      package = pkgs.unstable.fish;
      interactiveShellInit = ''
        set fish_greeting
      '';
    };
  };
}
