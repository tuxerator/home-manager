{ config, pkgs, ... }:
{
  programs.obs-studio.enable = true;
  programs.obs-studio.plugins = [
    pkgs.obs-studio-plugins.droidcam-obs
    pkgs.obs-studio-plugins.advanced-scene-switcher
  ];

  hyprland.keybinds = [
    "$mod ALT_L, N, pass, ^(com\.obsproject\.Studio)$"
    "$mod ALT_L, B, pass, ^(com\.obsproject\.Studio)$"
    "$mod CTRL, B, pass, ^(com\.obsproject\.Studio)$"
  ];
}
