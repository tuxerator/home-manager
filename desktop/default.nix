{ config, pkgs, ... }:

{
  imports = [
    ./hyprland.nix
    ./anyrun.nix
    ./ironbar.nix
  ];
}
