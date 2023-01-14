local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--local ls = require "luasnip"

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local builtin = require('telescope.builtin')

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",
-- telescope
vim.keymap.set('n', '<leader>sf', builtin.find_files, {})
vim.keymap.set('n', '<leader>f', builtin.live_grep, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
vim.keymap.set('n', '<leader>of', builtin.oldfiles, opts)
vim.keymap.set('n', '<leader>ch', builtin.command_history, opts)

-- undoteree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)


-- nohlsearch
keymap("n", "<leader>h", ":noh<CR>", opts)

-- lsp
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, opts)

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -5<CR>", opts)
keymap("n", "<C-Down>", ":resize +5<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize +3<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize -3<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

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


keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
-- keymap("n", "<leader><leader>", ":bprevious<CR>", opts)

-- Centering after page moves or searching for something
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "n", "nzz", opts)

--CompetiTest
keymap("n", "<F2>", ":CompetiTestReceive<CR>", opts)
keymap("n", "<F5>", ":CompetiTestAdd<CR>", opts)
keymap("n", "<F4>", ":CompetiTestRun<CR>", opts)
