--- COLORSCHEMES & THEMES ---

return {
  -- { "RRethy/base16-nvim" },
  { "webhooked/kanso.nvim", },
  { "sainnhe/gruvbox-material", },
  { "xero/miasma.nvim", },
  { "folke/tokyonight.nvim", },
  { "catppuccin/nvim", },
  { "ptdewey/darkearth-nvim", },
  { "WTFox/jellybeans.nvim",
    opts = {
      bold = false
    }
  },
  { "savq/melange-nvim", },
  { "mellow-theme/mellow.nvim", },
  { "ramojus/mellifluous.nvim", },
  { "sainnhe/everforest", },
  { "rakr/vim-two-firewatch", },
  { "gmr458/cold.nvim", },
  { "vv9k/bogster", },
  { "zenbones-theme/zenbones.nvim",
    dependencies = "rktjmp/lush.nvim",
    priority = 1000,
  },
  { 'ayu-theme/ayu-vim', },
  { 'lucasadelino/conifer.nvim', },
  { 'Mofiqul/vscode.nvim', },
  { "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = true,
    opts = {
      contrast = "hard",
      italic = {
        strings = true,
        emphasis = false,
        comments = true,
        operators = false,
        folds = true,
      }
    }
  },
  { "everviolet/nvim",
    name = "evergarden",
  },
  { "rebelot/kanagawa.nvim", },
  { "jaredgorski/fogbell.vim", },
  { "datsfilipe/vesper.nvim", },
  { "YorickPeterse/Autumn.vim", },
  { "blazkowolf/gruber-darker.nvim", },
}
