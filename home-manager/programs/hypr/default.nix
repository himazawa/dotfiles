
{ inputs, pkgs, config, ... }:

{
  # Declaring monitors 
  imports = [
    ./monitors.nix
  ];
 
  monitors = [
     {
       name = "eDP-1";
       width = 1920;
       height = 1080;
       refreshRate = 60;
       x = 0;
       y = 0;
       enabled = true;
     
     }
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = map
          (m:
            let
              resolution = "${toString m.width}x${toString m.height}@${toString m.refreshRate}";
              position = "${toString m.x}x${toString m.y}";
            in
            "${m.name},${if m.enabled then "${resolution},${position},1" else "disable"}"
          )
          (config.monitors);
    };
  };
}

