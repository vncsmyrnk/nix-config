{
  description = "Development environment with custom packages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            (final: prev: {
              go = prev.go.overrideAttrs (oldAttrs: rec {
                version = "1.24.5";
                src = prev.fetchFromGitHub {
                  owner = "golang";
                  repo = "go";
                  rev = "go${version}";
                  hash = "sha256-/KvCdXaE92t/LRbUTHkPa+MhuA0lvhSUqxC237imEy0=";
                };
              });
            })
          ];
        };
      in
      {
        # Single package bundle for nix profile install
        packages.default = pkgs.buildEnv {
          name = "my-dev-packages";
          paths = with pkgs; [
            go
            tmux
            neovim
            lazygit
            gh
            watchman
            htmlq
            rclone
            just
            mkcert
            fluxcd
            lua51Packages.luarocks
            nodejs
          ];
          pathsToLink = [ "/bin" "/share" ];
        };
      });
}
