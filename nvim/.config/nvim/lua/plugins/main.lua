-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore
-- if true then return {} end

-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim",
    config = true,
    opts = {
      transparent_mode = true,
    }
  },
  -- Using Packer
  { 'navarasu/onedark.nvim' , name = 'onedark',
    opts = {
      style = 'deep',  transparent= true
    }
  },

  { 'rose-pine/neovim', name = 'rose-pine',
    opts = {
      disable_background = true
    }
  },

  {
    "windwp/nvim-ts-autotag",
  },

  -- tmux navigator
{
  "christoomey/vim-tmux-navigator",
  lazy = true,
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
    { "<c-;>", "<cmd><C-U>TmuxNavigateRight<cr>" },
    { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },


  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "sindrets/diffview.nvim",        -- optional - Diff integration

      -- Only one of these is needed, not both.
      "nvim-telescope/telescope.nvim", -- optional
      "ibhagwan/fzf-lua",              -- optional
    },
    config = true,
    keys = {
      {
        "<leader>g;",
        "<Cmd>Neogit<CR>"
      }
    }

  },

  {
    'stevearc/oil.nvim',
    opts = {},
    lazy = false,
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      -- VimTeX configuration goes here
      vim.g.vimtex_view_method = 'zathura'
    end
  },

  {
    'RaafatTurki/hex.nvim' ,
    config = true,
    lazy = false,
  },

  -- If you are using Packer
  { "folke/tokyonight.nvim", priority = 1000,
    opts = {
      style = "night",
      transparent = true,
    }
  },


  {
    'krady21/compiler-explorer.nvim',
    lazy = false,
  },
  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
      -- colorscheme = "onedark",
      -- colorscheme = "catppuccin",
      -- colorscheme = "material-deep-ocean",
      -- colorscheme = "tokyonight-night",
    },
  },


  {
    "ThePrimeagen/harpoon",
  },


  -- change trouble config
  {
    "folke/trouble.nvim",
    -- opts will be merged with the parent spec
    opts = { use_diagnostic_signs = true },
    keys = {
      {
        "<leader>xx", function() require("trouble").toggle() end
      },
      {
        "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end
      },
      {
        "<leader>xd", function() require("trouble").toggle("document_diagnostics") end
      },
      {
        "<leader>xq", function() require("trouble").toggle("quickfix") end
      },
      {
       "<leader>xl", function() require("trouble").toggle("loclist") end
      },
      {
        "gR", function() require("trouble").toggle("lsp_references") end
      },
    },
  },

  -- add symbols-outline
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    config = true,
  },

  -- override nvim-cmp and add cmp-emoji
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "emoji" } }))
    end,
  },

  -- change some telescope options and a keymap to browse plugin files
  {
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
        false
      },
      {
        "<leader>f<S-E>",
        false
      },
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
      {
        "<leader>fw",
        function() require("telescope.builtin").live_grep() end,
        desc = "Find words in project",
      },
      {
        "<leader>f/",
        function() require("telescope.builtin").live_grep() end,
        desc = "Find words in project",
      },
      {
        "<leader>fm",
        "<Cmd>Telescope harpoon marks<CR>",
        desc = "harpoon marks",
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
  },

  -- add harpoon support for telescope
  {
    "telescope.nvim",
    dependencies = {
      "ThePrimeagen/harpoon",
      build = "make",
      config = function()
        require("telescope").load_extension("harpoon")
      end,
    },
  },

  -- add telescope-fzf-native
  {
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
  },

  {
    'stevearc/conform.nvim',
    keys = {
      {
        "<leader>c<S-F>", false
      },
    }
  },


  -- add tsserver and setup with typescript.nvim instead of lspconfig
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- disable default lazy keymaps for lsp
      keys[#keys + 1] = { "<leader>ca", false}
      keys[#keys + 1] = { "<leader>c<S-A>", false}
      keys[#keys + 1] = { "<leader>cc", false}
      keys[#keys + 1] = { "<leader>c<S-C>", false}
      keys[#keys + 1] = { "<leader>cd", false}
      keys[#keys + 1] = { "<leader>cf", false}
      keys[#keys + 1] = { "<leader>c<S-F>", false}
      keys[#keys + 1] = { "<leader>cl", false}
      keys[#keys + 1] = { "<leader>cm", false}
      keys[#keys + 1] = { "<leader>co", false}
      keys[#keys + 1] = { "<leader>cr", false}
      keys[#keys + 1] = { "<leader>c<S-R>", false}
      keys[#keys + 1] = { "<leader>cs", false}

      keys[#keys + 1] = { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "Rename variable",}
      keys[#keys + 1] = { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "code actions",}
    end,

    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      init = function()
        require("lazyvim.util").lsp.on_attach(function(_, buffer)
          -- stylua: ignore
          -- vim.keymap.set( "n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
          -- vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
        end)
      end,
    },
    ---@class PluginLspOpts
    opts = {
      inlay_hints = { enabled = false },
      ---@type lspconfig.options
      servers = {
        -- tsserver will be automatically installed with mason and loaded with lspconfig
        tsserver = {},
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- example to setup with typescript.nvim
        tsserver = function(_, opts)
          require("typescript").setup({ server = opts })
          return true
        end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
  },

  -- for typescript, LazyVim also includes extra specs to properly setup lspconfig,
  -- treesitter, mason and typescript.nvim. So instead of the above, you can use:
  { import = "lazyvim.plugins.extras.lang.typescript" },

  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "rust",
        "cpp",
        "c",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
      autotag = {
        enable = true,
      },
    },
  },


  -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
  -- would overwrite `ensure_installed` with the new value.
  -- If you'd rather extend the default config, use the code below instead:
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "tsx",
        "typescript",
      })
    end,
  },

  -- the opts function can also be used to change the default opts:
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, "😄")
    end,
  },

  -- or you can return new options to override all the defaults
  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    opts = function()
      return {
        options = {
          theme = 'ayu_dark'
        }
      }
    end,
  },


  { "marko-cerovac/material.nvim", priority = 1000,
    opts = {--Lua:
      lualine_style = "default",
      disable = {
        background = true,
      },
    }
  },

  {
      'windwp/nvim-autopairs',
      event = "InsertEnter",
      opts = {} -- this is equalent to setup({}) function
  },

  -- use mini.starter instead of alpha
  -- { import = "lazyvim.plugins.extras.ui.mini-starter" },

  -- add jsonls and schemastore packages, and setup treesitter for json, json5 and jsonc
  { import = "lazyvim.plugins.extras.lang.json" },

  -- add any tools you want to have installed below
  {
    "williamboman/mason.nvim",
    keys = {
      { "<leader>cm", false }
    },
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
      },
    },
  },

  -- Use <tab> for completion and snippets (supertab)
  -- first: disable default <tab> and <s-tab> behavior in LuaSnip
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },
  -- then: setup supertab in cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<C-;>"] = cmp.mapping(function(fallback)
          -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
          -- this way you will only jump inside the snippet region
          if luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif cmp.visible() then
            cmp.select_next_item()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
            end
        end, { "i", "s" }),
        ["<C-h>"] = cmp.mapping(function(fallback)
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          elseif cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    end,
  },

  {
    "echasnovski/mini.move",
    opts = {
      mappings = {
        -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
        left = '<S-h>',
        right = '<S-l>',
        down = '<S-j>',
        up = '<S-k>',

        -- Move current line in Normal mode
        line_left = '<M-h>',
        line_right = '<M-l>',
        line_down = '<M-j>',
        line_up = '<M-k>',
      },

      -- Options which control moving behavior
      options = {
        -- Automatically reindent selection during linewise vertical move
        reindent_linewise = true,
      },
    },
  },


  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = "gsa",
        delete = "gsd",
        find = "gsf",
        find_left = "gsF",
        highlight = "gsh",
        replace = "gsr",
        update_n_lines = "gsn",
      },
    },
  }
}
