{ ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      colors = {
        primary = {
          background = "#1d1f21";
          bright_foreground = "#eaeaea";
          dim_foreground = "#828482";
          foreground = "#c5c8c6";
        };
      };
      window = {
        opacity = 0.7;
      };
    };
  };
}
