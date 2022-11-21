{ config, pkgs, ... }:

let
  obsidian = builtins.readFile ./obsidian.vim;
  rc = builtins.readFile ./rc.vim;
in {
  programs.vim = {
    enable = true;
    plugins = [
      pkgs.vimPlugins.vim-sensible
      pkgs.vimPlugins.vim-pencil
      pkgs.vimPlugins.fzf-vim
    ];
    settings = {
      background = "dark";
    };
    extraConfig = ''
      ${obsidian}
      ${rc}
    '';
    packageConfigurable = pkgs.vim_configurable;
  };
}
