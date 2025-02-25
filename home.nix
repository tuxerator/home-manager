{ config, pkgs, flake-inputs, ... }:

{
  imports = [ ./desktop ./programs ./programs/neovim ./email.nix ];

  home = {
    username = "jakob";
    homeDirectory = "/home/jakob";
  };

  home.default-terminal = "${pkgs.alacritty}/bin/alacritty";

  xdg = {
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };

  nixpkgs = { config = { allowUnfree = true; }; };

  nix = {
    package = pkgs.nix;
    settings = {
      substituters = [ "https://cache.nixos.org/" ];
      trusted-public-keys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ];
    };
  };

  hyprland.primary_monitor = "DP-2";

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userEmail = "jakob.sanowski@sanbach.de";
    userName = "Jakob Sanowski";
    signing = {
      signByDefault = true;
      key = null;
    };
  };

  home.stateVersion = "24.05";
}
