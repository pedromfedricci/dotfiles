{pkgs, ...}: {
  home.packages = with pkgs; [
    adwaita-icon-theme
    gnome-themes-extra
    gnome-tweaks
    gnome-power-manager
  ];

  # NOTE: The warning: "error: The ‘gnome.gnome-shell-extensions’ was moved to
  # top-level. Please use ‘pkgs.gnome-shell-extensions’ directly." was fixed
  # at master:
  # https://github.com/nix-community/home-manager/commit/e526fd2b1a40e4ca0b5e07e87b8c960281c67412
  # Yet to be merged to 24.11:
  # https://github.com/nix-community/home-manager/tree/release-24.11
  programs.gnome-shell = {
    enable = true;
    extensions = with pkgs; [
      {package = gnomeExtensions.blur-my-shell;}
      {package = gnomeExtensions.dash-to-dock;}
      {package = gnomeExtensions.hibernate-status-button;}
      {package = gnomeExtensions.paperwm;}
      # Links:
      # https://gitlab.com/marcosdalvarez/thinkpad-battery-threshold-extension
      # https://gitlab.com/marcosdalvarez/thinkpad-battery-threshold-extension/-/issues/27
      # {package = gnomeExtensions.thinkpad-battery-threshold;}
    ];
    theme = {
      name = "Flat-Remix-Dark";
      package = pkgs.unstable.flat-remix-gnome;
    };
  };
}
