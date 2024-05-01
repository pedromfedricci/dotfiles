{ pkgs, user, ... }:

{
  programs.git = {
    enable = true;
    package = pkgs.git;
    userName = user.userName;
    userEmail = user.userEmail;
    signing = {
      key = null;
      signByDefault = true;
    };
  };

  programs.zsh = {
    oh-my-zsh = {
      plugins = [ "git" ];
    };
  };
}
