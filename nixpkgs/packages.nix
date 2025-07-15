with import <nixpkgs> {}; [
  (go.overrideAttrs (oldAttrs: rec {
    version = "1.24.5";
    src = fetchFromGitHub {
      owner = "golang";
      repo = "go";
      rev = "go${version}";
      sha256 = "sha256-/KvCdXaE92t/LRbUTHkPa+MhuA0lvhSUqxC237imEy0=";
    };
  }))

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
  nodePackages.npm
]
