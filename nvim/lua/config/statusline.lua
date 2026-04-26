-- Mode display helpers exposed for statusline format

local mode_names = {
  ["n"] = "NOR",
  ["no"] = "O-P",
  ["i"] = "INS",
  ["v"] = "VIS",
  ["V"] = "V-L",
  [""] = "V-B",
  ["c"] = "CMD",
  ["r"] = "REP",
  ["R"] = "REP",
  ["t"] = "TER",
}

local mode_short = {
  ["n"] = "n", ["no"] = "o", ["i"] = "i",
  ["v"] = "v", ["V"] = "v", [""] = "v",
  ["c"] = "c", ["r"] = "r", ["R"] = "r", ["t"] = "t",
}

function _G.get_mode()
  return mode_names[vim.fn.mode()] or vim.fn.mode()
end

function _G.get_mode_short()
  return mode_short[vim.fn.mode()] or vim.fn.mode()
end

vim.opt.statusline = " %{v:lua.get_mode()}  %f %m %=%y %l:%c %P "
