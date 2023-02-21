{ pkgs, ... }:

let
  pkgs-unstable = import <nixpkgs-unstable> { };
in
{
  environment.systemPackages = with pkgs; [
    wezterm
    fish
    vim
    neovim
    git
    git-lfs

    binutils
    coreutils
    inetutils
    gnumake
    cmake
    clang-tools
    ninja
    pkg-config
    libelf
    flex
    bison
    bc
    chromedriver
    geckodriver
  ];
}
