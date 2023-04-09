{ pkgs, ... }:

let
  pkgs-unstable = import <nixpkgs-unstable> { };
in
{
  home.packages = with pkgs; [
    helix
    tree-sitter
    gtest
    rustup
    nodejs
    nodePackages.typescript
    python311
    emscripten
    jdk
    lua
    luajitPackages.fennel
    universal-ctags
    bear
    lldb

    # language-servers
    sumneko-lua-language-server
    cmake-language-server
    python310Packages.python-lsp-server
    nodePackages_latest.vim-language-server
    nodePackages_latest.bash-language-server
    nodePackages.typescript-language-server
    nodePackages_latest.pyright

    # formatters
    stylua
    nodePackages_latest.prettier
    google-java-format
    nixpkgs-fmt
    black

    # apps
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
    cmatrix
    asciiquarium
    lolcat
    chezmoi
    jq
    gh
    delta
    hyperfine
    fzf
    zoxide
    wget
    du-dust
    wasm-pack
    cargo-generate
    cargo-geiger
    cargo-watch
    cargo-expand
    yarn
    difftastic
    file
    unzip
    broot
    just
    onefetch
    fping
    graphviz
    slides
    graph-easy

    # miscellaneous
    python310Packages.pynvim
  ];

  programs.home-manager.enable = true;
}
