{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    package = pkgs.zsh;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    sessionVariables = {
      SHELL = "zsh";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [
        "asdf"
        "bun"
        "docker"
        "fd"
        "gh"
        "helm"
        "podman"
        "ripgrep"
        "kubectl"
      ];
    };
  };
}
