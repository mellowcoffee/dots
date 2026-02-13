--- LSP, COMPLETION, TREESITTER & FORMATTING ---

return {
  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = { "Saghen/blink.cmp" },
    -- event = { "BufReadPost", "BufNewFile" },
    -- cmd = { "LspInfo", "LspInstall", "LspUninstall" },
    opts = {
      servers = {
        hls = {},
        rust_analyzer = {},
        texlab = {},
        emmet_ls = {},
        marksman = {},
        gleam = {},
        basedpyright = {},
      }
    },
    config = function(_, opts)
      -- Setup capabilities from blink.cmp
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      vim.lsp.config["clangd"] = {
        cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=llvm"
        },
        init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
        },
      }
      vim.lsp.config["lua_ls"] = {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" }
            }
          }
        }
      }
      vim.lsp.config["bashls"] = {
        settings = {
          filetypes = { "sh", "zsh" }
        }
      }

      -- Enable servers
      vim.lsp.enable('hls')
      vim.lsp.enable('rust_analyzer')
      vim.lsp.enable('texlab')
      vim.lsp.enable('emmet_ls')
      vim.lsp.enable('marksman')
      vim.lsp.enable('gleam')
      vim.lsp.enable('basedpyright')
      vim.lsp.enable('julials')
      vim.lsp.enable('ocamllsp')
      vim.lsp.enable('clangd')
      vim.lsp.enable('zls')
      vim.lsp.enable('lua_ls')
      -- vim.lsp.enable('bashls')
      vim.lsp.enable('marksman')

      -- Global Coq path
      vim.g.coqtail_coq_path = "/usr/bin"

      -- LspAttach Autocommand
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

          local opts = function(str)
            return { buffer = ev.buf, desc = str }
          end

          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts("Goto declaration"))
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts("Goto definition"))
          vim.keymap.set('n', '<M-k>', vim.lsp.buf.signature_help, opts("Signature help"))
          vim.keymap.set('i', '<M-k>', vim.lsp.buf.signature_help, opts("Signature help"))
        end,
      })

      -- Emmet setup
      vim.api.nvim_create_autocmd({ "FileType" }, {
        pattern = "css,eruby,html,htmldjango,javascriptreact,less,pug,sass,scss,typescriptreact",
        callback = function()
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
        end,
      })
    end
  },

  -- VimTeX
  {
    "lervag/vimtex",
    ft = "tex",
    init = function()
      vim.g.vimtex_view_method = "zathura"
    end
  },

  -- Blink.cmp
  {
    'saghen/blink.cmp',
    version = '1.4.1',
    event = 'InsertEnter',
    opts = {
      keymap = { preset = 'default' },
      appearance = {
        nerd_font_variant = 'normal'
      },
      signature = { enabled = true },
      completion = {
        trigger = {
          show_on_keyword = true,
        },
        documentation = { auto_show = false },
        menu = {
          border = "none",
          draw = {
            columns = {
              { "label", "label_description", gap = 1 }, { "kind_icon", "kind" }
            }
          }
        },
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        per_filetype = {
          org = { 'orgmode' }
        },
        providers = {
          orgmode = {
            name = 'Orgmode',
            module = 'orgmode.org.autocompletion.blink',
            fallbacks = { 'buffer' },
          },
        },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
  },

  -- Tree-sitter
  {
    "nvim-treesitter/nvim-treesitter",
    branch = 'master',
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require 'nvim-treesitter.configs'.setup {
        ensure_installed = { "haskell", "rust", "elixir", "ocaml", "python", "lua", "c", "gleam" },
        indent = {
          enable = true
        },
        highlight = {
          enable = true
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<M-o>",
            scope_incremental = "<M-O>",
            node_incremental = "<M-o>",
            node_decremental = "<M-i>",
          },
        },
      }
    end
  },

  -- Coqtail
  {
    'whonore/Coqtail',
    -- ft = "v"
  },

  -- Inline diagnostics
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    config = function()
      require("tiny-inline-diagnostic").setup({
        preset = "classic",
        options = {
          add_messages = {
            display_count = true,
          },
          multilines = {
            enabled = true,
          },
        },
      })
      vim.diagnostic.config({ virtual_text = false }) -- Disable Neovim's default virtual text diagnostics
    end,
  },

  -- Formatting (Conform)
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        rust = { "rustfmt", lsp_format = "fallback" },
        css = { "prettier" },
        html = { "prettier" },
      },
    },
  },

  -- Markdown rendering
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },            -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  }
  -- {
  --   "OXY2DEV/markview.nvim",
  --   lazy = false,
  --   dependencies = { "saghen/blink.cmp" },
  --   opts = {
  --     asciidoc = {
  --       enable = true
  --     },
  --     latex = {
  --       enable = true,
  --       texts = {
  --         enable = true,
  --       },
  --       symbols = {
  --         enable = true,
  --
  --         hl = "MarkviewComment"
  --       },
  --     }
  --   }
  -- },
}
