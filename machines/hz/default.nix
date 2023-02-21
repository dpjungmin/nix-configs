{ config, pkgs, nixpkgs, inputs, machine-1, ... }:

let
  pkgs-unstable = import <nixpkgs-unstable> { };
  hostname = machine-1.hostname;
  username = machine-1.username;
in
{
  imports = [
    ../common.nix
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.hostName = hostname;
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver = {
    layout = "us,kr";
    xkbVariant = "mac,";
    xkbModel = "";
    xkbOptions = "grp:ctrls_toggle";
  };

  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  environment.systemPackages = with pkgs; [
    firefox
    google-chrome
    dunst

    gcc
    mako
    pipewire
    wireplumber
    elfutils
  ];

  environment.shells = with pkgs; [ fish ];

  services.openssh.enable = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Install NVIDIA official drivers
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    package = pkgs.nixFlakes;
    settings = {
      allowed-users = [ username ];
      experimental-features = [ "nix-command" "flakes" ];
    };
  };

  programs.light.enable = true;

  systemd.timers."chezmoi-update" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "12h";
      OnUnitActiveSec = "12h";
      Unit = "chezmoi-update.service";
    };
  };

  systemd.services."chezmoi-update" = {
    path = [ pkgs.chezmoi ];
    script = ''
      chezmoi update
    '';
    serviceConfig = {
      Type = "oneshot";
      User = username;
    };
  };

  virtualisation.docker.enable = true;

  fonts = {
    fonts = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      source-code-pro
      source-han-mono
      source-han-sans
      source-han-serif
      liberation_ttf
      fira-code
      fira-code-symbols
      mplus-outline-fonts.githubRelease
      dina-font
      proggyfonts
      wqy_zenhei
    ];

    fontDir.enable = true;
    fontconfig.enable = true;
  };
}
