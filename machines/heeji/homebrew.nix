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
    ];
    casks = [
      "amethyst"
      "font-lekton-nerd-font"
      "wez/wezterm/wezterm-nightly"
      # "docker"
      "zoom"
      "microsoft-teams"
      # "firefox"
      # "google-chrome"
      "chromium"
    ];
    taps = [
      "homebrew/bundle"
      "homebrew/cask"
      "homebrew/cask-drivers"
      "homebrew/cask-fonts"
      "homebrew/core"
      "homebrew/services"

      "wez/wezterm"
      "solidiquis/tap"
    ];
  };
}
