-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Skip Python provider checks
vim.g.python_host_skip_check = 1
vim.g.python3_host_skip_check = 1

-- Clipboard
vim.schedule(function()
  vim.opt.clipboard:append({ "unnamedplus" })
end)

-- Indentation
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.shiftround = true
vim.opt.wrap = false

-- UI
vim.opt.scrolloff = 2
vim.opt.showmode = true
vim.opt.laststatus = 0
vim.opt.showcmd = true
vim.opt.guicursor = "n:block,i:ver20,v:block"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.showmatch = true
vim.opt.signcolumn = "number"
vim.opt.winborder = "solid"

-- Search & edit
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.undofile = true
vim.opt.virtualedit = "block"

-- Terminal & rendering
vim.opt.ttyfast = true
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.mouse = "a"

-- Whitespace rendering
vim.opt.list = true
vim.opt.listchars = {
  tab = "→ ",
  extends = "›",
  precedes = "‹",
  nbsp = "␣",
}
