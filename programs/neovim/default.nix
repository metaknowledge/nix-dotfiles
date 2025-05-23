{
  environment.variables.EDITOR = "nvim";
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    # extraConfig = ''
    #  set number relativenumber
    #  set tabstop=2 shiftwidth=2 expandtab
    #'';
  };
}
