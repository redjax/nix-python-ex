## default.nix
#
#  Define defaults for the Nix environment. This is the basis for the Nix environment,
#  where packages are installed and environments are defined.
##

let
    ## Use a pinned version of nixpkgs for reproducibility
    nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-22.11";
    ## Initialize nixpkgs
    pkgs = import nixpkgs { config = {}; overlays = []; };
    ## Import build.nix
    build = pkgs.callPackage ./build.nix {};
in
{
    ## Define the default shell environment, called with nix-shell
    shell = pkgs.mkShell {
        ## Inherit inputs from the build import
        inputsFrom = [ build ];
    };
    ## Define a second shell, '-dev', which is imported in shell-dev.nix
    shell-dev = pkgs.mkShell {
        ## Inherit inputs from the build import
        inputsFrom = [ build ];
        packages = with pkgs; [
            curl
            git
            python311
            ruff
            black
            virtualenv
            (pkgs.python311.withPackages (ps: [
                ps.jupyter
                ps.ipykernel
            ]))
        ];

        ## Create a shell hook to automatically create the project's .venv,
        #  as well as activate it when this environment is called with nix-shell
        shellHook = ''
            virtualenv .venv
            source .venv/bin/activate
        '';
    };
}