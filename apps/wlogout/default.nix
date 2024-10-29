{ config, pkgs, ... }:

{

  programs.wlogout = {
    enable = true;
    layout = {
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "Shutdown";
        keybind = "s";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = "Reboot";
        keybind" = "r";
      }
      {
        label = "suspend";
        action = "hyprlock & systemctl suspend";
        text = "Suspend";
        keybind = "u";
      }
      {
        label = "hibernate";
        action = "systemctl hibernate";
        text = "Hibernate";
        keybind" = "h";
      }
      {
        label = "lock";
        action = "hyprlock";
        text = "Lock";
        keybind" = "l";
      }
      {
        label = "logout";
        action = "hyprctl dispatch exit";
        text = "Logout";
        keybind = "e";
      }
    };
  };

}