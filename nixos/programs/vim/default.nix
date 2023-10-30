{ pkgs, ... }:
{
  environment.variables = { EDITOR = "vim"; };

  environment.systemPackages = with pkgs; [
    ((vim_configurable.override {  }).customize {
      name = "vim";
      vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
        start = [ vim-nix vim-lastplace ];
        opt = [];
      };
      
      vimrcConfig.customRC = ''
        "set nocompatible
         set shiftwidth=2 smarttab
         set expandtab
         set tabstop=8 softtabstop=0
         syntax on
         set nu
         set backspace=indent,eol,start
        " ...
      '';
    }
  )];
}
