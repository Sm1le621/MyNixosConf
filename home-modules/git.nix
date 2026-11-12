{ ... }:

{
  programs.git = {
    enable = true;
    userName = "Sm1le621";
    userEmail = "sashapolyvyaniy@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };
}
