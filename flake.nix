{
  description = "steampipe poc";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils }:
      flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages = {
          default = pkgs.steampipe;
        };
        devShells = {
          default =   pkgs.mkShell {
            packages = with pkgs; [ steampipe ];
            shellHook = ''
                echo "Please run these commands:"
                echo "steampipe plugin install azure"
                echo "steampipe plugin install kubernetes"
                echo "steampipe service start"
                echo "steampipe service status --show-password"
                echo "steampipe query"
            '';
          };
        };
      }
    );
}
