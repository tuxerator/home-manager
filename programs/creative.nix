{ pkgs, ... }:
{
  home.packages = with pkgs; [
    audacity
    vamp-plugin-sdk
    #    davinci-resolve
  ];
}
