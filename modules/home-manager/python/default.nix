{pkgs, ...}: {
  home.packages = with pkgs.unstable; [
    black
    # pipenv
    poetry
    pipx
    pylint
    pylyzer
    pyright
    python314
    ruff
    uv
  ];

  programs.pyenv = {
    enable = true;
    package = pkgs.unstable.pyenv;
  };

  # programs.zsh.oh-my-zsh.plugins = [
  # "pip" # completions, aliases
  # "pipenv" # activation, completions, aliases
  # "pylint" # completions, aliases
  # "python" # aliases
  # ];
}
