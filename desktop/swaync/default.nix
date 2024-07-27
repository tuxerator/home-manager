{ pkgs, builtins, ... }:
let
  scss-path = ./style.scss;
  css-path = pkgs.runCommand "swaync-scss" {} "${pkgs.sassc}/bin/sassc ${scss-path} > $out";
  in
{
  options = { };

  config = {
    services.swaync = {
      enable = true;
      style = css-path;
      settings = {
        positionX = "right";
        positionY = "top";
        layer = "overlay";
        control-center-layer = "top";
        layer-shell = true;
        cssPriority = "application";
        control-center-margin-top = 2;
        control-center-margin-bottom = 2;
        control-center-margin-right = 2;
        control-center-margin-left = 2;
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
            clear-all-button = true;
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
