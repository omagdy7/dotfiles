return {
  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.lspconfig"
    end,
    },

  ["xeluxee/competitest.nvim"] = {
    config = function()
      require "custom.plugins.competitest"
    end,
  },

  ["MunifTanjim/nui.nvim"] = {},
  ["Exafunction/codeium.vim"] = {},
  -- ["catppuccin/nvim"] = {
  --   config = function()
  --     require "custom.plugins.catppuccin"
  --   end
  -- },
  ["windwp/nvim-ts-autotag"] = {
    config = function()
      require "custom.plugins.nvim-ts-autotag"
    end
  },

}


