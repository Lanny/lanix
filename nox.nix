{ config, pkgs, lib, ... }: (import ./home.nix) {
  inherit config pkgs lib;
  withx = false;
}
