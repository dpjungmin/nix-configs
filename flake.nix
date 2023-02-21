{
  description = "My configurations!";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    hyprland.url = "github:hyprwm/Hyprland";
    flake-utils.url = "github:numtide/flake-utils";
    flake-utils-plus.url = "github:gytis-ivaskevicius/flake-utils-plus";
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager, darwin, ... }:
    let
      # XPS 15 9520
      machine-1 = {
        hostname = "hz";
        username = "jm";
      };
      # MacBook Air
      machine-2 = {
        hostname = "heeji";
        username = "jungmin";
      };
      # MacBook Pro
      machine-3 = {
        hostname = "jungmin";
        username = "heeji";
      };
      nixpkgsConfig = {
        allowUnfree = true;
        allowUnsupportedSystem = false;
      };
      stateVersion = "22.11";
    in
    {
      nixosConfigurations.${machine-1.hostname} = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs machine-1; };
        modules = [
          ./machines/hz
          ({ pkgs, ... }: {
            nixpkgs.config = nixpkgsConfig;
            system.stateVersion = stateVersion;
            users.users.${machine-1.username} = {
              extraGroups = [ "networkmanager" "wheel" "video" "docker" ];
              isNormalUser = true;
              shell = pkgs.fish;
            };
          })
          inputs.hyprland.nixosModules.default
          { programs.hyprland.enable = true; }
          home-manager.nixosModule
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs; };
              users.${machine-1.username} = { ... }: {
                imports = [ ./machines/hz/jm.nix ];
                home = {
                  username = machine-1.username;
                  homeDirectory = "/home/${machine-1.username}";
                  stateVersion = stateVersion;
                };
              };
            };
          }
        ];
      };

      darwinConfigurations.${machine-2.hostname} = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = { inherit inputs machine-2; };
        modules = [
          ./machines/heeji
          ({ pkgs, ... }: {
            nixpkgs.config = nixpkgsConfig;
            system.stateVersion = 4;
            users.users.${machine-2.username} = {
              home = "/Users/${machine-2.username}";
              shell = pkgs.fish;
            };
          })
          home-manager.darwinModule
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs; };
              users.${machine-2.username} = { ... }: {
                imports = [ ./machines/heeji/jungmin.nix ];
                home = {
                  username = machine-2.username;
                  stateVersion = stateVersion;
                };
              };
            };
          }
        ];
      };
    };
}
