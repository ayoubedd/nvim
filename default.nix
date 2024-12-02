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
        typos-lsp

        # formatters
        nixfmt
        nodePackages.prettier
        prettierd
        black
        stylua
        rustfmt

        svelte-language-server
        typescript-language-server
        vscode-langservers-extracted
        emmet-ls

      ] ++ (with pkgs.tree-sitter-grammars; [
        # grammars
        tree-sitter-c
        tree-sitter-go
        tree-sitter-gomod
        tree-sitter-zig
        tree-sitter-vim
        tree-sitter-tsx
        tree-sitter-sql
        tree-sitter-nix
        tree-sitter-lua
        tree-sitter-css
        tree-sitter-cpp
        tree-sitter-yaml
        tree-sitter-toml
        tree-sitter-scss
        tree-sitter-rust
        tree-sitter-make
        tree-sitter-json
        tree-sitter-html
        tree-sitter-bash
        tree-sitter-svelte
        tree-sitter-python
        tree-sitter-markdown
        tree-sitter-typescript
        tree-sitter-javascript
        tree-sitter-dockerfile
      ]);
    };

    home.file.".config/nvim" = {
      source = ./conf;
      recursive = true;
    };
  };
}
