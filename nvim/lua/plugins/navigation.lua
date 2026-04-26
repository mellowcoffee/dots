return {
  -- Label-based motion
  {
    "folke/flash.nvim",
    event = "BufReadPost",
    opts = {
      modes = { char = { enabled = false } },
    },
    keys = {
      { "<leader>s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    },
  },

  -- Keybinding hints
  {
    "folke/which-key.nvim",
    event = "VimEnter",
    opts = {
      preset = "helix",
      win = { border = "single" },
    },
    keys = {
      {
        "<leader>?",
        function() require("which-key").show({ global = false }) end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },

  -- File explorer
  {
    "stevearc/oil.nvim",
    lazy = false,
    dependencies = { { "nvim-mini/mini.icons", opts = {} } },
    opts = {
      default_file_explorer = true,
      skip_confirm_for_simple_edits = true,
      constrain_cursor = "name",
      delete_to_trash = true,
      watch_for_changes = true,
      columns = { "permissions", "size", "mtime", "icon" },
      float = { border = "single" },
      keymaps_help = { border = "single" },
      view_options = { show_hidden = true },
    },
  },
}
