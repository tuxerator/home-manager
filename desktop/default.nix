{ config, pkgs, ... }:

{
  imports = [
    ./hyprland.nix
    ./anyrun.nix
    ./eww
    ./albert.nix
    ./swaync
  ];
}
