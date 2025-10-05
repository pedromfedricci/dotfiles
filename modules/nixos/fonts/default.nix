# Links:
#
# Microsoft fonts:
# https://www.reddit.com/r/NixOS/comments/15wvv2y/microsoft_fonts/
{pkgs, ...}: {
  fonts.enableDefaultPackages = true;
  fonts.packages = with pkgs; [
    corefonts
    # dina-font
    # emojione
    # fira-mono
    # font-awesome
    # ipafont
    # jetbrains-mono
    # kanji-stroke-order-font
    # liberation_ttf
    # nerd-fonts.fira-code
    # nerd-fonts.fira-mono
    # noto-fonts
    # noto-fonts-cjk-sans
    # noto-fonts-emoji
    # powerline-fonts
    # proggyfonts
    # source-code-pro
    # ubuntu_font_family
  ];

  fonts.fontconfig = {
    # hinting.autohint = false;
    # ultimate.enable = false;
    # penultimate.enable = false;
    # useEmbeddedBitmaps = true;
    # antialias = true;

    # defaultFonts = {
    #   monospace = [
    #     "FiraCode Nerd Font"
    #     "DejaVu Sans Mono"
    #     "Noto Mono"
    #   ];
    #   sansSerif = [
    #     "Fira Sans"
    #     "Ubuntu"
    #     "DejaVu Sans"
    #     "Noto Sans"
    #   ];
    #   serif = [
    #     "Roboto Slab"
    #     "PT Serif"
    #     "Liberation Serif"
    #     "Noto Serif"
    #   ];
    # };
  };
}
