--- GLOBAL OPTIONS & SETTINGS ---

-- Globals
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Python Host
vim.g.python_host_skip_check = 1
vim.g.python3_host_skip_check = 1

-- Clipboard config
vim.schedule(function()
  vim.opt.clipboard:append { 'unnamedplus' }
end)

-- Indentation settings
vim.opt.autoindent = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.shiftround = true
vim.opt.expandtab = true -- Use spaces for tabs
vim.opt.wrap = false

-- UI & Layout
vim.opt.scrolloff = 2 -- Leave an amount of lines of buffer below the cursor when scrolling
vim.opt.showmode = true
vim.opt.laststatus = 0 -- Hide statusline
-- vim.opt.showmode = false
-- vim.opt.laststatus = 2 -- Show statusline
vim.opt.guicursor = "n:block,i:ver20,v:block" -- Helps differentiate between modes by the cursor's appearance
vim.opt.showcmd = true                        -- Shows partial commands on the bottom of the screen
vim.opt.number = true                         -- Show current line number
vim.opt.relativenumber = true                 -- Show relative line numbers
vim.opt.cursorline = true                     -- Highlight current line
vim.opt.showmatch = true                      -- Show matching brackets
vim.opt.signcolumn = 'number'                 -- Put error markers in the line number column
vim.opt.winborder = "solid"

-- Search & Edit
vim.opt.backspace = { 'indent', 'eol', 'start' } -- Intuitive backspace behavior
vim.opt.hlsearch = false                         -- Turns off highlighting during search
vim.opt.ignorecase = true                        -- Requirement for the next line
vim.opt.smartcase = true                         -- Lowercase searches are case-insensitive, uppercase ones are case-sensitive
vim.opt.undofile = true

-- Optimization & Compatibility
vim.opt.ttyfast = true
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.mouse = "a"

-- List Chars
vim.opt.list = true
vim.opt.listchars = {
  tab = "→ ",      -- visible tab (▸ + space)
  extends = "›",   -- > at line end when line continues
  precedes = "‹",  -- < at line start when line continues
  nbsp = "␣",      -- non-breaking space
  -- trail = "~",  -- trailing spaces
  -- eol = "~",    -- end-of-line marker
  -- eol = "↴",    -- end-of-line marker
  -- space = "·",  -- show regular spaces (optional)
}

--- THEME VARIABLES (PRE-LOAD) ---

-- Gruvbox Material
-- vim.g.gruvbox_material_foreground='original'
-- vim.g.gruvbox_material_foreground='mix'
vim.g.gruvbox_material_foreground = 'material'
vim.g.gruvbox_material_background = 'hard'
-- vim.g.gruvbox_material_background='medium'
vim.g.gruvbox_material_ui_contrast = 'high'
vim.g.gruvbox_material_enable_italic = 1
vim.g.gruvbox_material_float_style = "blend"
vim.g.gruvbox_material_statusline_style = "mix"
vim.g.gruvbox_material_cursor = "auto"
vim.g.gruvbox_material_visual = "blue background"
-- vim.g.gruvbox_material_transparent_background = 1
vim.g.gruvbox_material_enable_bold = 0
vim.g.gruvbox_material_diagnostic_virtual_text = 'highlighted'
vim.g.gruvbox_material_statusline_style = 'original'
vim.g.gruvbox_material_diagnostic_text_highlight = 1
vim.g.gruvbox_material_diagnostic_line_highlight = 1
-- vim.g.gruvbox_material_colors_override={ bg0 = {"#11111A", "234"}, bg1 = {"#181825", "234"} }
-- vim.g.gruvbox_material_colors_override={ bg0 = {"#181a1b", "234"} }
-- vim.g.gruvbox_material_colors_override={ bg0 = {"#101114", "234"} }
-- vim.g.gruvbox_material_colors_override={ bg0 = {"#151515", "234"} }

-- Ayu
vim.g.ayucolor = "mirage"

-- Everforest
vim.g.everforest_background = "hard"
vim.g.everforest_enable_italic = 1
vim.g.everforest_colors_override = { bg0 = { "#21272b", "234" } }

-- Zenbones
vim.g.zenbones = {
  darkness = "default",
  -- darkness = "stark", -- Duplicate key in original config, second one wins
}

--- STATUSLINE CONFIGURATION ---

function _G.get_mode()
  local modes = {
    ['n'] = 'NOR',
    ['no'] = "O-P",
    ['i'] = 'INS',
    ['v'] = 'VIS',
    ['V'] = 'V-L',
    [''] = 'V-B',
    ['c'] = 'CMD',
    ['r'] = 'REP',
    ['R'] = 'REP',
    ['t'] = 'TER'
  }
  return modes[vim.fn.mode()] or vim.fn.mode()
end

function _G.get_mode_short()
  local modes = {
    ['n'] = 'n',
    ['no'] = "o",
    ['i'] = 'i',
    ['v'] = 'v',
    ['V'] = 'v',
    [''] = 'v',
    ['c'] = 'c',
    ['r'] = 'r',
    ['R'] = 'r',
    ['t'] = 't'
  }
  return modes[vim.fn.mode()] or vim.fn.mode()
end

-- vim.opt.statusline = ' %f %m %=%y %l:%c %P '
vim.opt.statusline = ' %{v:lua.get_mode()}  %f %m %=%y %l:%c %P '
-- vim.opt.statusline = ' %{v:lua.get_mode()} │ %f %m %=%y │ %l:%c '
-- vim.opt.statusline = ' %{v:lua.get_mode_short()} | %f %m %=%y %l:%c %P '

--- ACTIVE COLORSCHEME ---

vim.schedule(function()
  vim.cmd("colorscheme gruvbox-material")
end)
