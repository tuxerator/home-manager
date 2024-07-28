{ config, pkgs, ... }:

{
  options = { };

  config = {
    programs.wezterm = {
      enable = true;
      enableZshIntegration = true;
      extraConfig = ''
        return require 'color-scheme'
      '';
    };

    home.default-terminal = "${pkgs.wezterm}/bin/wezterm";
    home.file."./.config/wezterm/" = {
      source = ./config;
      recursive = true;
    };
  };
}
