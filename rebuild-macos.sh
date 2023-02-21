#!/usr/bin/env sh

nix build .#darwinConfigurations.heeji.system --extra-experimental-features "nix-command flakes" \
  && ./result/sw/bin/darwin-rebuild switch --flake .
