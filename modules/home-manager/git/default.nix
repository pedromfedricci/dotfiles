{
  pkgs,
  user,
  ...
}: {
  programs.git = {
    enable = true;
    package = pkgs.git;
    signing = {
      key = null;
      signByDefault = true;
    };
    settings = {
      user.name = user.userName;
      user.email = user.userEmail;
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
