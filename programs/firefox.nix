{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    languagePacks = [ "en-GB" "de" ];
    profiles = {
      "default" = {
        search = {
          default = "DuckDuckGo";
          privateDefault = "DuckDuckGo";
          force = true;
        };
        extensions = with pkgs.nur.repos; [
          rycee.firefox-addons.bitwarden
          rycee.firefox-addons.ublock-origin
        ];
        settings = { "extensions.autoDisableScopes" = 0; };
      };
    };
  };
}
