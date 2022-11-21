{ config, lib, pkgs, ... }:
let
  mod = "Mod4";
  toggleMouse = pkgs.writeShellScriptBin "toggle-mouse" ''
    DEVICE=13
    ENABLED=$(xinput list-props $DEVICE | awk '/^\tDevice Enabled \([0-9]+\):\t[01]/ {print $NF}')

    case $ENABLED in
      0)
        xinput enable "$DEVICE"
        echo "$DEVICE enabled"
        ;;
      1)
        xinput disable "$DEVICE"
        echo "$DEVICE disabled"
        ;;
      *)
        echo
        xinput list --name-only
        ;;
    esac
  '';
  wifistatus = import ./wifistatus;
  appLauncher = pkgs.writeShellScriptBin "app-launcher" ''
    declare -A commands
    commands=(
      [qutebrowser]="QT_SCALE_FACTOR=1 QT_AUTO_SCREEN_SCALE_FACTOR=1 qutebrowser"
      [toggle-mouse]="${toggleMouse}/bin/toggle-mouse"
    )

    cmdlist=""
    for cmdName in "${"$"}{!commands[@]}"
    do
      cmdlist="$cmdlist$cmdName\n"
    done

    cmd=$(echo -e "$cmdlist" | ${pkgs.rofi}/bin/rofi -dmenu)
    eval ${"$"}{commands[$cmd]}
  '';
in {
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;

    config = {
      modifier = "${mod}";

      keybindings = lib.mkOptionDefault {
        "${mod}+d" = "exec ${appLauncher}/bin/app-launcher";
        "${mod}+p" = "exec ${appLauncher}/bin/app-launcher";

        # Focus
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";
        "${mod}+l" = "focus right";
        "${mod}+h" = "focus left";

        # Move
        "${mod}+Shift+j" = "move down";
        "${mod}+Shift+k" = "move up";
        "${mod}+Shift+l" = "move right";
        "${mod}+Shift+h" = "move left";

        "${mod}+Return" = "exec kitty";

        "${mod}+z" = "mode command";
      };

      modes = {
        command = {
          "Escape" = "mode default";

          "j" = "focus down";
          "k" = "focus up";
          "l" = "focus right";
          "h" = "focus left";
        };
      };

      bars = [
        {
          position = "top";
          statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-top.toml";
        }
      ];
    };

    extraConfig = ''
      default_border pixel 1
      hide_edge_borders both
      gaps inner 3
      client.focused #008E54 #008E54 #008E54 #008E54 #008E54
      client.unfocused #003E54 #003E54 #003E54 #003E54 #003E54
      client.focused_inactive #003E54 #003E54 #003E54 #003E54 #003E54
    '';
  };

  programs.i3status-rust = {
    enable = true;
    bars = {
      top = {
        blocks = [
         {
           block = "custom";
           command = "${wifistatus}";
           interval = 60;

         }
         {
           block = "battery";
           interval = 60;
         }
         {
           block = "time";
           interval = 60;
           format = "%a %d/%m %k:%M %p";
         }
       ];
      };
    };
  };
}
