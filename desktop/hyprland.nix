{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    firefox
    alacritty
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";

      monitor = [
        "DP-3,1920x1080@144,0x0,1,vrr,1"
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

      bind = [
        "$mod, F, exec, firefox"
	"$mod, RETURN, exec, alacritty"
	"$mod, Q, killactive"
	"$mod, M, exit"
	"$mod, D, exec, anyrun"
	"SUPERCTRL,left,resizeactive,-20 0"
	"SUPERCTRL,right,resizeactive,20 0"
	"SUPERCTRL,up,resizeactive,0 -20"
	"SUPERCTRL,down,resizeactive,0 20"
      ]
      ++ (
      builtins.concatLists (
        builtins.genList (
          x: let
	    ws = let
	      c = (x + 1) / 10;
	    in
	      builtins.toString (x + 1 - (c * 10));
          in [
	    "$mod, ${ws}, workspace, ${toString (x + 1)}"
	    "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
	    "$mod CTRL, ${ws}, togglespecialworkspace, ${toString (x + 1)}"
	    "$mod SHIFTALT, ${ws}, movetoworkspace, special:${toString (x + 1)}"
	  ]
	) 10) 
      );

      debug = {
        disable_logs = false;
      };
    };
  };
}
