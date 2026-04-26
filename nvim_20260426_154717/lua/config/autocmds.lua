--- AUTOCOMMANDS ---

local autocmd = vim.api.nvim_create_autocmd

-- Highlight when yanking text
autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Correct Gleam comment string
autocmd("FileType", {
  pattern = "gleam",
  callback = function()
    vim.bo.commentstring = "// %s"
  end,
})

-- ColorScheme Overrides
autocmd("ColorScheme", {
  pattern = "quiet",
  callback = function()
    vim.cmd [[
      highlight Keyword gui=bold
      highlight Comment gui=italic
      highlight Constant guifg=#999999
      highlight NormalFloat guibg=#333333
      highlight StatusLine guibg=#444444 guifg=#cccccc
      highlight StatusLineNC guibg=#333333 guifg=#777777
    ]]
  end,
})

autocmd("ColorScheme", {
  callback = function()
    vim.api.nvim_set_hl(0, 'Ampersand', { italic = true })
    vim.fn.matchadd('Ampersand', '&', 100)
  end,
})
