{
  description = "A very basic flake";

  inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

  outputs = { self, nixpkgs, ... }@inputs: 
  let
    pkgs = import nixpkgs { system = "x86_64-linux"; };
  in
  {
    homeManagerModules.neovim = import ./default.nix { inherit pkgs; };
  };
}
