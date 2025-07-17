-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.ch = 0
vim.opt.list = false
vim.opt.confirm = false
-- vim.o.clipboard = ""
vim.o.guifont = "Monaspace Radon:h12:bold" -- text below applies for VimScript

vim.o.spell = false

-- Best search settings :)
vim.opt.smartcase = true
vim.opt.ignorecase = true

-- Helper function for transparency formatting
local alpha = function()
  return string.format("%x", math.floor(255 * vim.g.transparency or 0.8))
end
-- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
vim.g.neovide_transparency = 0.5
vim.g.transparency = 0.8
vim.g.neovide_background_color = "#0A0E14" .. alpha()
