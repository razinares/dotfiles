{ config, pkgs, pkgs-unstable, ... }:

{
  programs.rofi = {
    enable=true;
    package = pkgs-unstable.rofi-wayland;
  };
}
