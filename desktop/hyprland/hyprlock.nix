{ config, lib, ... }:
let
  cfg = config.hyprlock;
in

with lib;
{
  options = {
    hyprlock = {
      background = mkOption {
        type = types.str;
        default = "";
      };
    };
  };
  config = {
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
            path = cfg.background;
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
  };
}
