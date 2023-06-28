{ ... }:

let
in
{
  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
    };
    brews = [
      "erdtree"
      "gawk"
      "gnu-sed"
      "gmp"
      "mpfr"
      "libmpc"
      "isl"
      "zlib"
      "expat"
      "texinfo"
      "flock"
      "pkg-config"
      "gtk4"
      "libadwaita"
    ];
    casks = [
      "amethyst"
      "font-lekton-nerd-font"
      "wezterm-nightly"
      "zoom"
      "microsoft-teams"
      "chromium"
    ];
    taps = [
      "homebrew/bundle"
      "homebrew/cask"
      "homebrew/cask-drivers"
      "homebrew/cask-fonts"
      "homebrew/core"
      "homebrew/services"
      "homebrew/cask-versions"

      "solidiquis/tap"
    ];
  };
}
