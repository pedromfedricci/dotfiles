{pkgs, ...}: {
  home.packages = with pkgs.unstable; [
    gopls
    delve
    gotools
  ];

  programs.go = {
    enable = true;
    package = pkgs.unstable.go;
  };

  programs.zsh.oh-my-zsh.plugins = [
    # "golang"
  ];
}
