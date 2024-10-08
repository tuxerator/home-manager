{ config, pkgs, lib, ... }:

{
  programs.rofi = {
    enable = true;
    plugins = with pkgs; [
    ];
    extraConfig = {
      modi = "run,window,ssh,combi";
    };
  };

  home.packages = with pkgs; [
    rofi-rbw
  ];
}
