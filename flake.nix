{
  description = "Quickly create FAT disk images";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        defaultPackage = self.packages.${system}.mkfatimg;
        packages.mkfatimg = import ./default.nix { inherit pkgs; };
      }
    );
}
