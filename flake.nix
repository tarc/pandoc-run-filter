# This flake was initially generated by fh, the CLI for FlakeHub (version 0.1.13)
{
  
  description = "pandoc-run-filter";

  
  inputs = {
    flake-schemas.url = "https://flakehub.com/f/DeterminateSystems/flake-schemas/*";

    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/*";
  };

  
  outputs = { self, flake-schemas, nixpkgs }:
    let
      
      supportedSystems = [ "x86_64-darwin" "x86_64-linux" ];

      forEachSupportedSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f {

        pkgs = import nixpkgs {
          inherit system;
          overlays = builtins.attrValues self.overlays;
        };

      });

    in {
      
      schemas = flake-schemas.schemas;

      packages = forEachSupportedSystem ({ pkgs }: rec {
        python3Extra = pkgs.python3.withPackages(ps: [
          ps.pandoc-run-filter
        ]);
        default = python3Extra;
      });

      overlays = {
        extraPackages = final: prev: {
          python3Extra = self.packages.${prev.system}.python3Extra;
        };
        pythonExtraPackages = final: prev: {
          pythonPackagesOverlays = (prev.pythonPackagesOverlays or []) ++ [
            (pyfinal: pyprev: {
              cffi = pyprev.cffi.overridePythonAttrs(old: {
                doCheck = old.doCheck && !prev.stdenv.isDarwin;
              });
              pandoc-run-filter = pyfinal.callPackage ./pandoc-run-filter {};
            })
          ];
          python3 =
            let
              self = prev.python3.override {
                inherit self;
                packageOverrides = prev.lib.composeManyExtensions final.pythonPackagesOverlays;
              };
            in self;

          python3Packages = final.python3.pkgs;
        };
      };
      
      devShells = forEachSupportedSystem ({ pkgs }: {
        default = pkgs.mkShell {
          packages = with pkgs; [
            git
            python3Extra
          ];
        };
      });
    };
}
