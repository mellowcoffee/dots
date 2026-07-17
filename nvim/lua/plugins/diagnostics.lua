return {
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    config = function()
      require("tiny-inline-diagnostic").setup({
        preset = "classic",
        -- transparent_bg = true,
        options = {
          add_messages = { display_count = true },
          multilines = { enabled = true },
          show_source = { if_many = true },
        },
      })
      vim.diagnostic.config({ virtual_text = false })
    end,
  },
}
