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
}
