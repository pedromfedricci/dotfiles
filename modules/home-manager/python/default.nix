{pkgs, ...}: {
  home.packages = with pkgs; [
    python312
    pyright
    python312Packages.pytest
    unstable.ruff # needs at least 0.4.5 for language server preview.
  ];
}
