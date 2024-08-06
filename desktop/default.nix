{ config, pkgs, ... }:

{
  imports = [
    ./hyprland.nix
    ./eww
    ./albert
    ./swaync
  ];
}
