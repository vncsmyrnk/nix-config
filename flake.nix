{
  description = "Development environment with custom packages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
    in
    {
      # Single package bundle for nix profile install
      packages.${system}.default = pkgs.buildEnv {
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
          jq
          mkcert
          fluxcd
          fzf
          fd
          ripgrep
          lua51Packages.luarocks
          nodejs
          nixpkgs-fmt
          gemini-cli
        ];
        pathsToLink = [ "/bin" "/share" ];
      };
    };
}
