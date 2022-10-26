--[[ vim.g.material_style = "palenight" ]]

require('onedark').setup {
  style = 'deep',
  transparent = true,
}

require('material').setup{
  disable = {
    background = true
  }
}

require("nvim-treesitter.configs").setup {
  yati = { enable = true },
}


require "user.options"
require "user.keymaps"
require "user.plugins"
require "user.colorscheme"
require "user.cmp"
require "user.lsp"
require "user.snippets"
--[[ require "user.luasnip" ]]
require "user.telescope"
require "user.treesitter"
require "user.autopairs"
require "user.comment"
require "user.gitsigns"
require "user.nvim-tree"
require "user.bufferline"
require "user.lualine"
require "user.toggleterm"
require "user.project"
require "user.impatient"
require "user.indentline"
require "user.alpha"
require "user.whichkey"
require "user.autocommands"
--require "material"




















