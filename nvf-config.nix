{ pkgs, lib, ... }:
{
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        keymaps = [
          {
            key = "<leader>1";
            mode = ["n"];
            action = ":1tabnext<CR>";
            silent = true;
            desc = "Go to first tab";
          }
          {
            key = "<leader>2";
            mode = ["n"];
            action = ":2tabnext<CR>";
            silent = true;
            desc = "Go to second tab";
          }
          {
            key = "<leader>3";
            mode = ["n"];
            action = ":3tabnext<CR>";
            silent = true;
            desc = "Go to third tab";
          }
          {
            key = "<leader>4";
            mode = ["n"];
            action = ":4tabnext<CR>";
            silent = true;
            desc = "Go to fourth tab";
          }
          {
            key = "<leader>5";
            mode = ["n"];
            action = ":5tabnext<CR>";
            silent = true;
            desc = "Go to fifth tab";
          }
          {
            key = "<leader>6";
            mode = ["n"];
            action = ":6tabnext<CR>";
            silent = true;
            desc = "Go to sixth tab";
          }
          {
            key = "<leader>7";
            mode = ["n"];
            action = ":7tabnext<CR>";
            silent = true;
            desc = "Go to seventh tab";
          }
          {
            key = "<leader>8";
            mode = ["n"];
            action = ":8tabnext<CR>";
            silent = true;
            desc = "Go to eighth tab";
          }
          {
            key = "<leader>9";
            mode = ["n"];
            action = ":9tabnext<CR>";
            silent = true;
            desc = "Go to nineth tab";
          }
          {
            key = "<leader>10";
            mode = ["n"];
            action = ":10tabnext<CR>";
            silent = true;
            desc = "Go to tenth tab";
          }
        ];
        autocmds = [
          {
            enable = true;
            command = "highlight Pmenu guibg=NONE";
            event = [ "VimEnter" ];
            desc = "Making nvim-cmp have transparent background";
          }
        ];


        lsp.enable = true;
        statusline.lualine.enable = true;
        telescope = {
          enable = true;
          setupOpts.defaults.winblend = 0;
          mappings = {
            findFiles = "<leader>ff";
          };
          extensions = [
            {
              name = "fzf";
              packages = [pkgs.vimPlugins.telescope-fzf-native-nvim];
              setup = {
                fzf = {
                  fuzzy = true;
                };
              };
            }
          ];
        };
        autopairs = {
          nvim-autopairs.enable = true;
        };
        utility = {
          oil-nvim.enable = true;
          smart-splits.enable = true;
        };
        navigation = {
          harpoon = {
            enable = true;
          };
        };
        treesitter = {
          context.enable = true;
        };
        autocomplete.nvim-cmp.enable = true;
        languages = {
          enableTreesitter = true;
          nix = {
            enable = true;
            lsp.enable = true;
            format.enable = true;
          };
          zig = {
            enable = true;
            dap.enable = true;
            lsp.enable = true;
            treesitter.enable = true;
          };
        };
        dashboard.alpha = {
          enable = true;
          theme = "dashboard";
        };


        theme = {
          enable = true;
          name = "gruvbox";
          style = "dark";
          transparent = true;
        };
        options = {
          tabstop = 2;
          shiftwidth = 2;
          pumblend = 0;
        };
      };
    }; 
  };
}
