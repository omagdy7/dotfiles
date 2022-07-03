local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
  use "numToStr/Comment.nvim" -- Easily comment stuff
  use "kyazdani42/nvim-web-devicons"
  use "kyazdani42/nvim-tree.lua"
  use "akinsho/bufferline.nvim"
  use "moll/vim-bbye"
  use "nvim-lualine/lualine.nvim"
  use "akinsho/toggleterm.nvim"
  use "ahmedkhalf/project.nvim"
  use "lewis6991/impatient.nvim"
  use "lukas-reineke/indent-blankline.nvim"
  use "goolord/alpha-nvim"
  use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight
  use "folke/which-key.nvim"
  use "nvim-lua/plenary.nvim"

  -- fix indentation
  use({ "yioneko/nvim-yati", requires = "nvim-treesitter/nvim-treesitter" })

  -- Surround
  use "tpope/vim-surround"

  -- Colorschemes
  -- use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
  use 'crusoexia/vim-monokai'
  use 'folke/tokyonight.nvim'
  use "lunarvim/darkplus.nvim"
  use "marko-cerovac/material.nvim"
  use "drewtempelmeyer/palenight.vim"
  use 'Mofiqul/dracula.nvim'
  use 'tanvirtin/monokai.nvim'
  use 'eddyekofo94/gruvbox-flat.nvim'
  use 'kyazdani42/nvim-palenight.lua'
  use 'navarasu/onedark.nvim'

  -- cmp plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"
  use "windwp/nvim-ts-autotag" --auto close tags
  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters


  --compitest
  require('competitest').setup {
    local_config_file_name = ".competitest.lua",

    floating_border = "rounded",
    floating_border_highlight = "FloatBorder",
    picker_ui = {
      width = 0.2,
      height = 0.3,
      mappings = {
        focus_next = { "j", "<down>", "<Tab>" },
        focus_prev = { "k", "<up>", "<S-Tab>" },
        close = { "<esc>", "<C-c>", "q", "Q" },
        submit = { "<cr>" },
      },
    },
    editor_ui = {
      popup_width = 0.4,
      popup_height = 0.6,
      show_nu = true,
      show_rnu = false,
      normal_mode_mappings = {
        switch_window = { "<C-h>", "<C-l>", "<C-i>" },
        save_and_close = "<C-s>",
        cancel = { "q", "Q" },
      },
      insert_mode_mappings = {
        switch_window = { "<C-h>", "<C-l>", "<C-i>" },
        save_and_close = "<C-s>",
        cancel = "<C-q>",
      },
    },
    runner_ui = {
      total_width = 0.8,
      total_height = 0.8,
      selector_width = 0.3,
      selector_show_nu = false,
      selector_show_rnu = false,
      show_nu = true,
      show_rnu = false,
      mappings = {
        run_again = "R",
        run_all_again = "<C-r>",
        kill = "K",
        kill_all = "<C-k>",
        view_input = { "i", "I" },
        view_output = { "a", "A" },
        view_stdout = { "o", "O" },
        view_stderr = { "e", "E" },
        close = { "q", "Q" },
      },
      viewer = {
        width = 0.5,
        height = 0.5,
        show_nu = true,
        show_rnu = false,
        close_mappings = { "q", "Q" },
      },
    },

	save_current_file = true,
	save_all_files = false,
	compile_directory = ".",
	compile_command = {
		c = { exec = "gcc", args = { "-Wall", "$(FNAME)", "-o", "$(FNOEXT)" } },
		cpp = { exec = "g++", args = { "-Wall", "$(FNAME)", "-o", "$(FNOEXT)" } },
		rust = { exec = "rustc", args = { "$(FNAME)" } },
		java = { exec = "javac", args = { "$(FNAME)" } },
	},
	running_directory = ".",
	run_command = {
		c = { exec = "./$(FNOEXT)" },
		cpp = { exec = "./$(FNOEXT)" },
		rust = { exec = "./$(FNOEXT)" },
		python = { exec = "python", args = { "$(FNAME)" } },
		java = { exec = "java", args = { "$(FNOEXT)" } },
	},
	multiple_testing = -1,
	maximum_time = 5000,
	output_compare_method = "squish",

	testcases_directory = ".",
	input_name = "input",
	output_name = "output",
	testcases_files_format = "$(FNOEXT)_$(INOUT)$(TCNUM).txt",
	testcases_use_single_file = false,
	testcases_single_file_format = "$(FNOEXT).testcases",

	companion_port = 27121,
	receive_print_message = true,
}
  -- Telescope
  use "nvim-telescope/telescope.nvim"

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  use "JoosepAlviste/nvim-ts-context-commentstring"

  -- Git
  use "lewis6991/gitsigns.nvim"

  -- competitve programming
  use {
    'xeluxee/competitest.nvim',
    requires = 'MunifTanjim/nui.nvim',
    config = function() require'competitest'.setup() end
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
