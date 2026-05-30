{ pkgs, ... }:
{
  programs.nixvim.plugins = {
    lazydev = {
      enable = true;
      settings.library = [
        {
          path = "\${3rd}/luv/library";
          words = [ "vim%.uv" ];
        }
        {
          path = "snacks.nvim";
          words = [ "Snacks" ];
        }
      ];
    };

    blink-cmp = {
      enable = true;
      package = pkgs.vimPlugins.blink-cmp;
      settings = {
        appearance.nerd_font_variant = "mono";
        keymap.preset = "enter";
        completion = {
          documentation.auto_show = true;
          list.selection = {
            preselect = false;
            auto_insert = true;
          };
          menu.auto_show = true;
        };
        signature.enabled = true;
        sources = {
          default = [ "lazydev" "lsp" "path" "snippets" "buffer" ];
          providers.lazydev = {
            name = "LazyDev";
            module = "lazydev.integrations.blink";
          };
        };
        snippets.preset = "luasnip";
      };
    };
  };
}
