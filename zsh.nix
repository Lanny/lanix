{ config, pkgs, ... }:

{
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
      bindkey -v
      autoload -z edit-command-line
      zle -N edit-command-line
      bindkey "^E" edit-command-line

      function zle-line-init zle-keymap-select {
          VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]%  %{$reset_color%}"
          RPS1="${"$"}{${"$"}{KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
          zle reset-prompt
      }

      zle -N zle-line-init
      zle -N zle-keymap-select
    '';
  };
}
