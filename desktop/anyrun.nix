{ config, pkgs, flake-inputs, ... }:

{
  programs.anyrun = {
    enable = true;
    config = {
      plugins = with flake-inputs.anyrun.packages.${pkgs.system}; [
        applications
        kidex
        rink
        shell
        randr
        websearch
      ];
      x = { fraction = 0.5; };
      y = { fraction = 0.5; };
      width = { fraction = 0.3; };
    };

    extraCss = ''
      window {
        background: transparent;
      }
    '';

    extraConfigFiles."kidex.ron".text = ''
      Config(
        max_entries: 8,
      )
    '';

    extraConfigFiles."websearch.ron".text = ''
      Config(
        engines: [DuckDuckGo]
      )
    '';
  };

}
