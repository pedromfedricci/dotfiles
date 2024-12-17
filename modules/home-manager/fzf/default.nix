# Fzf:
# https://github.com/junegunn/fzf
{pkgs, ...}: {
  programs.fzf = {
    enable = true;
    package = pkgs.unstable.fzf;
    defaultCommand = "fd --type f --strip-cwd-prefix --hidden --follow --exclude .git --exclude result --exclude target --exclude build";
    # Color scheme links:
    # https://github.com/helix-editor/helix/blob/master/runtime/themes/nightfox.toml
    # https://github.com/junegunn/fzf/wiki/Color-schemes
    colors = {
      selected-fg = "#cdcecf"; # "ui.text" = { fg = "fg1" }
      selected-bg = "#192330"; # "ui.background" = { bg = "bg1" }
      # selected-hl not working.
      hl = "#71839b"; # "ui.bufferline" = { fg = "fg3" }

      current-fg = "#aeafb0"; # "ui.text.info" = { fg = "fg2" }
      current-bg = "#2b3b51"; # "ui.text.info" = { bg = "sel0" }
      current-hl = "#719cd6"; # "ui.statusline.normal" = { bg = "blue" }

      preview-fg = "#cdcecf"; # same as "selected-fg"
      preview-bg = "#192330"; # same as "selected-bg"

      border = "#2b3b51"; # "ui.text.info" = { bg = "sel0" }
      header = "#cdcecf"; # same as "selected-fg"
      gutter = "#2b3b51"; # same as "border"
      info = "#719cd6"; # same as "prompt"
      label = "#2b3b51"; # same as "border"
      marker = "#29394f"; # "ui.cursorline.primary" = { bg = "bg3" }
      pointer = "#dbc074"; # "ui.linenr.selected" = { fg = "yellow" }
      prompt = "#719cd6"; # "ui.statusline.normal" = { bg = "blue" }
      spinner = "#719cd6"; # same as "prompt"
    };
  };

  programs.zsh = {
    shellAliases = {
      fzfbat = "fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'";
    };
  };
}
