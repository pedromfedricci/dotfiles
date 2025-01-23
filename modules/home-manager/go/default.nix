{pkgs, ...}: {
  home.packages = with pkgs.unstable; [
    delve
    golangci-lint-langserver
    gopls
    gotools
  ];

  programs.go = {
    enable = true;
    package = pkgs.unstable.go;
  };

  # programs.zsh.oh-my-zsh.plugins = [
  # "golang"
  # ];
}
