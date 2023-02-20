{
  description = "My configurations!";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
    flake-utils.url = "github:numtide/flake-utils";
    flake-utils-plus.url = "github:gytis-ivaskevicius/flake-utils-plus";
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager, darwin, ... }:
    let
      machine-1 = {
        hostname = "hz";
        username = "jm";
      };
      machine-2 = {
        hostname = "heeji";
        username = "jungmin";
      };
      stateVersion = "22.11";
    in
    {
      nixosConfigurations.${machine-1.hostname} = nixpkgs-unstable.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ({ ... }: {
            nixpkgs.config = {
              allowUnfree = true;
            };
          })
          inputs.hyprland.nixosModules.default
          { programs.hyprland.enable = true; }
          ./hz-jm.nix
          home-manager.nixosModule
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs; };
              users.${machine-1.username} = { ... }: {
                imports = [
                  ./home.nix
                ];
                home = {
                  username = machine-1.username;
                  homeDirectory = "/home/${machine-1.username}";
                  stateVersion = stateVersion;
                };
                programs.home-manager.enable = true;
                targets.genericLinux.enable = true;
              };
            };
          }
        ];
      };

      # homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
      #   pkgs = import nixpkgs {
      #     system = "x86_64-linux";
      #     config = {
      #       allowUnfree = true;
      #     };
      #   };
      #   extraSpecialArgs = { inherit inputs; };
      #   modules = [
      #     ({ ... }: {
      #       home = {
      #         stateVersion = stateVersion;
      #         username = username;
      #         homeDirectory = "/home/${username}";
      #       };
      #       programs.home-manager.enable = true;
      #       targets.genericLinux.enable = true;
      #     })
      #     ./home.nix
      #   ];
      # };
    };
}
