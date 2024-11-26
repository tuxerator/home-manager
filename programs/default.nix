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
      libsecret
      flare-signal
      plex-media-player
      pwvucontrol
    ];

    home.default-terminal = "${pkgs.alacritty}/bin/alacritty";


    xdg.portal.xdgOpenUsePortal = true;

    services.network-manager-applet.enable = true;

    services.udiskie = {
      enable = true;
      automount = false;
    };

    flatpak.packages = {
      "org.signal.Signal" = {
        autostart = {
          enable = true;
          args = [ "--use-tray-icon" "--enable-features=UseOzonePlatform" "--ozone-platform=wayland" "--enable-features=WaylandWindowDecorations" ];
        };
      };
      "dev.vencord.Vesktop" = { };
      "com.rtosta.zapzap" = {
        autostart.enable = true;
      };
    };

    hyprland.keybinds = [
      "$mod CTRL, m, togglespecialworkspace, messenger"
    ];
  };
}
