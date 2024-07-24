{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    helvum
  ];

  services.kdeconnect.enable = true;
}
