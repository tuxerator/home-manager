{ config, pkgs, lib, ... }:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    plugins = with pkgs; [
    ];
    extraConfig = {
      modi = "run,window,ssh,combi";
    };
  };

  home.packages = with pkgs; [
    rofi-rbw
    wtype
  ];
}
