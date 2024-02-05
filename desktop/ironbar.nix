{ ... }:

{
  programs.ironbar = {
    enable = true;
    config = {
      position = "top";
      height = 30;
      end = [
        {
          type = "clock";
        }
      ];
    };

  };
}
