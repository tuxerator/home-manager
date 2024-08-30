{ config, pkgs, ... }:

{
  services.flatpak = {
    enable = true;
    update.auto = {
      enable = true;
      onCalendar = "weekly";
    };
    packages = [
      "com.github.tchx84.Flatseal"
      "com.discordapp.Discord"
      "org.libreoffice.LibreOffice"
      "tv.plex.PlexDesktop"
    ];
  };
}
