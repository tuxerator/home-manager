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

  services.blueman-applet.enable = true;
}
