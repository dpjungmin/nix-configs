{ config, pkgs, ... }:

let
  pkgs-unstable = import <nixpkgs-unstable> { };
in
{
  imports = [ ../common-home.nix ];

  home.packages = with pkgs; [
  ];
}
