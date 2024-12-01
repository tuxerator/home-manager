{ config, pkgs, ... }:

{
  programs.mangohud = {
    enable = true;
    enableSessionWide = true;
    settings = {
      time = true;
      fps = true;
      frametime = false;
      frame_timing = false;
      gpu_stats = false;
      cpu_stats = false;
      engine_short_names = true;
    };
  };

  home.packages = with pkgs; [
    teamspeak5_client
    steamtinkerlaunch
    winetricks
  ];

  services.flatpak.packages = [
    "com.usebottles.bottles"
  ];
}
