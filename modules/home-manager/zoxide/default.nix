# Zoxide:
# https://github.com/ajeetdsouza/zoxide
{pkgs, ...}: {
  programs.zoxide = {
    enable = true;
    package = pkgs.unstable.zoxide;
    # enableZshIntegration = true;
  };

  programs.zsh = {
    sessionVariables = {
      ZOXIDE_CMD_OVERRIDE = "cd";
    };
    oh-my-zsh = {
      # Plugin:
      # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/zoxide
      plugins = ["zoxide"];
    };
  };
}
