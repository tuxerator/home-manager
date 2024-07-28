{ config, pkgs, ... }:

{
  options = { };

  config = {
    programs.wezterm = {
      enable = true;
      enableZshIntegration = true;
      extraConfig = ''
        local color_scheme = require 'color-scheme'
        local config = wezterm.config_builder()
        color_scheme.apply_to_config(config)
        return config
      '';
    };

    home.default-terminal = "${pkgs.wezterm}/bin/wezterm";
    home.file."./.config/wezterm/" = {
      source = ./config;
      recursive = true;
    };
  };
}
