{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    # inputs.devenv.packages.${pkgs.system}.devenv
    unstable.devenv
  ];
}
