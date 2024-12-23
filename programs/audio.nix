{ pkgs, ... }:
{
  home.packages = with pkgs; [
    qwgraph
  ];
}
