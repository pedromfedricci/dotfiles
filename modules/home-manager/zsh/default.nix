{...}: {
  programs.zsh = {
    enable = true;
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
        "gh"
        "helm"
        "podman"
        "python"
        "rust"
        "ripgrep"
        "kubectl"
      ];
    };
  };
}
