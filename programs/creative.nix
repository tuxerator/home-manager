{ pkgs, ... }:
{
  home.packages = with pkgs; [
    audacity
    vamp-plugin-sdk
    calf
    darktable
    #    davinci-resolve
  ];
}
