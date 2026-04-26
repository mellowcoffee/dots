-- Colorscheme variables (must be set before :colorscheme)

-- Gruvbox Material
vim.g.gruvbox_material_foreground = "mix"
vim.g.gruvbox_material_background = "hard"
vim.g.gruvbox_material_ui_contrast = "high"
vim.g.gruvbox_material_enable_italic = 1
vim.g.gruvbox_material_enable_bold = 0
vim.g.gruvbox_material_float_style = "blend"
vim.g.gruvbox_material_statusline_style = "original"
vim.g.gruvbox_material_cursor = "auto"
vim.g.gruvbox_material_visual = "blue background"
vim.g.gruvbox_material_diagnostic_virtual_text = "highlighted"
vim.g.gruvbox_material_diagnostic_text_highlight = 1
vim.g.gruvbox_material_diagnostic_line_highlight = 1
vim.g.gruvbox_material_colors_override = { bg0 = { "#181a1b", "234" } }

-- Ayu
vim.g.ayucolor = "mirage"

-- Everforest
vim.g.everforest_background = "hard"
vim.g.everforest_enable_italic = 1
vim.g.everforest_colors_override = { bg0 = { "#21272b", "234" } }

-- Zenbones
vim.g.zenbones = { darkness = "default" }

-- Active colorscheme
vim.schedule(function()
  vim.cmd("colorscheme melange")
end)

-- Transparency toggle
local function toggle_transparency()
  local is_transparent = vim.api.nvim_get_hl(0, { name = "Normal" }).bg == nil
  if is_transparent then
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
