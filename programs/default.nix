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
      chromium
      lazygit
      direnv
      libreoffice
      whisper
      firefox
      papers
      hotspot
      perf-tools
      jq
    ];

    home.default-terminal = "${pkgs.alacritty}/bin/alacritty";


    xdg.portal.xdgOpenUsePortal = true;

    services.network-manager-applet.enable = true;

    services.udiskie = {
      enable = true;
      automount = false;
    };

    flatpak.packages = {
      "de.schmidhuberj.Flare" = {
        autostart = {
          enable = false;
          args = [
            "--use-tray-icon"
            "--start-in-tray"
          ];
        };
      };
      "dev.vencord.Vesktop" = { };
      "com.rtosta.zapzap" = {
        autostart.enable = false;
      };
    };

    hyprland.keybinds = [
      "$mod CTRL, m, togglespecialworkspace, messenger"
    ];
  };
}
