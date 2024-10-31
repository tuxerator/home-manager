{ config, pkgs, ... }:

{
  imports = [
    ./hyprland
    ./eww
    ./swaync
    ./rofi
    ./stylix
  ];
  home.packages = with pkgs; [
  ];

  services.blueman-applet.enable = true;
}
