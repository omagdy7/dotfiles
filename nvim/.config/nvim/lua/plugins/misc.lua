return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {}, -- this is equalent to setup({}) function
  },

  {
    "meuter/lualine-so-fancy.nvim",
    lazy = false,
  },

  {
    "stevearc/conform.nvim",
    keys = {
      {
        "<leader>c<S-F>",
        false,
      },
    },
  },

  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      -- VimTeX configuration goes here
      vim.g.vimtex_view_method = "zathura"
      -- Set LuaLaTeX as the default compiler
      vim.g.vimtex_compiler_method = "lualatex -shell-escape"
    end,
  },

  -- tmux navigator
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },

  {
    lazy = false,
    "windwp/nvim-ts-autotag",
    per_filetype = {
      ["astro"] = {
        enable_close = true,
        enable_rename = true,
      },
    },
  },

  -- add symbols-outline
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    config = true,
  },

  {
    lazy = false,
    "xiyaowong/transparent.nvim",
    extra_groups = {
      "TroubleNormal",
      "TroubleNormalNC",
      "NvimTreeNormal", -- NvimTree
    },
  },
}
