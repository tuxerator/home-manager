{ config, pkgs, flake-inputs, ... }:

{
  imports = [
    ./desktop
    ./programs
    ./langs
    ./programs/flatpak.nix
    ./programs/neovim
    ./gaming.nix
  ];

  home.username = "jakob";
  home.homeDirectory = "/home/jakob";

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  hyprland.monitors = [
    "desc:Ancor Communications Inc ASUS PB277 0x00008283, 2560x1440@74.92, 0x0, 1"
    "desc:ASUSTek COMPUTER INC VG259 L8LMQS009978, 1920x1080@143.61, auto-right, 1,vrr,1"
    "Unknown-1,disable"
  ];

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

  services.kidex.enable = true;

  home.stateVersion = "24.05";
}
