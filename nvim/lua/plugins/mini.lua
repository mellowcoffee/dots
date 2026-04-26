return {
  {
    "echasnovski/mini.nvim",
    version = "*",
    event = "WinEnter",
    config = function()
      require("mini.pairs").setup()
      require("mini.surround").setup()
      require("mini.snippets").setup()
      require("mini.align").setup()
    end,
  },
}
