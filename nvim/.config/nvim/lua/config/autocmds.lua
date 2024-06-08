-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- sync system clipboard while yanking
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    local v = vim.v.event
    local regcontents = v.regcontents
    vim.defer_fn(function()
      vim.fn.setreg("+", regcontents)
    end, 100)
  end,
})

-- sync system clipboard to vim clipboard
vim.api.nvim_create_autocmd("FocusGained", {
  callback = function()
    local loaded_content = vim.fn.getreg("+")
    if loaded_content ~= "" then
      vim.fn.setreg('"', loaded_content)
    end
  end,
})
