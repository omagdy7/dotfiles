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

}


