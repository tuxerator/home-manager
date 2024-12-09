{ config, pkgs, ... }: {
  programs.aerc = {
    enable = true;
    extraConfig = {
      general.unsafe-accounts-conf = true;
      ui = {
        threading-enabled = true;
      };
      viewer = {
        pager = "less -Rc";
      };
      compose = {
        editor = "nvim";
      };
      filters = {
        "text/plain" = "${config.programs.aerc.package}/libexec/aerc/filters/colorize";
        "text/html" = "${config.programs.aerc.package}/libexec/aerc/filters/html | ${config.programs.aerc.package}/libexec/aerc/filters/colorize";
        "text/*" = "bat -fP --file-name=\"$AERC_FILENAME\" --style=plain";
        ".headers" = "${config.programs.aerc.package}/libexec/aerc/filters/colorize";
      };
    };
  };
  home.packages = with pkgs; [
    pandoc
    bat
  ];
}
