{ config, pkgs, ... }:

{
  options = { };

  config = {
    programs.wezterm = {
      enable = true;
      enableZshIntegration = true;
      extraConfig = ''
        return require 'color_scheme'
      '';
    };
  };
}
