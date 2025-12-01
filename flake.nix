{
  description = "Development environment with custom packages";

  inputs = { nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          (final: prev: {
            tmux = prev.tmux.overrideAttrs (oldAttrs: rec {
              version = "3.5a";
              src = pkgs.fetchurl {
                url =
                  "https://github.com/tmux/tmux/releases/download/${version}/tmux-${version}.tar.gz";
                hash = "sha256-FiFr0IdxcN/MZBVwhbqQE2ELErCCVIx8lULMAQMZiVE=";
              };
            });
          })
        ];
      };
    in {
      # Single package bundle for nix profile install
      packages.${system}.default = pkgs.buildEnv {
        name = "my-dev-packages";
        paths = with pkgs; [
          golangci-lint
          go
          tmux
          lazygit
          gh
          watchman
          htmlq
          rclone
          just
          jq
          mkcert
          fluxcd
          fzf
          fd
          ripgrep
          lua51Packages.luarocks
          nodejs_24
          tree-sitter
          nixpkgs-fmt
          gemini-cli
        ];
        pathsToLink = [ "/bin" "/share" ];
      };
    };
}
