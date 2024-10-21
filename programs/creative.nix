{ pkgs, ... }:
{
  home.packages = with pkgs; [
    audacity
    qtractor
    davinci-resolve
    raysession
    reaper
    helio-workstation
    zrythm
  ];
}
