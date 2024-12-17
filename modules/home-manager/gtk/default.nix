# GTK configuration.
# https://wiki.archlinux.org/title/GTK#Configuration
# https://wiki.archlinux.org/title/Cursor_themes#KDE%20(Wayland)
#
# Night Fox GTK Theme
# https://github.com/Fausto-Korpsvart/Nightfox-GTK-Theme
{pkgs, ...}: let
  extraConfig = {
    gtk-application-prefer-dark-theme = 1;
    gtk-xft-antialias = 1;
    gtk-xft-hinting = 1;
    gtk-xft-hintstyle = "hintslight";
    gtk-xft-rgba = "rgb";
    gtk-button-images = 0;
    gtk-menu-images = 0;
    gtk-enable-event-sounds = 0;
    gtk-enable-input-feedback-sounds = 0;
  };
in {
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-gtk
  ];

  gtk = {
    enable = true;
    font = {
      name = "Cantarell";
      package = pkgs.cantarell-fonts;
      size = 12;
    };
    iconTheme = {
      name = "Flat-Remix-Blue-Dark";
      package = pkgs.flat-remix-icon-theme;
    };
    # theme = {
    # name = "Flat-Remix-GTK-Blue-Dark";
    # # Stable package doesn't work well, on unstable it is ok.
    # package = pkgs.unstable.flat-remix-gtk;
    # };
    # theme = {
    #   # B: border, BL: borderless, LB: legacy, MB: macos
    #   name = "Nightfox-Dark";
    #   package = pkgs.unstable.nightfox-gtk-theme;
    # };
    gtk3.extraConfig = extraConfig;
    gtk4.extraConfig = extraConfig;
  };
}
