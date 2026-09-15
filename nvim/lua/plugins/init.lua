return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "mhinz/vim-signify",
    event = { "BufReadPre", "BufNewFile" },
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  {
    "nvim-treesitter/nvim-treesitter",
    opts_extend = { "ensure_installed" },
    opts = {
      ensure_installed = { "c", "cpp" },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPost",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      enable = true,            -- Enable this plugin by default
      max_lines = 3,            -- How many lines the floating window should span
      min_window_height = 0,    -- Minimum editor window height to enable context
      line_numbers = true,
      multiline_threshold = 20, -- Maximum number of lines to show for a single context
      trim_scope = "outer",     -- Which context lines to discard if max_lines is exceeded
      mode = "cursor",          -- Line used to calculate context. Choices: 'cursor', 'topline'
    },
  },

}
