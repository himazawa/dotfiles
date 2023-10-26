{ config, pkgs, inputs,  ... }:

{
  imports = [
    ./base
    ./programs
  ];
  
  nixpkgs.config.allowUnfree = true; 
  home.username = "himazawa";
  home.homeDirectory = "/home/himazawa";

  home.stateVersion = "23.05";

  home.packages = with pkgs; [
    ripgrep
    swaylock-effects
    pywal
    htop
    wlogout
    xfce.thunar
    grim
    slurp
    swappy
    zsh-powerlevel10k
  ];
  
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
