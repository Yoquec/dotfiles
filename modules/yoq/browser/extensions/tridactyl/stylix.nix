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
              --tridactyl-url-fg: var(--base08);
              --tridactyl-url-bg: var(--base00);
              --tridactyl-highlight-box-bg: var(--base0B);
              --tridactyl-highlight-box-fg: var(--base00);

              --tridactyl-hintspan-fg: var(--base00) !important;
              --tridactyl-hintspan-bg: var(--base0A) !important;

              --tridactyl-hint-active-fg: none;
              --tridactyl-hint-active-bg: none;
              --tridactyl-hint-active-outline: none;
              --tridactyl-hint-bg: none;
              --tridactyl-hint-outline: none;
            }

            #command-line-holder {
              order: 1;
              border: 2px solid var(--base0B);
              color: var(--tridactyl-bg);
            }

            #tridactyl-input {
              padding: 1rem;
              color: var(--tridactyl-fg);
              width: 90%;
              font-size: 1.5rem;
              line-height: 1.5;
              background: var(--tridactyl-bg);
            }

            #completions {
              --option-height: 1.4em;
              color: var(--tridactyl-fg);
              background: var(--tridactyl-bg);
              display: inline-block;
              font-size: unset;
              font-weight: 200;
              overflow: hidden;
              width: 100%;
              border-top: unset;
              order: 2;
            }

            #completions .focused,
            #completions .focused .url {
              background: var(--base0B);
              color: var(--base00);
            }

            #cmdline_iframe {
              position: fixed !important;
              bottom: unset;
              top: 25% !important;
              left: 10% !important;
              z-index: 2147483647 !important;
              width: 80% !important;
              box-shadow: rgba(0, 0, 0, 0.5) 0px 0px 20px !important;
            }

            .TridactylStatusIndicator {
              position: fixed !important;
              bottom: 0 !important;
              background: var(--tridactyl-bg) !important;
              border: 1px var(--base0B) solid !important;
              font-size: 12pt !important;
              padding: 0.8ex !important;
            }
          '';
        }
      );
    };
}
