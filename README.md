Build the NixOS system from the specified flake and setup dotfiles.

```sh
sudo nixos-rebuild switch --flake '.#hz'
```

Build macOS system.

```sh
nix build .#darwinConfigurations.heeji.system --extra-experimental-features "nix-command flakes"
```
