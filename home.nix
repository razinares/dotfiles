{ config, pkgs, pkgs-unstable, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "wolf";
  home.homeDirectory = "/home/wolf";
  imports = [ 
    ./apps
  ];
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.
  nixpkgs.config.allowUnfree = true;
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = (with pkgs; [
    kdePackages.kate
    vesktop
    spotify
    vscode
    btop
    nvtop
    htop
  ]) ++
  (with pkgs-unstable; [
    # Unstable packages here
  ]);

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.starship = {
    enable = true;
    # Configuration written to ~/.config/starship.toml
    settings = {
    };
  };

  programs.git = {
    enable = true;
    userName = "Razin Ares";
    userEmail = "root@razin.me";
  };

  programs.kitty = {
    enable = true;
    package = pkgs-unstable.kitty;
    theme = "Tokyo Night";
    font = {
      name = "FiraCode Nerd Font";  # Correct font family name
      size = 13; # Adjust the size as needed
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs-unstable.hyprland;
  };
  home.sessionVariables.NIXOS_OZONE_WL = "1";
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
