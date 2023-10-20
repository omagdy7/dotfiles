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

map("v", "<S-j>", ":m '>+1<CR>gv=gv", { desc = "Move down" })
map("v", "<S-k>", ":m '<-2<CR>gv=gv", { desc = "Move up" })

map("n", "<leader>h", "<Cmd>noh<CR>", { desc = "remove highlights", remap = true })
map("n", "<leader>j", "/<()><CR>ciw<CR><C-o>O", { desc = "jump to <()>", remap = true })
map("n", "<leader>c", "<Cmd>bd<CR>", { desc = "Close current buffer", remap = true })
map("n", "<leader>l", "", { desc = "unset lazy shortcut", remap = true })
map("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", { desc = "code actions", remap = true })
map("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", { desc = "Line diagnostics", remap = true })

map("n", "<C-d>", "<C-d>zz", { desc = "better half page down scroll", remap = true })
map("n", "<C-u>", "<C-u>zz", { desc = "better half page up scroll", remap = true })
map("n", "n", "nzz", { desc = "better jump for searched word", remap = true })

-- competitest keymaps
map("n", "<F2>", "<cmd> CompetiTest receive problem <CR>", { desc = "Receive test", remap = true })
map("n", "<F4>", "<cmd> CompetiTest run <CR>", { desc = "Run test", remap = true })
map("n", "<F5>", "<cmd> CompetiTest add_testcase <CR>", { desc = "Add test", remap = true })
