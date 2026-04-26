--- GENERAL KEYMAPS ---

-- Buffer Navigation
vim.keymap.set('n', '<S-l>', ':bnext<CR>', { desc = "Next buffer" })
vim.keymap.set('n', '<S-h>', ':bprevious<CR>', { desc = "Previous buffer" })
vim.keymap.set('n', '<leader>x', ':bdelete<CR>', { desc = "Close buffer" })

-- Editing
vim.keymap.set('n', 'U', '<C-r>')

-- Terminal
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>') -- Exit terminal mode by hitting escape twice

-- Scrolling & Centering
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '{', '{zz')
vim.keymap.set('n', '}', '}zz')

-- Tools
vim.keymap.set('n', '-', '<CMD>Oil<CR>')

-- Quickfix list navigation
vim.keymap.set('n', '<C-j>', ':cnext<CR>')
vim.keymap.set('n', '<C-k>', ':cprev<CR>')

-- Hungarian layout fixes
vim.keymap.set('n', 'é', ';')
vim.keymap.set('n', 'É', ',')
vim.keymap.set('n', 'ő', '{')
vim.keymap.set('n', 'ú', '}')
vim.keymap.set('n', 'Ő', '[')
vim.keymap.set('n', 'Ú', ']')

-- Formatting
vim.keymap.set({ "n", "v" }, "<leader>c", function()
  require("conform").format({
    lsp_fallback = true,
    async = true,
    timeout_ms = 500,
  })
end, { desc = "Format file or range" })

-- Transparency toggle
local function toggle_transparency()
  local is_transparent = vim.api.nvim_get_hl(0, { name = "Normal" }).bg == nil

  if is_transparent then
    -- Restore original background
    vim.cmd("colorscheme " .. vim.g.colors_name)
  else
    local groups = { "Normal", "NormalFloat", "NormalNC", "SignColumn", "LineNr" }
    for _, group in ipairs(groups) do
      vim.api.nvim_set_hl(0, group, { bg = "none", ctermbg = "none" })
    end
    vim.api.nvim_set_hl(0, "CursorLine", { bg = "#2a2a2a", blend = 21 })
  end
end

vim.keymap.set("n", "<leader>gt", toggle_transparency, { desc = "Toggle transparent background" })
