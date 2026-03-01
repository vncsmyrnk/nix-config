os := `cat /etc/os-release | grep "^NAME=" | cut -d "=" -f2 | tr -d '"'`

default:
  just --list

install-deps:
  #!/usr/bin/env bash
  if [ "{{os}}" = "Arch Linux" ]; then
    sudo pacman -S nix
  fi

install: install-deps config

config:
  mkdir -p "{{home_dir()}}/.config/nix"
  stow -t "{{home_dir()}}/.config/nix" .

unset-config:
  stow -D -t "{{home_dir()}}/.config/nix" .
