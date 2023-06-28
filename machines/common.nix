{ pkgs, ... }:

let
  pkgs-unstable = import <nixpkgs-unstable> { };
in
{
  environment.systemPackages = with pkgs; [
    fish
    vim
    neovim
    vscode
    git
    git-lfs
    llvm

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
