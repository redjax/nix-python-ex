{
    description = "Example Python package, running in a Nix environment.";

    ## Flake inputs
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs";
    };

    ## Flake outputs
    outputs = {
        self,
        nixpkgs,
    }: let
        ## Supported systems
        allSystems = [
            "x86_x64-linux"
            "aarch64-linux"
        ];

        ## Helper, provides attributes based on system type
        forAllSystems = f:
            nixpkgs.lib.genAttrs allSystems (system:
                f {
                    pkags = import nixpkgs {inherit system;};
                });
        in {
            ## Development environment output
            devShells = forAllSystems({pkgs}: {
                default = let
                    ## Use Python 3.11
                    python = pkgs.python311;
                in
                    pkgs.mkShell {
                        ## Packages provided to environment by Nix
                        packages = [
                            ## Python plus helper tools
                            (python.withPackages (ps:
                                with ps; [
                                    jwcrypto
                                ]
                            ))
                        ];
                    };
            });
        };
}