-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

map("n", "<leader>t", ":lua require('dbgstmt').select()<CR>", { desc = "dbgstmt" })

-- Better navigation
map("n", "<C-d>", "<C-d>zz", { desc = "better half page down scroll", remap = true })
map("n", "<C-u>", "<C-u>zz", { desc = "better half page up scroll", remap = true })
map("n", "n", "nzz", { desc = "better jump for searched word", remap = true })
map("n", "<C-o>", "<C-o>zz", { desc = "better next jump", remap = true })
map("n", "<C-i>", "<C-i>zz", { desc = "better prev jump", remap = true })

-- fix annoying typos when saving or quitting
vim.cmd([[
    cnoreabbrev W! w!
    cnoreabbrev W1 w!
    cnoreabbrev w1 w!
    cnoreabbrev Q! q!
    cnoreabbrev Q1 q!
    cnoreabbrev q1 q!
    cnoreabbrev Qa! qa!
    cnoreabbrev Qall! qall!
    cnoreabbrev WW w
    cnoreabbrev Wa wa
    cnoreabbrev WA wa
    cnoreabbrev Wq wq
    cnoreabbrev wQ wq
    cnoreabbrev WQ wq
    cnoreabbrev wq1 wq!
    cnoreabbrev Wq1 wq!
    cnoreabbrev wQ1 wq!
    cnoreabbrev WQ1 wq!
    cnoreabbrev W w
    cnoreabbrev Q q
    cnoreabbrev Qa qa
    cnoreabbrev Qall qall
]])

-- vimtex keymaps
map("n", "<leader>i", "<Cmd>VimtexCompile<CR>", { desc = "Compile latex document", remap = true })

-- harpoon keymaps
map("n", "<leader>mm", function()
  require("harpoon.ui").toggle_quick_menu()
end, { desc = "toggle harpoon menu", remap = true })

map("n", "<leader>ma", function()
  require("harpoon.mark").add_file()
end, { desc = "Add file to harpoon", remap = true })

map("n", "<leader>mq", function()
  require("harpoon.ui").nav_file(1)
end, { desc = "navigate to first harpoon mark", remap = true })

map("n", "<leader>mw", function()
  require("harpoon.ui").nav_file(2)
end, { desc = "navigate to second harpoon mark", remap = true })

map("n", "<leader>me", function()
  require("harpoon.ui").nav_file(3)
end, { desc = "navigate to third harpoon mark", remap = true })

map("n", "<leader>h", "<Cmd>noh<CR>", { desc = "remove highlights", remap = true })
map("n", "<leader>j", "/<++><CR>ciw<CR><C-o>O", { desc = "jump to <++>", remap = true })
map("n", "<leader><space>", "<Cmd>bprevious<CR>", { desc = "Jump to recently used buffer" })
map("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", { desc = "Line diagnostics", remap = true })

-- oil.nvim keymaps
map("n", "<leader>o", "<cmd>Oil<CR>", { desc = "Open Oil.nvim", remap = true })
map("n", "-", "<cmd>Oil<CR>", { desc = "Open Oil.nvim", remap = true })

-- competitest keymaps
map("n", "<F2>", "<cmd> CompetiTest receive problem <CR>", { desc = "Receive test", remap = true })
map("n", "<F4>", "<cmd> CompetiTest run <CR>", { desc = "Run test", remap = true })
map("n", "<F5>", "<cmd> CompetiTest add_testcase <CR>", { desc = "Add test", remap = true })
