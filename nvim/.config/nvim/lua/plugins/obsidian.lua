return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",

  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- see below for full list of optional dependencies 👇
  },
  opts = {
    disable_frontmatter = true,
    workspaces = {
      {
        name = "personal",
        path = "/mnt/Storage/omar/volty",
      },
    },
    templates = {
      folder = "5 - Template",
    },
  },
  keys = {
    {
      "<leader>on",
      "<Cmd>ObsidianNew<CR>",
      desc = "New Obsidian Note",
    },
    {
      "<leader>oo",
      "<Cmd>ObsidianOpen<CR>",
      desc = "Open note in obsidian",
    },
    {
      "<leader>ot",
      "<Cmd>ObsidianTemplate<CR>",
      desc = "Open a new note with template",
    },
  },
}
