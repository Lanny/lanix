{ config, pkgs, lib, ... }:
{
  home.username = "lanny";
  home.homeDirectory = "/home/lanny";

  home.packages = [
    pkgs.xsel
    pkgs.xclip
  ];

  home.stateVersion = "22.05";

  home.sessionVariables = {
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    EDITOR = "vim";
  };

  imports = [
    ./vim
    ./kitty.nix
    ./zsh.nix
    ./i3.nix
    ./qutebrowser.nix
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.rofi.enable = true;
  programs.git = {
    enable = true;
    userName = "Lanny";
    userEmail = "lan.rogers.book@gmail.com";
  };
}
