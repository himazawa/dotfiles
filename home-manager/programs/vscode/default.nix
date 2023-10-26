{ pkgs, inputs, ...}:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
    extensions = with pkgs.vscode-extensions; [
      yzhang.markdown-all-in-one
      golang.go
    ];
  };
}

