{ lib, config, pkgs, ... }:

with lib;
{
  imports = [
    ./ssh.nix
    ./zsh
    ./rbw.nix
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
    ];

    home.default-terminal = "${pkgs.alacritty}/bin/alacritty";

    services.kdeconnect = {
      enable = true;
      indicator = true;
    };

    programs.sftpman = {
      enable = true;
      mounts = {
        "pixel7" = {
          host = "192.168.178.28";
          mountPoint = "/sdcard";
          port = 1739;
          sshKey = "/home/jakob/.config/kdeconnect/privateKey.pem";
          user = "kdeconnect";
        };
      };
    };
  };
}
