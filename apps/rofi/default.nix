{ config, pkgs, pkgs-stable, ... }:

{
  programs.rofi = {
    enable = true;
    theme = ./mocha.rasi;
    font = "FiraCode Nerd Font 14";
  };
}
