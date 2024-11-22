return {
  "nvim-telescope/telescope.nvim",
  keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>f<S-R>",
        false
      },
    {
      "<leader>fe",
      false,
    },
    {
      "<leader>f<S-E>",
      false,
    },
    {
      "<leader>fp",
      function()
        require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
      end,
      desc = "Find Plugin File",
    },
    {
      "<leader>fb",
      "<Cmd>Telescope buffers<CR>",
      desc = "Find Buffer",
    },
    {
      "<leader>fw",
      function()
        require("telescope.builtin").live_grep()
      end,
      desc = "Find words in project",
    },
    {
      "<leader>f/",
      function()
        require("telescope.builtin").live_grep()
      end,
      desc = "Find words in project",
    },
    {
      "<leader>fm",
      "<Cmd>Telescope harpoon marks<CR>",
      desc = "harpoon marks",
    },
    {
      "<leader>fs",
      "<Cmd>Telescope spell_suggest<CR>",
      desc = "Spell Suggesstions",
    },
  },
  -- change some options
  opts = {
    defaults = {
      layout_strategy = "horizontal",
      layout_config = { prompt_position = "top" },
      sorting_strategy = "ascending",
      winblend = 0,
      mappings = {
        i = {
          ["<C-n>"] = require("telescope.actions").cycle_history_next,
          ["<C-p>"] = require("telescope.actions").cycle_history_prev,
          ["<C-j>"] = require("telescope.actions").move_selection_next,
          ["<C-k>"] = require("telescope.actions").move_selection_previous,
        },
        n = { ["q"] = require("telescope.actions").close },
      },
    },
  },
}
