local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--local ls = require "luasnip"

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
local ls = require "luasnip"

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize +2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize -2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
--keymap("n", "<leader>m", ":MaximizerToggle<CR>", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)


-- Jumping quickly between two files
keymap("n", "<leader><leader>", ":bprevious<CR>", opts)

--CompetiTest
keymap("n", "<F2>", ":CompetiTestReceive<CR>", opts)
keymap("n", "<F3>", ":CompetiTestRun<CR>", opts)

--sourcing luasnips
keymap("n", "<leader><leader>s", "<cmd> source ~/.config/nvim/lua/user/luasnip.lua<CR>", opts)


-- luasnips
vim.keymap.set({ "i", "s" }, "<c-k>", function ()
  print("hello")
  if ls.expand_or_jumpable then
    ls.expand_or_jump()end
end, { silent = false })
--vim.keymap.set("i", "<c-h>", function () if ls.jumpable(-1) then ls.jump(-1)end end, opts)

--keymap("i", "<c-l>", "function () if ls.expand_or_jumpable then ls.expand_or_jump()end end", opts)
--keymap("i", "<c-h>", "function () if ls.jumpable(-1) then ls.jump(-1)end end", opts)

