{
  description = "Home Manager config";
  inputs = {
    nixpkgs.url =  "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Adding it for the support to firefox addons 
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
     let
       system = "x86_64-linux";
       pkgs = nixpkgs.legacyPackages.${system};
     in {
     
       homeConfigurations."himazawa" = home-manager.lib.homeManagerConfiguration {
         inherit pkgs;
         extraSpecialArgs = { inherit inputs; };
         
         modules = [ ./home.nix ];
     };
   };
} 
