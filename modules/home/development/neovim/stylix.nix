{ lib, config, ... }:
let
  inherit (config.lib.stylix) colors;
in
{
  config = {
    stylix = {
      enable = lib.mkForce true;
      targets.nixvim = {
        enable = lib.mkForce true;
        transparentBackground = {
          main = true;
          signColumn = true;
          numberLine = true;
        };
      };
    };

    programs.nixvim.extraConfigLua = ''
      local function override(src, dest, overrides)
        local ok, base = pcall(vim.api.nvim_get_hl, 0, { name = src, link = false })
        if not ok then return end
        for k, v in pairs(overrides) do
          base[k] = v
        end
        vim.api.nvim_set_hl(0, dest, base)
      end

      local function link(src, dest)
          vim.api.nvim_set_hl(0, dest, { link = src })
      end

      local function override_self(src, overrides)
          override(src, src, overrides)
      end

      local function transparent(group)
          override_self(group, { bg = "NONE" })
      end

      transparent("StatusLine") 
      transparent("StatusLineNC") 
      transparent("FloatBorder") 
      transparent("NormalFloat") 
      transparent("CursorLine")
      transparent("CursorLineSign")

      transparent("PMenu")
      transparent("DiagnosticFloatingOk")
      transparent("DiagnosticFloatingHint")
      transparent("DiagnosticFloatingInfo")
      transparent("DiagnosticFloatingWarn")
      transparent("DiagnosticFloatingError")

      transparent("GitSignsAdd")
      transparent("GitSignsChange")
      transparent("GitSignsDelete")
      transparent("GitSignsStagedAdd")
      transparent("GitSignsUntracked")
      transparent("GitSignsStagedChange")
      transparent("GitSignsStagedDelete")
      transparent("GitSignsStagedTopdelete")
      transparent("GitSignsStagedUntracked")
      transparent("GitSignsStagedChangedelete")

      transparent("WhichKeyFloat")
      transparent("WhichKeySeparator")

      link("@label", "@markup.link.label.markdown")
      link("@label", "@markup.link.label.markdown_inline")

      vim.api.nvim_set_hl(0, "@punctuation.special.markdown", { fg = "${colors.withHashtag.base0A}" })
      vim.api.nvim_set_hl(0, "@markup.strong.markdown_inline", { fg = "${colors.withHashtag.base0B}", bold = true })
      vim.api.nvim_set_hl(0, "@markup.italic.markdown_inline", { fg = "${colors.withHashtag.base0E}", italic = true })
      vim.api.nvim_set_hl(0, "@markup.link.markdown_inline", { fg = "${colors.withHashtag.base0D}", underline = true })
      vim.api.nvim_set_hl(0, "@markup.link.url.markdown", { fg = "${colors.withHashtag.base0D}", underline = true })
      vim.api.nvim_set_hl(0, "@markup.raw.markdown_inline", { bg = "${colors.withHashtag.base01}", fg = "${colors.withHashtag.base08}" })
    '';
  };
}
