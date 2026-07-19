{ lib, ... }: {
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
      local function override(src, overrides)
        local ok, base = pcall(vim.api.nvim_get_hl, 0, { name = src, link = false })
        if not ok then return end
        for k, v in pairs(overrides) do
          base[k] = v
        end
        vim.api.nvim_set_hl(0, src, base)
      end

      local function transparent(group)
          override(group, { bg = "NONE" })
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
    '';
  };
}
