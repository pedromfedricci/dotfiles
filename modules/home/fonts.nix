{
  flake.homeModules.fonts = {pkgs, ...}: {
    home.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      nerd-fonts.monaspace
      nerd-fonts.fira-code
    ];
  };
}
