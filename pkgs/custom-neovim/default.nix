{
  pkgs,
  inputs,
}: let
  git-plugins = import ./git-plugins.nix {inherit pkgs;};
in
  inputs.mnw.lib.wrap pkgs {
    neovim = pkgs.neovim-unwrapped;
    plugins = with pkgs.vimPlugins; {
      dev.config = {
        pure = ./config;
      };
      start = [
        # Core Plugins
        mini-nvim # Ton of small modules.
        nvim-lspconfig # Adds lsp presets.
        actions-preview-nvim # Adds a selector for LSP actions.
        nvim-treesitter.withAllGrammars # All treesitter grammars.
        snacks-nvim # Many small modules.
        auto-session # Automatic session manager.
        nvim-ts-autotag # Autopair HTML tags.
        gitsigns-nvim # Git signcolumn.
        git-plugins.namu-nvim-git # LSP and colorscheme picker.
        vim-nix # Indenting for nix files.
        comment-nvim # Advanced commenting.
        fidget-nvim # Simple notification UI
        focus-nvim # Automatic split resizer and manager.
        render-markdown-nvim # Render markdown fancily.
        incline-nvim # Puts the filename in the winbar.

        git-plugins.profile-nvim-git

        # Completion
        nvim-cmp # Completer.
        cmp-buffer
        cmp-path
        cmp_luasnip
        cmp-nvim-lsp
        luasnip # Snippet manager.
        friendly-snippets # Snippet collection.

        # Colorschemes
        oxocarbon-nvim # IBM Carbon themes.
        rose-pine # Rose Pine themes.
        kanagawa-nvim # Kanagawa inspired themes.
        everforest # Green themes.
        nordic-nvim # Cool dark nordic theme.
        tokyonight-nvim
        nightfox-nvim # Varied colorscheme collection.

        # Miscellaneous Plugins
        presence-nvim # Discord RPC for nvim.
        cellular-automaton-nvim # Fun useless plugin.
        vim-wakatime # For hack club challenge.
        hardtime-nvim # Break bad vim habits.
      ];
      opt = [];
    };

    luaFiles = [./config/init.lua];

    extraBinPath = with pkgs; [
      # LSP Servers
      lua-language-server # Lua LS
      nixd # Nix LS
      nil
      marksman # Markdown LS

      # Formatters
      alejandra # Nix Formatter

      # Extra Tools
      ripgrep
      fd
      cliphist
      lazygit

      # Temporary
      wakatime-cli
    ];
  }
