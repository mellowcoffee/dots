-- Statusline with mode indicator and dynamic highlight groups

local M = {}

local function hl(group)
  local h = vim.api.nvim_get_hl(0, { name = group, link = false })
  return (h and next(h)) and h or {}
end

local function set_hl_groups()
  local base = hl("StatusLine")
  local fg, bg = base.fg, base.bg

  local groups = {
    Normal  = { fg = bg, bg = fg },
    Pending = { fg = bg, bg = hl("Comment").fg },
    Visual  = { fg = bg, bg = hl("SpecialKey").fg },
    Insert  = { fg = bg, bg = hl("DiffAdded").fg },
    Command = { fg = bg, bg = hl("Number").fg },
    Replace = { fg = bg, bg = hl("Constant").fg },
    Bold    = { fg = fg, bg = bg, bold = true },
    Dim     = { fg = hl("LineNr").fg, bg = bg },
  }

  for name, opts in pairs(groups) do
    local group = "StatusLine" .. name
    vim.api.nvim_set_hl(0, group, opts)
    vim.api.nvim_set_hl(0, group .. "Inverted", {
      fg = opts.bg,
      bg = opts.fg,
      bold = opts.bold,
    })
  end
end

set_hl_groups()

-- Termcodes \19 and \22 are ^S and ^V
-- stylua: ignore
local mode_map = {
  ["n"]      = { name = "NOR",     hl = "Normal"  },
  ["no"]     = { name = "O-P",     hl = "Pending" },
  ["nov"]    = { name = "O-P",     hl = "Pending" },
  ["noV"]    = { name = "O-P",     hl = "Pending" },
  ["no\22"]  = { name = "O-P",     hl = "Pending" },
  ["niI"]    = { name = "NOR",     hl = "Normal"  },
  ["niR"]    = { name = "NOR",     hl = "Normal"  },
  ["niV"]    = { name = "NOR",     hl = "Normal"  },
  ["nt"]     = { name = "NOR",     hl = "Normal"  },
  ["ntT"]    = { name = "NOR",     hl = "Normal"  },
  ["v"]      = { name = "VIS",     hl = "Visual"  },
  ["vs"]     = { name = "VIS",     hl = "Visual"  },
  ["V"]      = { name = "V-L",     hl = "Visual"  },
  ["Vs"]     = { name = "V-L",     hl = "Visual"  },
  ["\22"]    = { name = "V-B",     hl = "Visual"  },
  ["\22s"]   = { name = "V-B",     hl = "Visual"  },
  ["s"]      = { name = "SEL",     hl = "Visual"  },
  ["S"]      = { name = "S-L",     hl = "Visual"  },
  ["\19"]    = { name = "S-B",     hl = "Visual"  },
  ["i"]      = { name = "INS",     hl = "Insert"  },
  ["ic"]     = { name = "INS",     hl = "Insert"  },
  ["ix"]     = { name = "INS",     hl = "Insert"  },
  ["R"]      = { name = "REP",     hl = "Replace" },
  ["Rc"]     = { name = "REP",     hl = "Replace" },
  ["Rx"]     = { name = "REP",     hl = "Replace" },
  ["Rv"]     = { name = "V-R",     hl = "Replace" },
  ["Rvc"]    = { name = "V-R",     hl = "Replace" },
  ["Rvx"]    = { name = "V-R",     hl = "Replace" },
  ["c"]      = { name = "CMD",     hl = "Command" },
  ["cv"]     = { name = "EX",      hl = "Command" },
  ["ce"]     = { name = "EX",      hl = "Command" },
  ["r"]      = { name = "REP",     hl = "Normal"  },
  ["rm"]     = { name = "MORE",    hl = "Normal"  },
  ["r?"]     = { name = "CONFIRM", hl = "Normal"  },
  ["!"]      = { name = "SH",      hl = "Normal"  },
  ["t"]      = { name = "TER",     hl = "Command" },
}

local function mode_component()
  local m = mode_map[vim.fn.mode()] or { name = "???", hl = "Normal" }
  local base     = "StatusLineMode" .. m.hl
  local inverted = base .. "Inverted"

  return table.concat({
    "%#StatusLineMode" .. m.hl .. "Inverted" .. "#",
    "%#StatusLineMode" .. m.hl .. "#" .. m.name,
    "%#StatusLineMode" .. m.hl .. "Inverted" .. "#",
  })

  -- return table.concat({
  --   -- ("%%#%s# %s "):format(base, m.name),
  --   ("%%#%s#"):format(inverted),
  --   "",
  --   ("%%#%s# %s "):format(base, m.name),
  --   ("%%#%s#"):format(inverted),
  --   "",
  -- })
end

function M.render()
  local current = vim.api.nvim_get_current_win()
  local target  = tonumber(vim.g.statusline_winid) or current

  if target ~= current then
    return " %f %m%=%y %l:%c %P "
  end

  return table.concat({
    mode_component(),
    " %f %m",
    "%=",
    "%y %l:%c %P ",
  })
end

vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("my_statusline", { clear = true }),
  desc = "Re-apply statusline highlights on colorscheme change",
  callback = set_hl_groups,
})

_G.statusline = M
vim.o.statusline = "%{%v:lua.statusline.render()%}"
