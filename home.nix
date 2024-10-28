{ config, pkgs, flake-inputs, ... }:

{
  imports = [
    ./desktop
    ./programs
    ./langs
    ./programs/neovim
    ./gaming.nix
    ./email.nix
  ];

  home.username = "jakob";
  home.homeDirectory = "/home/jakob";

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

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
