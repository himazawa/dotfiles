# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      <nixos-hardware/lenovo/thinkpad/t14/amd/gen1>
      ./hardware-configuration.nix
      ./programs
    ];
  

  # Enabling flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-1af28bcb-3c89-49b4-b455-0ecb1a4167f0".device = "/dev/disk/by-uuid/1af28bcb-3c89-49b4-b455-0ecb1a4167f0";
  networking.hostName = "blizzard"; # Define your hostname.
  # Adding modules for thinkpad config
  boot.initrd.availableKernelModules = [ "nvme" "ehci_pci" "xhci_pci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" "thinkpad_acpi" ];
  boot.initrd.kernelModules = [ "acpi_call" ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];
  boot.kernelParams = [ "amd_pstate=active" ]; 
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Rome";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "it_IT.UTF-8";
    LC_IDENTIFICATION = "it_IT.UTF-8";
    LC_MEASUREMENT = "it_IT.UTF-8";
    LC_MONETARY = "it_IT.UTF-8";
    LC_NAME = "it_IT.UTF-8";
    LC_NUMERIC = "it_IT.UTF-8";
    LC_PAPER = "it_IT.UTF-8";
    LC_TELEPHONE = "it_IT.UTF-8";
    LC_TIME = "it_IT.UTF-8";
  };

  # Enabling fonts
  fonts = {
    enableDefaultPackages = true;
  };
  fonts.packages = with pkgs; [
    # font-awesome is needed to correctly display the majority of the icons in waybar
    font-awesome
    fira-code
    fira-code-symbols
    noto-fonts
    # Arimo is needed to correctly display the brightness icon in waybar
    (nerdfonts.override { fonts = [ "Arimo" ]; })
  ];
  # Configure keymap in X11
  # Even if the service name is xserver it is needed to run wayland
  services.xserver = {
    layout = "us";
    xkbVariant = "";
    enable = true;
    displayManager.sddm = { 
      enable = true;
      theme = "chili";
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.himazawa = {
    isNormalUser = true;
    description = "himazawa";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
 
  # Enale fwupd for Firmware updates
  services.fwupd.enable = true; 
  # Enabling tpl for battery life
  #services.tlp.enable = true;
  # Enabling cpufreq
  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
        governor = "powersave";
        turbo = "never";
      };
      charger = {
        governor = "performance";
        turbo = "auto";
      };
    };
   };
  # Enabling fingerprint sensor
  services.fprintd.enable = true;
  services.fprintd.tod.enable = true;
  services.fprintd.tod.driver = pkgs.libfprint-2-tod1-vfs0090;
  security.pam.services.login.fprintAuth = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    waybar
    (waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      })
    )
    # notification daemon
    dunst
    libnotify
    # wallpaper daemon
    swww
    # terminal emulator
    kitty
    # application launcher
    rofi-wayland
    # extension for network manager in bar
    networkmanagerapplet
    # sddm theme
    sddm-chili-theme
    home-manager
  ];

  # Hybernation
  services.logind = {
    extraConfig = "HandlePowerKey=hibernate";
    lidSwitch = "ignore";
  };
  # Audio stuff
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  sound.enable = true;
  security.rtkit.enable = true;
  # this is needed to be able to unlock the screen with swaylock
  security.pam.services.swaylock = {};
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  #Enable hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };
  hardware = {
    opengl.enable = true;
    nvidia.modesetting.enable = true;
  };
  
  # Enable zsh
  programs.zsh.enable = true;

  # Enable gnupg 
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  system.stateVersion = "23.05"; # Did you read the comment?

}
