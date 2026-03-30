{pkgs, ...}: {
  home.packages = with pkgs.unstable; [
    pkgs.clang # linker

    # bpf-linker
    # cargo-dylint
    # cargo-expand
    # cargo-flamegraph
    # cargo-generate
    cargo-hack
    cargo-make
    cargo-msrv
    cargo-nextest
    cargo-semver-checks
    cargo-tarpaulin
    cargo-watch
    rustup
  ];

  home.sessionPath = [
    "$HOME/.cargo/bin"
  ];
}
