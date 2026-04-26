local map = vim.keymap.set

-- Buffer navigation
map("n", "<S-l>", ":bnext<CR>", { desc = "Next buffer" })
map("n", "<S-h>", ":bprevious<CR>", { desc = "Previous buffer" })
map("n", "<leader>x", ":bdelete<CR>", { desc = "Close buffer" })

-- Editing
map("n", "U", "<C-r>", { desc = "Redo" })

-- Terminal
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Centered scrolling
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "{", "{zz")
map("n", "}", "}zz")

-- File explorer
map("n", "-", "<CMD>Oil<CR>", { desc = "Open Oil" })

-- Quickfix
map("n", "<C-j>", ":cnext<CR>", { desc = "Next quickfix" })
map("n", "<C-k>", ":cprev<CR>", { desc = "Previous quickfix" })

-- Hungarian layout remaps
map("n", "é", ";")
map("n", "É", ",")
map("n", "ő", "{")
map("n", "ú", "}")
map("n", "Ő", "[")
map("n", "Ú", "]")

-- Formatting
map({ "n", "v" }, "<leader>c", function()
  require("conform").format({ lsp_fallback = true, async = true, timeout_ms = 500 })
end, { desc = "Format file or range" })
