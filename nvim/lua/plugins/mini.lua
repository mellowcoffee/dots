-- mini.nvim
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
      require("mini.files").setup()

      vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesWindowOpen',
        callback = function(args)
          local win_id = args.data.win_id

          -- vim.wo[win_id].winblend = 50
          local config = vim.api.nvim_win_get_config(win_id)
          config.border = "single"
          vim.api.nvim_win_set_config(win_id, config)
        end,
      })
    end,
  },
}
