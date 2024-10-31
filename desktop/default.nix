{ config, pkgs, ... }:

{
  imports = [
    ./hyprland
    ./eww
    ./swaync
    ./rofi
    ./stylix.nix
  ];
  home.packages = with pkgs; [
  ];

  services.blueman-applet.enable = true;
}
