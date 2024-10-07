{ config, pkgs, ... }:

{
  imports = [
    ./hyprland.nix
    ./eww
    ./albert
    ./swaync
    ./rofi
  ];
  services.caffeine.enable = true;
  home.packages = with pkgs; [
    vesktop
  ];
}
