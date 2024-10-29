# hyprland.nix
{ config, pkgs, pkgs-stable, ... }:

{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "/home/wolf/Downloads/wallpaper.png" ];
      wallpaper = [ "DP-2, /home/wolf/Downloads/wallpaper.png" ];
    };
  };
  programs.hyprlock = {
    enable = true;
    settings = {
      background = [
        {
          monitor = "";
          path = "${config.home.homeDirectory}/Downloads/512780.jpg";  # Make sure the path is correct
          blur_passes = 0;
          contrast = 0.8916;
          brightness = 0.8916;
          vibrancy = 0.8916;
          vibrancy_darkness = 0.0;
        }
      ];

      label =
        {
          monitor = "";
          text = "DIE";
          #text_align = "center";
          color = "rgba(255, 255, 255, 1.0)";
          font_size = 80;
          font_family = "FiraCode Nerd Font";
          rotate = 0;
          position = "40 200";  # Adjusted to the center of 3072x1728 (scaled resolution)
          halign = "center";
          valign = "center";
        };

      input-field = [
        {
          size = "320 55";
          outline_thickness = 2;
          outer_color = "rgba(255, 255, 255, 0.5)";
          inner_color = "rgba(0, 0, 0, 0.6)";
          font_color = "rgba(255, 255, 255, 1.0)";
          font_family = "FiraCode Nerd Font";
          hide_input = false;
          placeholder_text = "Password...";
          position = "40 60";  # Centered below the label
          halign = "center";
          valign = "center";
        }
      ];
    };
  };





    
  wayland.windowManager.hyprland.settings = {

    # Monitor config
    monitor = ["DP-2,3840x2160@144,0x0,1.25"];

    # Startup apps
    exec-once = [
      "waybar"
      "swaync"
      "blueman-applet"
      "fcitx5 -d"
    ];

    env = [
      "XDG_SESSION_DESKTOP,Hyprland"
      "GDK_BACKEND,wayland"
      "CLUTTER_BACKEND,wayland"
      "HYPRCURSOR_SIZE,24"
      "GTK_IM_MODULE,fcitx"
      "QT_IM_MODULE,fcitx"
      "XMODIFIERS,@im=fcitx"
    ];

    general = {
      gaps_in = 10;
      gaps_out = 30;
      border_size = 4;
      gaps_workspaces = 50;
      allow_tearing = false;
      # Approximating gradients with solid colors from the Tokyo Night palette
      "col.active_border" = "rgb(414A6B)";      # bb9af7ff - Purple
      "col.inactive_border" = "rgb(303552)";    # 565f89cc - Muted Blue
      layout = "dwindle";  # Layout must be passed as a string
      resize_on_border = true;
    };

    
    decoration = {
      rounding = 0;
      drop_shadow = false;

      blur = {
          enabled = true;
          size = 6;
          passes = 3;
          new_optimizations = true;
          ignore_opacity = true;
          xray = false;
      };
    };


    animations = {
      enabled = true;
      animation = [
        "border, 1, 2, default"
        "fade, 1, 4, default"
        "windows, 1, 3, default, popin 80%"
        "workspaces, 1, 2, default, slide"
      ];
    };


    dwindle = {
      # keep floating dimentions while tiling
      pseudotile = true;
      preserve_split = true;
    };

    misc = {
      # disable auto polling for config file changes
      disable_autoreload = true;


      # disable dragging animation
      animate_mouse_windowdragging = false;

      # enable variable refresh rate (effective depending on hardware)
      vrr = 1;
    };

    xwayland.force_zero_scaling = true;


    # Set MOD
    "$mod" = "SUPER";
    # Bind keys
    bind =
      [      
        "$mod, F, fullscreen"
        "$mod, T, exec, kitty"
        "$mod, SPACE, exec, rofi -show drun"
        "$mod, Q, killactive"
        "$mod, V, togglefloating"
        "$mod, U, exec, XDG_CURRENT_DESKTOP=gnome gnome-control-center"
        "$mod, L, exec, hyprlock"
        
        # Move Focus
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        "$mod SHIFT, L, exec, hyprctl dispatch exit"
        "$mod SHIFT, S, exec, hyprshot -m region"
      ]

      ++ (
        # Workspaces: binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (builtins.genList (i:
          let ws = i + 1; in [
            "$mod, code:1${toString i}, workspace, ${toString ws}"
            "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
          ])
          9)
      );

    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
      "$mod ALT, mouse:272, resizewindow"

    ];

  };

  home.pointerCursor = {
    gtk.enable = true;
    # x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };



  # Add Hyprland and related packages to systemPackages
  home.packages = with pkgs; [
    waybar
    cava
    gnome-control-center
    grim
    slurp
    hyprpaper
    nautilus
    jq # Parse
    wl-clipboard # Clip
    libnotify # Notification
    hyprshot # Screenshot
  ];

  services.blueman-applet.enable = true;
}

