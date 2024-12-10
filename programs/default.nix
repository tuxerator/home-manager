{ lib, config, pkgs, ... }:

with lib;
{
  imports = [
    ./ssh.nix
    ./zsh
    ./rbw.nix
    ./flatpak.nix
    ./obs.nix
    ./alacritty.nix
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
      piper
      signal-cli
      chromium
      lazygit
      direnv
      libreoffice
      whisper
      firefox
      papers
      networkmanagerapplet
      hotspot
      perf-tools
      jq
    ];

    home.default-terminal = "${pkgs.alacritty}/bin/alacritty";


    xdg.portal.xdgOpenUsePortal = true;

    services.kdeconnect = {
      enable = true;
      indicator = true;
    };

    services.network-manager-applet.enable = true;

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
      "com.rtosta.zapzap" = {
        autostart.enable = true;
      };
    };
  };
}
