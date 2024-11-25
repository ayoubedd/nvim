{ pkgs }: { lib, config, ... }: 
with lib;
with pkgs;
let
 cfg = config.orbit-nvim;
in
{
  options.orbit-nvim = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };

    neovide = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
    ] ++ optional cfg.neovide neovide;

    programs.neovim = {
      package = neovim-unwrapped;
      enable = true;
      extraPackages = [
        # essentials
        nodejs gcc git cargo tree-sitter ripgrep

        # lsp servers
        nixd
        pyright
        eslint_d
        pylint
        rust-analyzer
        gopls
        clang-tools

        svelte-language-server
        typescript-language-server
        vscode-langservers-extracted
        emmet-ls
      ];
    };

    home.file.".config/nvim" = {
      source = ./conf;
      recursive = true;
    };
  };
}
