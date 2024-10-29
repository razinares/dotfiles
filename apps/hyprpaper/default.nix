{ config, lib, pkgs, ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "/home/wolf/Downloads/wallpaper.png" ];
      wallpaper = [ "DP-2, /home/wolf/Downloads/wallpaper.png" ];
    };
  };

}