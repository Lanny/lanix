{ config, pkgs, lib, withx ? true, ... }:
{
  home.username = "lanny";
  home.homeDirectory = "/home/lanny";

  home.packages = if withx then [
    pkgs.xsel
    pkgs.xclip
  ] else [];

  home.stateVersion = "22.05";

  home.sessionVariables = {
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    EDITOR = "vim";
  };

  imports = [
    ./vim
    ./zsh.nix
  ] ++ (if withx then [
    ./kitty.nix
    ./i3.nix
    ./qutebrowser.nix
  ] else []);

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.rofi.enable = true;
  programs.git = {
    enable = true;
    userName = "Lanny";
    userEmail = "lan.rogers.book@gmail.com";
  };
}
