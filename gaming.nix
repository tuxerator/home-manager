{ config, pkgs, ... }:

{
  programs.mangohud = {
    enable = true;
    enableSessionWide = true;
    settings = {
      time = true;
      fps = true;
      frametime = false;
      background_alpha = 0.0;
      frame_timing = false;
      gpu_stats = false;
      cpu_stats = false;
      engine_short_names = true;
    };
  };

  home.packages = with pkgs; [
    heroic
    teamspeak5_client
  ];

  services.flatpak.packages = [
    "com.usebottles.bottles"
  ];
}
