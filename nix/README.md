# Experimental Nix flake for general cli environment
- Basically for servers, not for my laptops.

# How to Install
```sh
$ nix flake build
$ nix profile install .#my-packages
```

# How to upgrade
```sh
$ nix flake upgrade
$ nix profile upgrade my-packages
```
