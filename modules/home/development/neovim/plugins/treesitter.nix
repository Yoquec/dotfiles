{ pkgs, ... }:
{
  programs.nixvim.plugins.treesitter = {
    enable = true;
    settings = {
      highlight = {
        enable = true;
        additional_vim_regex_highlighting = false;
      };
      indent.enable = true;
    };
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      vimdoc
      python
      c
      cpp
      css
      html
      bash
      gitcommit
      lua
      rust
      go
      nix
      java
      json
      typespec
      smithy
      make
      markdown
      markdown_inline
      javascript
      typescript
      haskell
      yaml
      toml
      zig
    ];
  };
}
