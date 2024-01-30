{ config, pkgs, ... }:

{
  services.flatpak.packages = [
    "flathub:app/io.github.spacingbat3.webcord//stable"
    "flathub:app/dev.vencord.Vesktop//stable"
  ];
}
