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
    historySubstringSearch.enable = true;
    zprof.enable = false;
    sessionVariables = {
      SHELL = "zsh";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [
        # "docker"
        # "helm"
        # "gh"
        # "kubectl"
      ];
    };
  };
}
