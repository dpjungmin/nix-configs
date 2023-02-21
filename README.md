Build the NixOS system from the specified flake and setup dotfiles.

```sh
sudo nixos-rebuild switch --flake '.#hz'
chezmoi init --apply dpjungmin
```
