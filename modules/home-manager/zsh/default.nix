# Zsh:
# https://zsh.sourceforge.io/
#
# Oh My Zsh plugins:
# https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins
{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    package = pkgs.unstable.zsh;
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
