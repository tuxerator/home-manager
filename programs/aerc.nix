{ config, pkgs, ... }: {
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
        "text/html" = "pandoc -f html -t plain";
      };
    };
  };
  home.packages = with pkgs; [
    pandoc
  ];
}
