vim.g.material_style = "deep ocean"
-- vim.g.material_style = "palenight"
-- vim.g.material_style = "darker"
-- vim.g.tokyonight_style = "night"
-- vim.g.tokyonight_italic_functions = true
-- vim.g.tokyonight_italic_keywords	= true
-- vim.g.tokyonight_italic_variables = true
-- vim.g.tokyonight_italic_comments = true
-- vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
-- vim.g.tokyonight_terminal_colors = true
-- vim.g.airline_theme = "tokyonight"
-- vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }

--  require('onedark').setup {
--      style = 'deep'
-- }
 --require'lspconfig'.gdscript.setup{
   --capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
 --}

require('material').setup{
  disable = {
    background = true
  }
}


require "user.options"
require "user.keymaps"
require "user.plugins"
require "user.colorscheme"
require "user.cmp"
require "user.lsp"
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


