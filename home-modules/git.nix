{ ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Sm1le621";
        email = "sashapolyvyaniy@gmail.com";
      };
      init = {
        defaultBranch = "main";
      };
      pull = {
        rebase = true;
      };
    };
  };
}
