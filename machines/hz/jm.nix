{ config, pkgs, ... }:

let
  pkgs-unstable = import <nixpkgs-unstable> { };
in
{
  imports = [ ../common-home.nix ];

  home.packages = with pkgs; [
    # apps
    firefox-devedition-bin
    thunderbird

    # utils
    dolphin
    wofi
    hyprpaper
    eww-wayland
    grim
    slurp
    ltrace
    strace
  ];

  services.dropbox = {
    enable = true;
    path = "${config.home.homeDirectory}/Dropbox";
  };

  targets.genericLinux.enable = true;
}
