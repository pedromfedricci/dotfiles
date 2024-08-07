{pkgs, ...}: {
  programs.direnv = {
    enable = true;
    package = pkgs.unstable.direnv;
    nix-direnv.enable = true;
    # enableZshIntegration = true;
  };

  programs.zsh = {
    oh-my-zsh = {
      plugins = ["direnv"];
    };
  };
}
