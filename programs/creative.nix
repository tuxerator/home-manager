{ pkgs, ... }: {
  home.packages = with pkgs; [
    audacity
    vamp-plugin-sdk
    calf
    darktable
    fluidsynth
    qsynth
    davinci-resolve
    ardour
  ];
}
