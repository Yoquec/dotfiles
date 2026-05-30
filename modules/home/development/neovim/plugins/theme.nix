{ pkgs, config, ... }:
{
  programs.nixvim = {
    extraPlugins = [ pkgs.vimPlugins.base16-nvim ];

    extraConfigLua = ''
      local theme_var = "${config.theme}"

      local themes = { dark = {} }

      themes.dark.colors = {
        base00 = "#000000",
        base01 = "#000000",
        base02 = "#000000",
        base03 = "#757d8a",
        base04 = "#8b95a7",
        base05 = "#eaeaea",
        base06 = "#373b41",
        base07 = "#ffffff",
        base08 = "#d54e53",
        base09 = "#7aa6da",
        base0A = "#e7c547",
        base0B = "#b9ca4a",
        base0C = "#70c0b1",
        base0D = "#7aa6da",
        base0E = "#c397d8",
        base0F = "#e7c547",
      }

      themes.dark.group_overrides = {
        ["Visual"] = { reverse = true },
        ["Search"] = { fg = themes.dark.colors.base00, bg = themes.dark.colors.base04 },
        ["CurSearch"] = { fg = themes.dark.colors.base00, bg = themes.dark.colors.base0A },
        ["LineNr"] = { fg = themes.dark.colors.base05, bold = true },
        ["LineNrAbove"] = { fg = themes.dark.colors.base04 },
        ["LineNrBelow"] = { fg = themes.dark.colors.base04 },
        ["TSStrong"] = { fg = themes.dark.colors.base0F, bold = true },
        ["Italic"] = { fg = themes.dark.colors.base0E, italic = true },
        ["@markup.list.markdown"] = { fg = themes.dark.colors.base08 },
        ["@markup.strikethrough.markdown_inline"] = { link = "markdownStrikeDelimiter" },
        ["Raw"] = { fg = themes.dark.colors.base08, bg = themes.dark.colors.base06 },
        ["@markup.raw.markdown_inline"] = { link = "Raw" },
        ["SpellBad"] = { sp = themes.dark.colors.base08, underdotted = true },
        ["SpellCap"] = { sp = themes.dark.colors.base09, underdotted = true },
        ["SpellRare"] = { sp = themes.dark.colors.base0E, underdotted = true },
        ["SpellLocal"] = { sp = themes.dark.colors.base0C, underdotted = true },
      }

      if theme_var == nil or theme_var == "dark" then
        vim.o.background = "dark"
        require("base16-colorscheme").setup(themes.dark.colors)
        for name, val in pairs(themes.dark.group_overrides) do
          vim.api.nvim_set_hl(0, name, val)
        end
      else
        require("base16-colorscheme").setup()
        vim.o.background = "light"
        vim.cmd([[colorscheme base16-tomorrow]])
      end
    '';
  };
}
