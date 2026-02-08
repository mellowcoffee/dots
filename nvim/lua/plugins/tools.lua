--- TOOLS, UTILITIES & UI COMPONENTS ---

return {
  -- Mini.nvim
  {
    'echasnovski/mini.nvim',
    version = '*',
    event = "WinEnter",
    config = function()
      require 'mini.pairs'.setup()
      require 'mini.surround'.setup()
      require 'mini.snippets'.setup()
      require 'mini.align'.setup()
    end
  },

  -- Snacks.nvim
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      picker = {
        enabled = true,
        matcher = {
          fuzzy = true,
          smart_case = true,
        },
        reverse = true,
        layout = {
          cycle = false,
        },
        win = {
          preview = {
            minimal = true,
          }
        }
      },
      quickfile = {},
    },
    keys = {
      { "<leader>fp", function() require("snacks").picker.pickers() end, desc = "Snacks: Find picker" },
      { "<leader>ff", function() require("snacks").picker.files() end, desc = "Snacks: Find files" },
      { "<leader>fg", function() require("snacks").picker.grep() end, desc = "Snacks: Live grep" },
      { "<leader>fd", function() require("snacks").picker.diagnostics() end, desc = "Snacks: Diagnostics" },
      { "<leader>fs", function() require("snacks").picker.lines({ layout = "select" }) end, desc = "Snacks: Search buffer lines" },
      { "<leader>fh", function() require("snacks").picker.help() end, desc = "Snacks: Help tags" },
      { "<leader>ft", function() require("snacks").picker.colorschemes({ layout = "dropdown" }) end, desc = "Snacks: Change theme" },
      { "<leader>fm", function() require("snacks").picker.marks() end, desc = "Snacks: Find marks" },
      { "<leader>fl", function() require("snacks").picker.lsp_symbols() end, desc = "Snacks: Find LSP symbols" },
      { "<leader>fj", function() require("snacks").picker.jumps() end, desc = "Snacks: Jumplist" },
      { "<leader>fb", function() require("snacks").picker.buffers() end, desc = "Snacks: Find buffers" },
      { "<leader>fc", function() require("snacks").picker.files({ cwd = vim.fn.stdpath("config"), layout = "vscode" }) end, desc = "Snacks: Find config files" },
      { "<leader>fr", function() require("snacks").picker.lsp_references() end, desc = "Snacks: Goto references" },
      { "<leader><leader>", function() require("snacks").picker.resume() end, desc = "Snacks: Show last picker" },
    }
  },

  -- Typing practice
  {
    "nvzone/typr",
    lazy = true,
    dependencies = "nvzone/volt",
    opts = {},
    cmd = { "Typr", "TyprStats" },
  },

  -- Blends terminal background
  { "typicode/bg.nvim", lazy = false },

  -- Flash (Jump to label)
  {
    "folke/flash.nvim",
    event = "BufReadPost",
    opts = {
      modes = {
        char = {
          enabled = false
        }
      }
    },
    keys = {
      { "<leader>s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    },
  },

  -- Which-Key
  {
    "folke/which-key.nvim",
    event = "VimEnter",
    opts = {
      preset = "helix",
      win = {
        border = "single"
      }
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },

  -- Oil (Dired-style file management)
  {
    'stevearc/oil.nvim',
    lazy = false,
    dependencies = { { "nvim-mini/mini.icons", opts = {} } },
    opts = {
      constrain_cursor = "name",
      delete_to_trash = true,
      columns = {
        "permissions",
        "size",
        "mtime",
        "icon",
      },
      float = {
        border = "single",
      },
      keymaps_help = {
        border = "single",
      },
      view_options = {
        show_hidden = true
      }
    },
  },

  -- Notifications
  {
    "j-hui/fidget.nvim",
    opts = {
      window = {
        max_width = 40
      }
    }
  },

  -- Git Signs
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require "gitsigns".setup {
        signcolumn = false,
        numhl = true,
      }
    end
  },

  -- Discord Presence
  {
    'IogaMaster/neocord',
    event = "VeryLazy",
    config = function()
      require("neocord").setup({
        logo                = nil,
        logo_tooltip        = nil,
        main_image          = "language",
        log_level           = nil,
        debounce_timeout    = 10,
        blacklist           = {},
        file_assets         = {},
        show_time           = true,
        global_timer        = false,
        buttons             = nil,
        editing_text        = "Editing %s",
        file_explorer_text  = "Browsing %s",
        git_commit_text     = "Committing changes",
        plugin_manager_text = "Managing plugins",
        reading_text        = "Reading %s",
        workspace_text      = "Working on %s",
        line_number_text    = "Line %s out of %s",
        terminal_text       = "Using Terminal",
      })
    end
  },

  -- Lualine
  -- {
  --   'nvim-lualine/lualine.nvim',
  --   config = function()
  --     -- require'lualine'.setup{ ... }
  --   end
  -- }
}
