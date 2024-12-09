{ config, pkgs, ... }: {
  programs.aerc = {
    enable = true;
    extraConfig = {
      general.unsafe-accounts-conf = true;
      ui = {
        threading-enabled = true;
      };
      viewer = {
        pager = "nvim -M -c \":set filetype=md\"";
      };
      compose = {
        editor = "nvim";
      };
      filters = {
        "text/plain" = "cat /dev/stdin";
        "text/html" = "pandoc -f html -t markdown";
      };
    };
  };
  home.packages = with pkgs; [
    pandoc
  ];
}
