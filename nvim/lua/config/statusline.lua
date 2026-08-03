local M = {}

local mode_labels = {
  n = "NOR", i = "INS", v = "SEL", V = "SEL", ["\22"] = "SEL",
  c = "NOR", R = "INS", t = "INS", s = "SEL", S = "SEL",
}

local function mode()
  return mode_labels[vim.api.nvim_get_mode().mode] or "NOR"
end

local function filename()
  local name = vim.fn.expand("%:t")
  if name == "" then name = "[scratch]" end
  local flags = (vim.bo.modified and " [+]" or "") .. (vim.bo.readonly and " [RO]" or "")
  return name .. flags
end

local function diagnostics()
  local sev = vim.diagnostic.severity
  local parts = {}
  for _, l in ipairs({ { sev.ERROR, "E" }, { sev.WARN, "W" }, { sev.INFO, "I" }, { sev.HINT, "H" } }) do
    local n = #vim.diagnostic.get(0, { severity = l[1] })
    if n > 0 then parts[#parts + 1] = l[2] .. n end
  end
  return table.concat(parts, " ")
end

local function fileinfo()
  local enc = vim.bo.fileencoding ~= "" and vim.bo.fileencoding or vim.o.encoding
  local ft = vim.bo.filetype ~= "" and vim.bo.filetype or "text"
  return enc .. "  " .. ft
end

function M.render()
  return table.concat({
    " ", mode(), "  ", filename(), "  ", diagnostics(),
    "%=",
    fileinfo(), "  ", "%l:%c", "  ", "%P", " ",
  })
end

-- _G.statusline = M
-- vim.o.statusline = "%!v:lua.statusline.render()"
