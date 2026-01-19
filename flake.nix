{
  description = "Development environment with custom packages";

  inputs = { nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      # Single package bundle for nix profile install
      packages.${system}.default = pkgs.buildEnv {
        name = "my-dev-packages";
        paths = with pkgs; [
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
          xclip
          kubectl
          ngrok
          sshfs
          oath-toolkit
          eog
          stripe-cli
        ];
        pathsToLink = [ "/bin" "/share" ];
      };
    };
}
