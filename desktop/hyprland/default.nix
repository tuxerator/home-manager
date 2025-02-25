{ config, pkgs, lib, flake-inputs, ... }:

let cfg = config.hyprland;

in with lib;

{
  imports = [ ./swayidle.nix ./hyprlock.nix ];

  options = {
    home.default-terminal = mkOption { type = types.str; };
    hyprland = {
      monitors = mkOption {
        default = [ ",preferred,auto,1" ];
        type = types.listOf types.str;
        description = "Hyprland monitor configs";
      };
      primary_monitor = mkOption {
        default = null;
        type = types.str;
        description = "Default primary monitor for XWayland.";
      };
      workspace_rules = mkOption {
        default = [ ];
        type = types.listOf types.str;
        description = "Hyprland workspace rules";
      };
      touchpad = mkOption {
        type = types.submodule {
          options = {
            natural_scroll = mkOption {
              type = types.bool;
              default = true;
            };
          };
        };
        default = { };
      };
      gestures = mkOption {
        type = types.submodule {
          options = {
            workspace_swipe = mkOption {
              type = types.bool;
              default = true;
            };
            workspace_swipe_fingers = mkOption {
              type = types.ints.unsigned;
              default = 3;
            };
            workspace_swipe_distance = mkOption {
              type = types.ints.unsigned;
              default = 300;
            };
            workspace_swipe_cancel_ratio = mkOption {
              type = types.numbers.between 0.0 1.0;
              default = 0.7;
            };
          };
        };
        default = { };
      };

      keybinds = mkOption {
        type = types.listOf types.str;
        description = "Hyprland keybinds";
        default = [ ];
      };

    };
  };

  config = {
    home.packages = with pkgs; [
      alacritty
      grim
      wl-mirror
      slurp
    ];
    nix.settings = {
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };

    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        "$mod" = "SUPER";

        monitor = cfg.monitors;
        workspace = cfg.workspace_rules;
        gestures = cfg.gestures;
        input.touchpad = cfg.touchpad;

        exec-once = [
          "eww daemon"
          "eww open bar --screen 0"
          (lib.mkIf (cfg.primary_monitor != null) "xrandr --output ${cfg.primary_monitor} --primary")
        ];

        general = {
          gaps_in = 2;
          gaps_out = 0;
          border_size = 2;
          no_border_on_floating = true;
          resize_on_border = true;
        };

        decoration = {
          rounding = 8;
          blur = {
            size = 5;
            passes = 2;
            special = true;
          };
        };

        animations = {
          animation = [
            "workspaces,1,3,default"
            "windows,1,5,default"
            "border,1,10,default"
            "fade,1,8,default"
          ];
        };

        input = {
          kb_layout = "us";
          kb_variant = "altgr-intl";
          accel_profile = "flat";
        };

        # cursor = { no_hardware_cursors = true; };

        windowrulev2 = [
          "idleinhibit focus, class:(steam_proton)"
          "idleinhibit focus, class:(steam_app)(.*)"
          "fullscreen, class:(steam_app)(.*)"
          "monitor 1, class:(steam_app)(.*)"
          "workspace special:steam silent, class:^(steam)$"
          "workspace 1 silent, class:(vesktop)"
        ];

        bind = [
          "$mod, F, fullscreen"
          "$mod, T, togglefloating"
          "$mod, P, pin"
          "$mod, RETURN, exec, ${config.home.default-terminal}"
          "$mod, Q, killactive"
          "$mod SHIFT, Delete, exit"
          "$mod, SPACE, exec, rofi -show drun"
          "SUPERCTRL,left,resizeactive,-20 0"
          "SUPERCTRL,right,resizeactive,20 0"
          "SUPERCTRL,up,resizeactive,0 -20"
          "SUPERCTRL,down,resizeactive,0 20"
          "$mod, J, movefocus, d"
          "$mod, K, movefocus, u"
          "$mod, L, movefocus, r"
          "$mod, H, movefocus, l"
          "$mod, down, movefocus, d"
          "$mod, up, movefocus, u"
          "$mod, right, movefocus, r"
          "$mod, left, movefocus, l"
          "$mod ALT, M, exec, wl-present mirror"
          "$mod ALT, O, exec, wl-present set-output"
          "$mod ALT, P, exec, wl-present set-region"
          "$mod SHIFT, J, movewindow, d"
          "$mod SHIFT, L, movewindow, r"
          "$mod SHIFT, H, movewindow, l"
          "$mod SHIFT, down, movewindow, d"
          "$mod SHIFT, up, movewindow, u"
          "$mod SHIFT, right, movewindow, r"
          "$mod SHIFT, left, movewindow, l"
          "$mod, g, togglegroup"
          "$mod CTRL, L, exec, loginctl lock-session"
          "$mod CTRL, S, togglespecialworkspace, steam"
          "$mod CTRLALT, S, movetoworkspace, special:steam"
        ] ++ (builtins.concatLists (builtins.genList (x:
          let
            ws = let c = (x + 1) / 10; in builtins.toString (x + 1 - (c * 10));
          in [
            "$mod, ${ws}, workspace, ${toString (x + 1)}"
            "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
            "$mod CTRL, ${ws}, togglespecialworkspace, ${toString (x + 1)}"
            "$mod CTRLALT, ${ws}, movetoworkspace, special:${toString (x + 1)}"
          ]) 10)) ++ cfg.keybinds;

        bindm = [ "$mod, mouse:272, movewindow" ];

        # bindl = [
        #   ", switch:on:Lid Switch, exec, ${
        #     pkgs.writeShellScript "on-lid-close" ''
        #       eww close bar
        #       hyprctl keyword monitor "eDP-1, disable"
        #       sleep 0.5
        #       eww open bar''
        #   }"
        #   ", switch:off:Lid Switch, exec, ${
        #     pkgs.writeShellScript "on-lid-close" ''
        #       eww close bar
        #       hyprctl keyword monitor "eDP-1, preferred, 0x0, 1"
        #       sleep 0.5
        #       eww open bar''
        #   }"
        # ];
        debug = { disable_logs = false; };
      };
    };

  };
}
