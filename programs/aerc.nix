{ config, ... }: {
  programs.aerc = {
    enable = true;
    extraConfig = {
      general.unsafe-accounts-conf = true;
      ui = {
        threading-enabled = true;
      };
      viewer = {
        pager = "nvim -M";
      };
      compose = {
        editor = "nvim";
      };
      filters = {
        "text/plain" = "cat /dev/stdin";
        "text/html" = "${config.programs.aerc.package}/libexec/aerc/filters/html | ${config.programs.aerc.package}/libexec/aerc/filters/colorize";
      };
    };
  };
}
