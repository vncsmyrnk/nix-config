default:
  just --list

install-deps:
  sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon
  nix-channel --add https://nixos.org/channels/nixpkgs-unstable unstable

install: install-deps config

config:
  mkdir -p {{home_dir()}}/.config/nix
  stow -t {{home_dir()}}/.config/nix .

unset-config:
  stow -D -t {{home_dir()}}/.config/nix .

install-packages:
  nix profile install .

update-packages:
  nix flake update
  nix profile upgrade .

rollback:
  nix profile rollback

list-generations:
  nix profile history

delete-old-generations:
  nix profile wipe-history
