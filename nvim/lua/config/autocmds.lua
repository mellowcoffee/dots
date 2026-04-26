local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Highlight on yank
autocmd("TextYankPost", {
  group = augroup("highlight-yank", { clear = true }),
  callback = function() vim.highlight.on_yank() end,
})

-- Italic ampersand across colorschemes
autocmd("ColorScheme", {
  group = augroup("ampersand-italic", { clear = true }),
  callback = function()
    vim.api.nvim_set_hl(0, "Ampersand", { italic = true })
    vim.fn.matchadd("Ampersand", "&", 100)
  end,
})

-- Per-colorscheme overrides
autocmd("ColorScheme", {
  group = augroup("colorscheme-overrides", { clear = true }),
  pattern = "quiet",
  callback = function()
    vim.cmd([[
      highlight Keyword gui=bold
      highlight Comment gui=italic
      highlight Constant guifg=#999999
      highlight NormalFloat guibg=#333333
      highlight StatusLine guibg=#444444 guifg=#cccccc
      highlight StatusLineNC guibg=#333333 guifg=#777777
    ]])
  end,
})
