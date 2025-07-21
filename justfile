default:
  just --list

install-deps:
  sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon
  nix-channel --add https://nixos.org/channels/nixpkgs-unstable unstable

install: install-deps config profile-install

config:
  mkdir -p {{home_dir()}}/.config/nix
  stow -t {{home_dir()}}/.config/nix .

unset-config:
  stow -D -t {{home_dir()}}/.config/nix .

flake-check:
  nix flake check

profile-install:
  nix profile install .

profile-list:
  nix profile list

profile-upgrade:
  nix flake update
  nix profile upgrade --all

profile-rollback:
  nix profile rollback

profile-history:
  nix profile history

profile-history-diff:
  nix profile diff-closures

profile-wipe:
  nix profile wipe-history
