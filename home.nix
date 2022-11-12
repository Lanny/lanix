{ config, pkgs, lib, ... }:

let
  appLauncher = import ./app-launcher.nix;
in {
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "lanny";
  home.homeDirectory = "/home/lanny";

  home.packages = [
    pkgs.xsel
    pkgs.xclip
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  home.sessionVariables = {
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    EDITOR = "vim";
  };

  imports = [
    ./vim.nix
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
