{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    settings = {
      font_family = "Inconsolata";
      font_size = "16.0";
      shell = "zsh";
      background = "#003E54";
      foreground = "#dddddd";
      window_margin_width = "4.0";
      window_padding_width = "6.0";
      cursor = "#AA0000";
      cursor_shape = "block";
    };
    keybindings = {
      "f1" = "launch --stdin-source=@screen_scrollback --type=overlay vim -R \"+ normal G\" -";
      "ctrl+n" = "new_os_window_with_cwd";
      "ctrl+shift+r" = "load_config_file";

    };
  };
}
