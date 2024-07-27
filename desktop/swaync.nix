{ pkgs, ... }:
{
  options = { };

  config = {
    services.swaync = {
      enable = true;
      settings = {
        positionX = "right";
        positionY = "top";
        layer = "overlay";
        control-center-layer = "top";
        layer-shell = true;
        cssPriority = "application";
        control-center-margin-top = 0;
        control-center-margin-bottom = 0;
        control-center-margin-right = 0;
        control-center-margin-left = 0;
        notification-2fa-action = true;
        notification-inline-replies = false;
        notification-icon-size = 64;
        notification-body-image-height = 100;
        notification-body-image-width = 200;
        widgets = [
          "title"
          "inhibitors"
          "dnd"
          "mpris"
          "notifications"
        ];
        widget-config = {
          inhibitors = {
            text = "Inhibitors";
            button-text = "Clear All";
            clear-all-button = true;
          };
          title = {
            text = "Notifications";
            clear-all-button = false;
            button-text = "Clear All";
          };
          dnd = {
            text = "Do Not Disturb";
          };
          label = {
            max-lines = 5;
            text = "Label Text";
          };
          mpris = {
            image-size = 96;
            blur = true;
          };
        };
      };
    };

    home.packages = with pkgs; [
      libnotify
    ];
  };
}
