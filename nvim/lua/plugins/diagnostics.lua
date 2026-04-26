return {
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    config = function()
      require("tiny-inline-diagnostic").setup({
        preset = "classic",
        options = {
          add_messages = { display_count = true },
          multilines = { enabled = true },
        },
      })
      vim.diagnostic.config({ virtual_text = false })
    end,
  },
}
