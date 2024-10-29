{ config, pkgs, ... }:

{
  imports = [
    ./hyprland
    ./eww
    ./swaync
    ./rofi
  ];
  home.packages = with pkgs; [
  ];
}
