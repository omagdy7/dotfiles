return {
  {
    "ellisonleao/gruvbox.nvim",
    config = true,
    opts = {
      transparent_mode = true,
    },
  },

  {
    "navarasu/onedark.nvim",
    name = "onedark",
    opts = {
      style = "deep",
      transparent = true,
    },
  },

  {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {
      disable_background = true,
    },
  },

  {
    "folke/tokyonight.nvim",
    priority = 1000,
    opts = {
      style = "night",
      transparent = true,
    },
  },
  {
    "marko-cerovac/material.nvim",
    priority = 1000,
    opts = { --Lua:
      lualine_style = "default",
      disable = {
        background = true,
      },
    },
  },
}
