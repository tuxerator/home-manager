{ lib, config, pkgs, ... }:

with lib;
{
  imports = [
    ./ssh.nix
    ./zsh
    ./rbw.nix
    ./flatpak.nix
    ./obs.nix
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
      "com.discordapp.Discord" = { };
      "io.github.spacingbat3.webcord" = { };
      "dev.vencord.Vesktop" = { };
    };
  };
}
