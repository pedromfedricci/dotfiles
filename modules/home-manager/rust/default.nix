{pkgs, ...}: {
  home.packages = with pkgs; [
    rustup
    cargo-expand
    cargo-make
    cargo-nextest
    cargo-tarpaulin
    cargo-hack
    cargo-watch
  ];

  home.sessionPath = [
    "$HOME/.cargo/bin"
  ];

  programs.zsh.oh-my-zsh.plugins = [
    "rust"
  ];
}
