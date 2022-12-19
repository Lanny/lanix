{ config, pkgs, ... }:
let
  rc = builtins.readFile ./zshrc-extra.sh;
in {
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    defaultKeymap = "viins";

    oh-my-zsh = {
      enable = true;
      theme = "mh";

      extraConfig = ''
        COMPLETION_WAITING_DOTS="true"
        DISABLE_UNTRACKED_FILES_DIRTY="true"
      '';
    };

    shellAliases = {
      gpnv = "git push --set-upstream origin $(git branch --show-current) --no-verify";
      gcnv = "git commit --no-verify";
      vi   = "vim";
    };

    initExtra = ''
      ${rc}
    '';
  };
}
