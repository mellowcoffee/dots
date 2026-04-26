return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        rust = { "rustfmt", lsp_format = "fallback" },
        css = { "prettier" },
        html = { "prettier" },
      },
    },
  },
}
