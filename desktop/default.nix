{ config, pkgs, ... }:

{
  imports = [
    ./hyprland.nix
    ./eww
    ./swaync
    ./rofi
  ];
  home.packages = with pkgs; [
  ];
}
