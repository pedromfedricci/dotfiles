{pkgs, ...}: let
  # Small: 16x16, Regular: 24x24, Large: 32x32, Extra: 48x48.
  xCursorSize = 16;
  xCursorTheme = "Bibata-Modern-Classic";
in {
  home.pointerCursor = {
    name = xCursorTheme;
    package = pkgs.bibata-cursors;
    size = xCursorSize;
    x11.enable = true;
    gtk.enable = true;
  };

  home.sessionVariables = {
    # Workaround to fixe alacritty and wezterm (possibly other terms too)
    # failing to show the mouse cursor while moving it after hiding it by
    # typing. Related:
    # https://github.com/alacritty/alacritty/issues/4780
    # https://github.com/wez/wezterm/issues/3106
    XCURSOR_THEME = xCursorTheme;
    XCURSOR_SIZE = xCursorSize;
  };
}
