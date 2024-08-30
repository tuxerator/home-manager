{ config, pkgs, ... }:

{
  imports = [
    ./hyprland.nix
    ./eww
    ./albert
    ./swaync
  ];
  services.caffeine.enable = true;
}
