{
  pkgs,
  # inputs,
  ...
}: {
  home.packages = with pkgs; [
    # inputs.devenv.packages.${pkgs.stdenv.hostPlatform.system}.devenv
    unstable.devenv
  ];
}
