# neovim.nix
{ config, pkgs, ... }:
let
  # Define plugins you want to use with Neovim
  vimPlugins = pkgs.vimPlugins.extend (vimPlugins: {
    # Basic colorscheme plugin
    gruvbox = vimPlugins.buildVimPlugin {
      name = "gruvbox";
      src = pkgs.fetchFromGitHub {
        owner = "morhetz";
        repo = "gruvbox";
        rev = "v0.3.0";
        sha256 = "sha256-M+/jOV9xr/AbyCrN8NzAly3pDjIlIN0McHx5GLN3t+o=";
      };
    };
  });
in {
  # Enable Neovim with Home Manager
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    # Install Neovim plugins
    plugins = with vimPlugins; [
      vim-nix
      vim-lsp
      gruvbox
    ];

    # Configure Neovim settings
    extraConfig = ''
      " Basic Colorscheme
      syntax enable
      colorscheme gruvbox
      set background=dark

      " Relative line numbers
      set relativenumber

      " Enable LSP support
      lua << EOF
        require('lspconfig').pyright.setup{}
        require('lspconfig').tsserver.setup{}
      EOF
    '';

    # Configure Neovim LSP servers
    extraPackages = with pkgs; [
      # Add LSP servers like pyright, typescript-language-server, etc.
      python3Packages.pyright
      nodePackages.typescript-language-server
      nodePackages.typescript
    ];
  };
}

