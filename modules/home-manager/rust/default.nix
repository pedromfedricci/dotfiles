{pkgs, ...}: {
  home.packages = with pkgs.unstable; [
    cargo-expand
    cargo-flamegraph
    cargo-hack
    cargo-make
    cargo-msrv
    cargo-nextest
    cargo-semver-checks
    cargo-tarpaulin
    cargo-watch
    rustup
    taplo
  ];

  home.sessionPath = [
    "$HOME/.cargo/bin"
  ];

  # programs.zsh.oh-my-zsh.plugins = [
  # "rust"
  # ];
}
