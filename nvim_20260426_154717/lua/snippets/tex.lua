local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

return {
  s({trig = "beg"}, fmta(
    [[
    \begin{<>}
        <>
    \end{<>}
    ]],
    { i(1), i(0), require('luasnip.extras').rep(1) }
  )),
}
