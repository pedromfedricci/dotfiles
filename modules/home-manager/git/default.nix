{
  pkgs,
  user,
  ...
}: {
  programs.git = {
    enable = true;
    package = pkgs.git;
    userName = user.userName;
    userEmail = user.userEmail;
    signing = {
      key = null;
      signByDefault = true;
    };
    extraConfig = {
      merge = {
        conflictstyle = "zdiff3";
      };
    };
  };

  programs.zsh.oh-my-zsh.plugins = [
    # "git"
    # "gitlfs"
    # "github"
    # "gitignore"
    # "git-prompt"
  ];
}
