-- Enable experimental loader
vim.loader.enable()

require("config.options")
require("config.keymaps")
require("config.autocmds")

require("config.lazy")

-- local construct_osc_11 = function(alpha_pct, hex_color)
--     return string.format("\x1b]11;[%d]%s\x1b\\", alpha_pct, hex_color)
-- end
--
-- local construct_osc_111 = function()
--     return "\x1b]111\x1b\\"
-- end
--
-- local apply_opacity = function(is_opaque)
--     return function()
--         if is_opaque then
--             local bg = vim.fn.synIDattr(vim.fn.hlID("Normal"), "bg#")
--             local target_color = (bg == "" or bg == "none") and "#000000" or bg
--             io.stderr:write(construct_osc_11(100, target_color))
--         else
--             io.stderr:write(construct_osc_111())
--         end
--     end
-- end
--
-- local augroup = vim.api.nvim_create_augroup("FootAlphaOverride", { clear = true })
--
-- vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
--     group = augroup,
--     callback = apply_opacity(true),
-- })
--
-- vim.api.nvim_create_autocmd("VimLeave", {
--     group = augroup,
--     callback = apply_opacity(false),
-- })
