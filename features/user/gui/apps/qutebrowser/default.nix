{ config, pkgs, lib, ... }: let
  cfg = config.features.gui.apps.qutebrowser;
in {
  options.features.gui.apps.qutebrowser.enable = lib.mkEnableOption "qutebrowser";
  config = lib.mkIf cfg.enable {
    programs.qutebrowser = {
      enable = true;
      settings = {
        content = {
          autoplay = false;
          tls.certificate_errors = "ask-block-thirdparty";
        };
        scrolling.bar = "never";
        window.transparent = true;
        keyhint.delay = 0;
        tabs = {
          position = "left";
          width = "10%";
        };
        url = {
          default_page = "https://web.tabliss.io";
          start_pages = "https://web.tabliss.io";
        };
        input.insert_mode.auto_load = true;
      };
      keyBindings = {
        normal = {
          # Tab Movement Keys
          "<Ctrl-j>" = "tab-move +";
          "<Ctrl-k>" = "tab-move -";

          # Universal Scrolling Keys
          "<Alt-j>" = "scroll-px 0 50";
          "<Alt-k>" = "scroll-px 0 -50";

          # Open Tab Relatively
          "<Ctrl-o>" = "cmd-set-text -s :open -tr";

          # Move Tab to Another Window
          "gc" = "cmd-set-text -s :tab-give";

          # Hide UI
          "z" = lib.mkMerge [
            "config-cycle tabs.show never always"
            "config-cycle statusbar.show in-mode always"
            "config-cycle scrolling.bar never always"
          ];
        };
      };
      searchEngines = {
        # Default Search Engine
        DEFAULT = "https://search.brave.com/search?q={}";

        # General Search Engines
        g = "https://www.google.com/search?q={}";
        b = "https://www.bing.com/search?q={}";

        # Other Search Engines
        w = "https://en.wikipedia.org/wiki/Special:Search?search={}&amp;go=Go&amp;ns0=1";
        y = "https://youtube.com/results?search_query={}";
        t = "https://www.wordreference.com/es/translation.asp?tranword={}";
        p = "https://thangs.com/search/{}?scope=all";
        
        # Nix Search Engines
        n = "https://mynixos.com/search?q={}";
        nw = "https://wiki.nixos.org/index.php?search={}";
        np = "https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query={}";
        no = "https://search.nixos.org/options?channel=unstable&size=50&sort=relevance&type=packages&query={}";
        nh = "https://home-manager-options.extranix.com/?query={}&release=master";
      };
      greasemonkey = let
        mkGmScript = name: ( pkgs.writeText "${name}.js" (builtins.readFile ./scripts/${name}.js) );
      in [
        (mkGmScript "yt-ad-skip") 
        (mkGmScript "yt-sponsor-skip")
        (mkGmScript "yt-shorts-blocker")
        (mkGmScript "yt-dislike-viewer")
      ];
    };
  };
}
