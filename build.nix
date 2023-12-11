## build.nix
#
#  Defines the build stage of the Nix environment. This happens when a nix-shell is
#  entered, or some other environment calls this with something like:
#
#  ## Define the default shell environment, called with nix-shell
#     shell = pkgs.mkShell {
#         ## Inherit inputs from the build import
#         inputsFrom = [ build ];
#     };
##

{ cowsay, runCommand}:
## cowsay is defined as a buildtime dependency using buildInputs
runCommand "cowsay-output" { buildInputs = [ cowsay ]; } ''
    cowsay Hello, Nix! > $out
''