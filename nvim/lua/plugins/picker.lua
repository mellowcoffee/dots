local function pick(name, args)
  return function() require("snacks").picker[name](args) end
end

return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      picker = {
        enabled = true,
        matcher = { fuzzy = true, smart_case = true },
        reverse = true,
        layout = { cycle = false },
        win = { preview = { minimal = true } },
      },
      quickfile = {},
    },
    keys = {
      { "<leader>fp", pick("pickers"),                                                        desc = "Snacks: Find picker" },
      { "<leader>ff", pick("files"),                                                          desc = "Snacks: Find files" },
      { "<leader>fg", pick("grep"),                                                           desc = "Snacks: Live grep" },
      { "<leader>fd", pick("diagnostics"),                                                    desc = "Snacks: Diagnostics" },
      { "<leader>fs", pick("lines", { layout = "select" }),                                   desc = "Snacks: Search buffer lines" },
      { "<leader>fh", pick("help"),                                                           desc = "Snacks: Help tags" },
      { "<leader>ft", pick("colorschemes", { layout = "dropdown" }),                          desc = "Snacks: Change theme" },
      { "<leader>fm", pick("marks"),                                                          desc = "Snacks: Find marks" },
      { "<leader>fl", pick("lsp_symbols"),                                                    desc = "Snacks: Find LSP symbols" },
      { "<leader>fj", pick("jumps"),                                                          desc = "Snacks: Jumplist" },
      { "<leader>fb", pick("buffers"),                                                        desc = "Snacks: Find buffers" },
      { "<leader>fc", pick("files", { cwd = vim.fn.stdpath("config"), layout = "vscode" }),   desc = "Snacks: Find config files" },
      { "<leader>fr", pick("lsp_references"),                                                 desc = "Snacks: Goto references" },
      { "<leader><leader>", pick("resume"),                                                   desc = "Snacks: Show last picker" },
    },
  },
}
