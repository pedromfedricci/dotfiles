{pkgs, ...}: {
  home.packages = with pkgs.unstable; [
    black
    pipenv
    pyright
    python312
    python312Packages.pip
    python312Packages.pylint
    python312Packages.pytest
    ruff # needs at least 0.4.5 for language server preview.
    uv
  ];

  programs.pyenv = {
    enable = true;
    package = pkgs.unstable.pyenv;
    enableZshIntegration = true;
  };

  programs.zsh.oh-my-zsh.plugins = [
    "pip"
    "pipenv"
    "pylint"
    # "pyenv"
    "python"
  ];
}
