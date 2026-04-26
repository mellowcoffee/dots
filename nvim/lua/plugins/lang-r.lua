return {
  {
    "R-nvim/R.nvim",
    lazy = false,
    opts = {
      R_app = "radian",
      R_cmd = "R",
      R_args = {},
      hook = {
        after_config = function()
          vim.api.nvim_buf_set_keymap(0, "n", "<leader>rf", "<Plug>RStart", {})
        end,
      },
    },
  },
}
