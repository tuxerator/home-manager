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
  };
}
