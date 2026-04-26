return {
  -- Completion engine
  {
    "saghen/blink.cmp",
    version = "1.4.1",
    event = "InsertEnter",
    dependencies = { "L3MON4D3/LuaSnip", version = "v2.*" },
    opts = {
      keymap = { preset = "default" },
      appearance = { nerd_font_variant = "normal" },
      signature = { enabled = true },
      completion = {
        trigger = { show_on_keyword = true },
        documentation = { auto_show = false },
        menu = {
          border = "none",
          draw = {
            columns = {
              { "label", "label_description", gap = 1 },
              { "kind_icon", "kind" },
            },
          },
        },
      },
      sources = {
        default = { "snippets", "lsp", "path", "buffer" },
        per_filetype = { org = { "orgmode" } },
        providers = {
          orgmode = {
            name = "Orgmode",
            module = "orgmode.org.autocompletion.blink",
            fallbacks = { "buffer" },
          },
        },
      },
      snippets = { preset = "luasnip" },
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
  },

  -- Snippet engine
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    config = function()
      require("luasnip.loaders.from_lua").load({
        paths = { vim.fn.stdpath("config") .. "/lua/snippets" },
      })
    end,
  },
}
