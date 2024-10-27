{
  description = "A flake that provides a dev shell for building the EvolutionX custom ROM";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    devShells = forAllSystems (system: {
      default =
        (nixpkgs.legacyPackages.${system}.buildFHSEnv {
          name = "FHS env for EvolutionX ROM building";
          targetPkgs = pkgs: (with pkgs; [
            bison
            ccache
            curl
            flex
            git
            git-lfs
            git-repo
            gnupg
            gperf
            jdk11
            libgcc
            libxslt
            lzop
            maven
            ncftp
            openssl
            pngcrush
            python3
            rsync
            schedtool
            screen
            SDL
            squashfsTools
            tmux
            w3m
            xml2
            zip
            zsh
          ]);
          multiPkgs = pkgs: (with pkgs; [
            ncurses5
            zlib
          ]);
          runScript = "bash";
        })
        .env;
    });
  };
}
