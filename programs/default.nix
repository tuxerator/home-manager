{ config, pkgs, ... }:

{
  imports = [
    ./ssh.nix
  ];
  home.packages = with pkgs; [
    helvum
  ];

  services.kdeconnect = {
    enable = true;
    indicator = true;
  };
}
