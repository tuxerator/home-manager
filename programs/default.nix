{ lib, config, pkgs, ... }:

with lib;
{
  imports = [
    ./ssh.nix
    ./zsh
    ./rbw.nix
    ./flatpak.nix
  ];

  options = {
    home.default-terminal = mkOption {
      type = types.str;
    };
  };

  config = {

    home.packages = with pkgs; [
      helvum
      sshfs
      alacritty
      piper
      davinci-resolve
      signal-cli
      chromium
      lazygit
    ];

    home.default-terminal = "${pkgs.alacritty}/bin/alacritty";

    xdg.portal.xdgOpenUsePortal = true;

    services.kdeconnect = {
      enable = true;
      indicator = true;
    };

    services.udiskie = {
      enable = true;
      automount = false;
    };
  };
}
