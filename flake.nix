{
  description = "A collection of n1kolasM's packages";

  inputs.flake-utils.url = "github:numtide/flake-utils";
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: {
      packages = let
        pkgs = import nixpkgs {
          inherit system;
          config = { allowUnfree = true; };
        };
        defaultAttrs = import ./default.nix { inherit pkgs; };
        isReserved = n: n == "lib" || n == "overlays" || n == "modules";
        nameValuePair = n: v: { name = n; value = v; };
        defaultPkgs = with builtins;
          (listToAttrs
          (map (n: nameValuePair n defaultAttrs.${n})
          (filter (n: !isReserved n)
          (attrNames defaultAttrs))));
      in
        flake-utils.lib.flattenTree defaultPkgs;
      }
    );
}
