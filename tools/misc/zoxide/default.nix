{ pkgs, ... }:

{
  programs.zoxide = {
    enable = true;
    package = pkgs.zoxide;
    # enableZshIntegration = true;
  };

  programs.zsh = {
    sessionVariables = {
      ZOXIDE_CMD_OVERRIDE = "cd";
    };
    oh-my-zsh = {
      plugins = [ "zoxide" ];
    };
  };
}
