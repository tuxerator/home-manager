{ config, pkgs, lib, ... }:

let
  cfg = config.hyprland;
in

with lib;

{
  options = {
    hyprland.monitors = mkOption {
      default = [ ",preferred,auto,1" ];
      type = types.listOf types.str;
      description = "Hyprland monitor configs";
    };
  };

  config = {
    home.packages = with pkgs; [
      firefox
      alacritty
      grim
    ];

    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        "$mod" = "SUPER";

        monitor = cfg.monitors;

        exec-once = [
          "eww daemon"
          "eww open bar --screen 0"
        ];

        general = {
          gaps_in = 2;
          gaps_out = 0;
          border_size = 2;
          no_border_on_floating = true;
          "col.active_border" = "rgba(56b6c2ff)";
          "col.inactive_border" = "rgba(343a40ff)";
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

        windowrulev2 = [
          "idleinhibit focus, class:(steam_proton)"
          "fullscreen, class:(steam_proton)"
          "monitor 1, class:(steam_proton)"
          "idleinhibit focus, class:(steam_app)(.*)"
          "fullscreen, class:(steam_app)(.*)"
          "monitor 1, class:(steam_app)(.*)"
          "workspace special:steam silent, class:(steam)"
          "workspace 1 silent, class:(vesktop)"
        ];

        bind = [
          "$mod, F, fullscreen"
          "$mod, T, togglefloating"
          "$mod, P, pin"
          "$mod, RETURN, exec, ${config.home.default-terminal}"
          "$mod, Q, killactive"
          "$mod, M, exit"
          "$mod, SPACE, exec, albert toggle"
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
          "$mod SHIFT, J, movewindow, d"
          "$mod SHIFT, L, movewindow, r"
          "$mod SHIFT, H, movewindow, l"
          "$mod SHIFT, down, movewindow, d"
          "$mod SHIFT, up, movewindow, u"
          "$mod SHIFT, right, movewindow, r"
          "$mod SHIFT, left, movewindow, l"
          "$mod, g, togglegroup"
          "$mod CTRL, L, exec, loginctl lock-session"
          "$mod CTRL, S, togglespecialworkspace steam"
        ]
        ++ (
          builtins.concatLists (
            builtins.genList
              (
                x:
                let
                  ws =
                    let
                      c = (x + 1) / 10;
                    in
                    builtins.toString (x + 1 - (c * 10));
                in
                [
                  "$mod, ${ws}, workspace, ${toString (x + 1)}"
                  "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
                  "$mod CTRL, ${ws}, togglespecialworkspace, ${toString (x + 1)}"
                  "$mod CTRLALT, ${ws}, movetoworkspace, special:${toString (x + 1)}"
                ]
              ) 10)
        );

        bindm = [
          "$mod, mouse:272, movewindow"
        ];

        debug = {
          disable_logs = false;
        };
      };
    };
    programs.hyprlock = {
      enable = true;
      settings = {
        general = {
          disable_loading_bar = true;
          grace = 00;
          hide_cursor = true;
          no_fade_in = false;
        };

        background = [
          {
            blur_passes = 3;
            blur_size = 8;
            contrast = 0.8916;
            brightness = 0.8172;
          }
        ];

        label = [{
          monitor = "";
          text = "$TIME";
          color = "rgba(200,200,200,1.0)";
          font_size = 50;
          font_family = "Noto Sans";
          position = "0, 80";
          halign = "center";
          valign = "center";
          shadow_passes = 2;
          shadow_size = 2;
        }];

        input-field = [
          {
            size = "200, 50";
            position = "0, -80";
            monitor = "";
            dots_center = true;
            fade_on_empty = false;
            font_color = "rgb(202, 211, 245)";
            inner_color = "rgb(91, 96, 120)";
            outer_color = "rgb(24, 25, 38)";
            outline_thickness = 5;
            placeholder_text = "$PROMPT";
            check_color = "rgb(204,136,34)";
            fail_color = "rgb(204,136,34)";
            fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
            fail_timeout = 2000;
            fail_transition = 300;
            shadow_passes = 2;
          }
        ];
      };
    };

    services.hypridle = {
      enable = true;
      settings = {
        general = {
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyprctl dispatch dpms on";
          ignore_dbus_inhibit = false;
          lock_cmd = "pidof hyprlock || hyprlock";
        };

        listener = [
          {
            timeout = 600;
            on-timeout = "loginctl lock-session";
          }
          {
            timeout = 700;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
        ];
      };
    };
  };
}
