# No official stylix target for tridactyl.
# See: https://github.com/bezmi/base16-tridactyl
{ ... }:
{
  yoq.browser.homeManager =
    { lib, config, ... }:
    {
      options.stylix.targets.tridactyl.enable = config.lib.stylix.mkEnableTarget "Tridactyl" true;

      config = lib.mkIf (config.stylix.enable && config.stylix.targets.tridactyl.enable) (
        let
          inherit (config.lib.stylix) colors;
        in
        {
          xdg.configFile."tridactyl/themes/stylix.css".text = ''
            :root {
              --base00: ${colors.withHashtag.base00};
              --base01: ${colors.withHashtag.base01};
              --base02: ${colors.withHashtag.base02};
              --base03: ${colors.withHashtag.base03};
              --base04: ${colors.withHashtag.base04};
              --base05: ${colors.withHashtag.base05};
              --base06: ${colors.withHashtag.base06};
              --base07: ${colors.withHashtag.base07};
              --base08: ${colors.withHashtag.base08};
              --base09: ${colors.withHashtag.base09};
              --base0A: ${colors.withHashtag.base0A};
              --base0B: ${colors.withHashtag.base0B};
              --base0C: ${colors.withHashtag.base0C};
              --base0D: ${colors.withHashtag.base0D};
              --base0E: ${colors.withHashtag.base0E};
              --base0F: ${colors.withHashtag.base0F};

              --tridactyl-fg: var(--base05);
              --tridactyl-bg: var(--base00);
              --tridactyl-url-fg: var(--base0D);
              --tridactyl-url-bg: var(--base00);
              --tridactyl-highlight-box-bg: var(--base0B);
              --tridactyl-highlight-box-fg: var(--base00);

              --tridactyl-hintspan-fg: var(--base00) !important;
              --tridactyl-hintspan-bg: var(--base0A) !important;
            }

            #command-line-holder {
              border: 1px solid var(--base0B);
              color: var(--tridactyl-bg);
            }

            #tridactyl-input {
              color: var(--tridactyl-fg);
              background: var(--tridactyl-bg);
            }

            #completions {
              color: var(--tridactyl-fg);
              background: var(--tridactyl-bg);
            }

            #completions .focused,
            #completions .focused .url {
              background: var(--base0B);
              color: var(--base00);
            }

            #completions .sectionHeader {
              background: unset;
              border-bottom: unset;
            }

            .TridactylStatusIndicator {
              background: var(--tridactyl-bg) !important;
              border: 1px var(--base0B) solid !important;
            }
          '';
        }
      );
    };
}
