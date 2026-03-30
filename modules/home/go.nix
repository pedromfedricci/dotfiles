{
  flake.homeModules.go = {pkgs, ...}: {
    home.packages = with pkgs; [
      delve
      golangci-lint
      golangci-lint-langserver
      gopls
      gotools
    ];

    programs.go.enable = true;
  };
}
