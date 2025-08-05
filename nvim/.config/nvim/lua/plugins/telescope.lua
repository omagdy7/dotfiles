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
      "<leader>fq",
      "<Cmd>Telescope quickfix<CR>",
      desc = "Find quickfix list",
    },
    {
      "<leader>fp",
      function()
        require("telescope.builtin").lsp_document_symbols()
      end,
      desc = "Find Document Sympols",
    },
    {
      "<leader>fd",
      "<Cmd>Telescope diagnostics<CR>",
      desc = "Find diagnostics in current project",
    },
    {
      "<leader>ff",
      "<Cmd>Telescope find_files<CR>",
      desc = "Find files in current project",
    },
    {
      "<leader>fg",
      "<Cmd>Telescope git_files<CR>",
      desc = "Find git files in current project",
    },
    {
      "<leader>fb",
      "<Cmd>Telescope buffers<CR>",
      desc = "Find Buffer",
    },
    {
      "<leader>fk",
      function()
        require("telescope.builtin").keymaps()
      end,
      desc = "Find Keymaps",
    },
    {
      "<leader>cd",
      function()
        local actions = require("telescope.actions")
        local action_state = require("telescope.actions.state")

        require("telescope.builtin").git_commits({
          attach_mappings = function(prompt_bufnr, _)
            actions.select_default:replace(function()
              actions.close(prompt_bufnr)
              local entry = action_state.get_selected_entry()
              local commit = entry.value
              vim.cmd("DiffviewOpen " .. commit .. "..HEAD")
            end)
            return true
          end,
        })
      end,
      desc = "Diff between current commit and an arbitrary commit",
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
        require("telescope.builtin").current_buffer_fuzzy_find()
      end,
      desc = "Grep current File",
    },
    {
      "<leader>fm",
      function()
        require("telescope.builtin").marks()
      end,
      desc = "Find Vim Marks",
    },
    {
      "<leader>ft",
      function()
        require("telescope.builtin").treesitter()
      end,
      desc = "Find treesitter nodes",
    },
    {
      "<leader>fh",
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
