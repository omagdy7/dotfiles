
-- Set colorscheme
vim.cmd [[colorscheme catppuccin-mocha]]

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- [[ Highlight on yank ]]
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Enable Comment.nvim
require('Comment').setup()

-- Enable `lukas-reineke/indent-blankline.nvim`
require('indent_blankline').setup {
  char = '|',
  show_trailing_blankline_indent = false,
}

require "user.plugins"
require "user.competitest"
require "user.bufferline"
require "user.treesitter"
require "user.lualine"
require "user.lsp"
require "user.telescope"
require "user.keymaps"
require "user.options"
require "user.gitsigns"
require "user.nvim-tree"
require "user.cmp"
