# Fzf:
# https://github.com/junegunn/fzf
# Color scheme links:
# https://github.com/junegunn/fzf/wiki/Color-schemes
# feat: add input, preview, list, and header border colors #18
# https://github.com/catppuccin/fzf/pull/18
# feat: use teal for the search highlights #17
# https://github.com/catppuccin/fzf/pull/17
{pkgs, ...}: {
  programs.fzf = {
    enable = true;
    package = pkgs.unstable.fzf;
    defaultCommand = "fd --type f --strip-cwd-prefix --hidden --follow --exclude .git --exclude result --exclude target --exclude build";

    # Catppucin Mocha:
    # https://github.com/catppuccin/fzf
    colors = {
      bg = "#1e1e2e";
      selected-bg = "#45475a";
      current-bg = "#313244"; # "bg+"
      # preview-bg = "#1e1e2e"; # same as "bg"

      fg = "#cdd6f4";
      current-fg = "#cdd6f4"; # "fg+"
      # preview-fg = "#cdd6f4"; # same as "fg"

      hl = "#179299"; # original "blue", now "teal"
      current-hl = "#179299"; # "hl+", original "blue", now "teal"

      spinner = "#f5e0dc";
      header = "#f38ba8";
      info = "#cba6f7";
      pointer = "#f5e0dc";
      marker = "#b4befe";
      prompt = "#cba6f7";

      # Not included upstream.
      list-border = "#a6e3a1";
      list-label = "#a6e3a1";
      #
      preview-border = "#f38ba8";
      preview-label = "#f38ba8";
      #
      input-border = "#cba6f7";
      input-label = "#cba6f7";
      #
      header-border = "#89b4fa";
      header-label = "#89b4fa";
      #
      # gutter = ""; # gutter line on the left
      # label = ""; # border, input, list and preview labels
      # border = ""; # border around the window
    };

    # Nightfox:
    # https://github.com/helix-editor/helix/blob/master/runtime/themes/nightfox.toml
    # colors = {
    #   selected-fg = "#cdcecf"; # "ui.text" = { fg = "fg1" }
    #   selected-bg = "#192330"; # "ui.background" = { bg = "bg1" }
    #   # selected-hl not working.
    #   hl = "#71839b"; # "ui.bufferline" = { fg = "fg3" }

    #   current-fg = "#aeafb0"; # "ui.text.info" = { fg = "fg2" }
    #   current-bg = "#2b3b51"; # "ui.text.info" = { bg = "sel0" }
    #   current-hl = "#719cd6"; # "ui.statusline.normal" = { bg = "blue" }

    #   preview-fg = "#cdcecf"; # same as "selected-fg"
    #   preview-bg = "#192330"; # same as "selected-bg"

    #   border = "#2b3b51"; # "ui.text.info" = { bg = "sel0" }
    #   header = "#cdcecf"; # same as "selected-fg"
    #   gutter = "#2b3b51"; # same as "border"
    #   info = "#719cd6"; # same as "prompt"
    #   label = "#2b3b51"; # same as "border"
    #   marker = "#29394f"; # "ui.cursorline.primary" = { bg = "bg3" }
    #   pointer = "#dbc074"; # "ui.linenr.selected" = { fg = "yellow" }
    #   prompt = "#719cd6"; # "ui.statusline.normal" = { bg = "blue" }
    #   spinner = "#719cd6"; # same as "prompt"
    # };
  };

  home.shellAliases = {
    fzfbat = "fzf --multi --preview 'bat --color=always --style=numbers --line-range=:500 {}'";
  };
}
