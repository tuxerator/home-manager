{ config, lib, ... }:
let
  cfg = config.hyprlock;
in

with lib;
{
  options = {
    hyprlock = {
      background = mkoption {
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
      };
    };
  };
}
