{ inputs, ...}:
{
programs.firefox = {
    enable = true;
    profiles.himazawa = {
      extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
        ublock-origin
        sponsorblock
        bitwarden
      ];
   };
  };
}
