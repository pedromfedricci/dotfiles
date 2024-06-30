{pkgs, ...}: {
  home.packages = with pkgs; [
    gnome.adwaita-icon-theme
    gnome.gnome-themes-extra
    gnome.gnome-tweaks
    gnome.gnome-shell-extensions
    pop-launcher
  ];

  programs.gnome-shell = {
    enable = true;
    extensions = with pkgs; [
      {package = gnomeExtensions.blur-my-shell;}
      {package = gnomeExtensions.dash-to-dock;}
      {package = gnomeExtensions.pop-shell;}
      {package = gnomeExtensions.toggle-alacritty;}
      # {package = gnomeExtensions.rounded-window-corners;}
      # {package = gnomeExtensions.user-themes;}
    ];
    theme = {
      name = "Flat-Remix-Blue-Dark";
      package = pkgs.flat-remix-gnome;
    };
  };
}
