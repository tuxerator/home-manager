{ config, pkgs, lib, ... }:

{
  programs.rofi = {
    enable = true;
    plugins = with pkgs; [
      rofi-rbw
    ];
    extraConfig = {
      modi = "run,window,ssh,combi";
    };
  };
}
