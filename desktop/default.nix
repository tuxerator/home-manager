{ config, pkgs, ... }:

{
  imports = [
    ./hyprland
    ./eww
    ./swaync
    ./rofi
    ./stylix
    ./defaultApps.nix
  ];
  home.packages = with pkgs; [
  ];

  services.blueman-applet.enable = true;
}
