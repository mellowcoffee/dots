-- Server-specific configuration overrides
local server_configs = {
  rust_analyzer = {
    check = {
      command = "clippy",
    },
  },
  hls = {
    filetypes = { 'haskell', 'lhaskell', 'cabal' },
    settings = {
      haskell = {
        formattingProvider = 'fourmolu',
      },
    },
  },
  clangd = {
    cmd = {
      "clangd",
      "--background-index",
      "--clang-tidy",
      "--header-insertion=iwyu",
      "--completion-style=detailed",
      "--function-arg-placeholders",
      "--fallback-style=llvm",
    },
    init_options = {
      usePlaceholders = true,
      completeUnimported = true,
      clangdFileStatus = true,
    },
  },
  lua_ls = {
    settings = {
      Lua = { diagnostics = { globals = { "vim" } } },
    },
  },
}

-- Servers enabled at startup
local enabled_servers = {
  "bashls",
  "clangd",
  "emmet_ls",
  "gleam",
  "hls",
  "julials",
  "lua_ls",
  "marksman",
  "ocamllsp",
  "rust_analyzer",
  "tinymist",
  "ty",
  "zls",
}

-- LspAttach buffer-local keymaps
local function on_attach(ev)
  vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

  local function opts(desc) return { buffer = ev.buf, desc = desc } end
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts("Goto declaration"))
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts("Goto definition"))
  vim.keymap.set("n", "<M-k>", vim.lsp.buf.signature_help, opts("Signature help"))
  vim.keymap.set("i", "<M-k>", vim.lsp.buf.signature_help, opts("Signature help"))
end

-- Standalone Emmet for non-LSP-style filetypes
local function emmet_attach()
  vim.lsp.start({
    cmd = { "emmet-language-server", "--stdio" },
    root_dir = vim.fs.dirname(vim.fs.find({ ".git" }, { upward = true })[1]),
    init_options = {
      includeLanguages = {},
      excludeLanguages = {},
      extensionsPath = {},
      preferences = {},
      showAbbreviationSuggestions = true,
      showExpandedAbbreviation = "always",
      showSuggestionsAsSnippets = false,
      syntaxProfiles = {},
      variables = {},
    },
  })
end

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "Saghen/blink.cmp" },
    config = function()
      for name, cfg in pairs(server_configs) do
        vim.lsp.config[name] = cfg
      end

      for _, name in ipairs(enabled_servers) do
        vim.lsp.enable(name)
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = on_attach,
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "css,eruby,html,htmldjango,javascriptreact,less,pug,sass,scss,typescriptreact",
        callback = emmet_attach,
      })
    end,
  },
}
