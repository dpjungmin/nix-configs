{ config, pkgs, nixpkgs, inputs, machine-2, ... }:

let
  pkgs-unstable = import <nixpkgs-unstable> { };
  hostname = machine-2.hostname;
  username = machine-2.username;
in
{
  imports = [
    ../common.nix
    ./homebrew.nix
  ];

  networking.hostName = hostname;
  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
  ];

  nix = {
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
    package = pkgs.nixFlakes;
    settings = {
      allowed-users = [ username ];
      experimental-features = [ "nix-command" "flakes" ];
    };
  };

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      recursive
      nerdfonts
    ];
  };

  services.nix-daemon.enable = true;
}
