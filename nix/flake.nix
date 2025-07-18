{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: {

    packages.x86_64-linux.my-packages = nixpkgs.legacyPackages.x86_64-linux.buildEnv {
      name = "my-packages-list";
      paths = [
        nixpkgs.legacyPackages.x86_64-linux.fish
        nixpkgs.legacyPackages.x86_64-linux.git
        nixpkgs.legacyPackages.x86_64-linux.curl
        nixpkgs.legacyPackages.x86_64-linux.neovim
        nixpkgs.legacyPackages.x86_64-linux.ripgrep
        nixpkgs.legacyPackages.x86_64-linux.bat
        nixpkgs.legacyPackages.x86_64-linux.eza
        nixpkgs.legacyPackages.x86_64-linux.zoxide
        nixpkgs.legacyPackages.x86_64-linux.yazi
        nixpkgs.legacyPackages.x86_64-linux.hexyl
        nixpkgs.legacyPackages.x86_64-linux.fzf
        nixpkgs.legacyPackages.x86_64-linux.difftastic
        nixpkgs.legacyPackages.x86_64-linux.starship
        nixpkgs.legacyPackages.x86_64-linux.lazygit

        nixpkgs.legacyPackages.x86_64-linux.clang-tools
      ];
    };
  };
}

