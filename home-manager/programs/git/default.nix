{ pkgs, inputs, config, ...}:
{
  programs.git = {
    enable = true;
    userName = "himazawa";
    userEmail = "73994521+himazawa@users.noreply.github.com";
    package = pkgs.gitFull;
    extraConfig = {
      commit.gpgsign = true;
      gpg.format = "ssh";
      gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
      user.signingkey = "~/.ssh/id_ed25519.pub";
      credential.helper = "${
          pkgs.git.override { withLibsecret = true; }
        }/bin/git-credential-libsecret";
    };
  };
}
