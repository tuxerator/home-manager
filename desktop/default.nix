{ config, pkgs, ... }:

{
  imports = [
    ./hyprland.nix
    ./anyrun.nix
    ./waybar.nix
    ./ironbar.nix
  ];
}
