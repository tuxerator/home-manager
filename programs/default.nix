{ lib, config, pkgs, ... }:

with lib;
{
  imports = [
    ./ssh.nix
    ./zsh
    ./rbw.nix
    ./flatpak.nix
    ./obs.nix
    ./creative.nix
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
      signal-cli
      chromium
      lazygit
      direnv
      libreoffice
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

    flatpak.packages = {
      "org.signal.Signal" = {
        autostart = {
          enable = true;
          args = [
            "--use-tray-icon"
            "--start-in-tray"
          ];
        };
      };
      "dev.vencord.Vesktop" = { };
    };
  };
}
