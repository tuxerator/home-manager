{ pkgs, ... }: {
  home.packages = with pkgs; [
    audacity
    vamp-plugin-sdk
    calf
    darktable
    fluidsynth
    davinci-resolve
    ardour
  ];
}
