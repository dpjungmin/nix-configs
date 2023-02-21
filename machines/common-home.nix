{ pkgs, ... }:

let
  pkgs-unstable = import <nixpkgs-unstable> { };
in
{
  home.packages = with pkgs; [
    helix
    tree-sitter
    gtest
    clang-tools
    rustup
    nodejs
    nodePackages.typescript
    python311
    emscripten
    jdk

    # language-servers
    sumneko-lua-language-server
    python310Packages.python-lsp-server
    nodePackages_latest.vim-language-server
    nodePackages_latest.bash-language-server
    nodePackages.typescript-language-server

    # formatters
    rust-analyzer
    stylua
    nodePackages_latest.prettier
    google-java-format
    nixpkgs-fmt

    # apps
    # firefox-devedition-bin
    # thunderbird
    obsidian
    slack
    discord

    # utils
    starship
    exa
    bat
    ripgrep
    igrep
    fd
    lazygit
    fortune
    htop
    btop
    # dolphin
    # wofi
    # hyprpaper
    cmatrix
    asciiquarium
    lolcat
    chezmoi
    # eww-wayland
    jq
    delta
    fzf
    zoxide
    wget
    du-dust
    wasm-pack
    cargo-generate
    cargo-geiger
    cargo-watch
    # grim
    # slurp
    yarn
    difftastic
    file
    # ltrace
    # strace
    unzip
    broot
    just
    wabt

    # miscellaneous
    python310Packages.pynvim
  ];

  programs.home-manager.enable = true;
}
