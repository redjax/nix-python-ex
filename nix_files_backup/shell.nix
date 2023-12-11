## shell.nix
#
#  Imports the shell environment from default.nix. The environment defined in default.nix
#  inherits buildtime instructions from build.nix.
##

## Import the shell environment defined in default.nix when nix-shell is executed
(import ./.).shell