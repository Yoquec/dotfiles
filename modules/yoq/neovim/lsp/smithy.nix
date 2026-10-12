# modified version of lspconfig's smithy_ls.
{ ... }:
{
  yoq.neovim.homeManager =
    { pkgs, ... }:
    {
      programs.nixvim = {
        extraPackages = [ pkgs.smithy-language-server ];

        lsp.servers.smithy = {
          enable = true;
          packageFallback = true;

          config = {
            cmd = [ "smithy-language-server" ];
            filetypes = [ "smithy" ];
            root_markers = [
              ".smithy-project.json"
              "smithy-build.json"
              "build.gradle"
              "build.gradle.kts"
              ".git"
            ];
            message_level.__raw = "vim.lsp.protocol.MessageType.Log";
            init_options = {
              statusBarProvider = "show-message";
              isHttpEnabled = true;
              compilerOptions.snippetAutoIndent = false;
            };
          };
        };
      };
    };
}
