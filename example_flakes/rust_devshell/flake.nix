{
  inputs = {
    nixpkgs = { url = "github:NixOS/nixpkgs/nixos-unstable"; };
    flake-utils = { url = "github:numtide/flake-utils"; };
    ## Add an overlay for the Rust toolchain
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      ## Add nixpkgs & flake utils to the Rust overlay
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };
  };

  outputs = { self, nixpkgs, flake-utils, rust-overlay }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          overlays = [ (import rust-overlay) ];
          pkgs = import nixpkgs {
            inherit system overlays;
          };
          ## Add ./rust-toolchain.toml file if it exists
          # rustToolchain = pkgs.pkgsBuildHost.rust-bin.fromRustupToolchainFile ./rust-toolchain.toml;
          ## If using the rustToolchain, uncomment the next 2 lines
          # nativeBuildInputs = with pkgs; [ rustToolchain pkg-config ];
          ## Use the first buildInputs if not passing the rustToolchain group, otherwise use the 2nd
          buildInputs = with pkgs; [ openssl ];
          # buildInputs = with pkgs; [ rustToolchain openssl sqlite ];
        in
        with pkgs;
        {
          devShells.default = mkShell {
            ## Comment the first buildInputs & uncomment the second if using a rust-toolchain.toml file
            buildInputs = [ rust-bin.stable.latest.default ];
            # buildInputs = [ rustToolchain ];
          };
        }
      );
}