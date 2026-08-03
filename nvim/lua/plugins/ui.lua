-- Plugins that are related to informative or cosmetic display of elements
return {
    -- LSP progress / notifications
    {
        "j-hui/fidget.nvim",
        opts = {
            window = { max_width = 40 },
        },
    },

    -- Keybinding hints
    {
        "folke/which-key.nvim",
        event = "VimEnter",
        opts = {
            preset = "helix",
            win = { border = "single" },
        },
        keys = {
            {
                "<leader>?",
                function() require("which-key").show({ global = false }) end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    },

    -- Sync terminal background with editor
    {
        "typicode/bg.nvim", lazy = false
    },

    -- Render Markdown
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' }, -- if you use the mini.nvim suite
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {},
    },
}
