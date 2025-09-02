{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.features.cli.apps.helix;
in {
  options.features.cli.apps.helix.enable = lib.mkEnableOption "helix";
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      wl-clipboard
    ];
    programs.helix = {
      enable = true;
      extraPackages = with pkgs; [
        markdown-oxide
        python312Packages.black
        vscode-langservers-extracted
        nil
      ];
      settings = {
        editor = {
          color-modes = true;
          true-color = true;
          line-number = "relative";
          mouse = false;
          lsp.display-messages = true;
          statusline = {
            left = ["file-name" "file-modification-indicator"];
            center = [];
            right = [];
            mode = {
              normal = "NORMAL";
              insert = "INSERT";
              select = "SELECT";
            };
          };
          cursor-shape = {
            normal = "block";
            insert = "bar";
            select = "underline";
          };
          soft-wrap = {
            enable = true;
            wrap-indicator = "";
          };
        };
        keys = {
          normal = {
            esc = ["collapse_selection" "keep_primary_selection"];
            space = {
              v = "file_picker_in_current_buffer_directory";
              h = ":lsp-workspace-command";
            };
          };
        };
      };
      languages = {
        language = [
          {
            name = "nix";
            auto-format = true;
            formatter.command = "${pkgs.alejandra}/bin/alejandra";
            language-servers = ["nil"];
          }
        ];
      };
    };
  };
}
