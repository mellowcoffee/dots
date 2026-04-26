return {
  -- Typing practice
  {
    "nvzone/typr",
    lazy = true,
    dependencies = "nvzone/volt",
    opts = {},
    cmd = { "Typr", "TyprStats" },
  },

  -- Discord rich presence
  {
    "IogaMaster/neocord",
    event = "VeryLazy",
    opts = {
      logo                = nil,
      logo_tooltip        = nil,
      main_image          = "language",
      log_level           = nil,
      debounce_timeout    = 10,
      blacklist           = {},
      file_assets         = {},
      show_time           = true,
      global_timer        = false,
      buttons             = nil,
      editing_text        = "Editing %s",
      file_explorer_text  = "Browsing %s",
      git_commit_text     = "Committing changes",
      plugin_manager_text = "Managing plugins",
      reading_text        = "Reading %s",
      workspace_text      = "Working on %s",
      line_number_text    = "Line %s out of %s",
      terminal_text       = "Using Terminal",
    },
  },
}
