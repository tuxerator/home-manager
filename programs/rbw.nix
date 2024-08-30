{ config, pkgs, ... }:

{
  programs.rbw = {
    enable = true;
    settings = {
      base_url = "https://api.bitwarden.eu/";
      identity_url = "https://identity.bitwarden.eu";
      email = "jakob.sanowski@sanbach.de";
      pinentry = pkgs.pinentry-gnome3;
      lock_timeout = 7200;
    };
  };
}
