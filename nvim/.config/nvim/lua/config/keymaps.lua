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

-- Define a function to reload the plugin
function ReloadPlugin(plugin_name)
  -- Clear the module from Lua's cache
  package.loaded[plugin_name] = nil
  -- Require the module again
  return require(plugin_name)
end

-- Keymap to reload the plugin and call its setup function
vim.keymap.set("n", "<leader>rp", function()
  local plugin_name = "dbgln" -- Replace with your plugin's module name
  local plugin = ReloadPlugin(plugin_name)
  if plugin.setup then
    plugin.setup() -- Call setup if it exists
    print(plugin_name .. " reloaded and setup!")
  else
    print("Failed to call setup for " .. plugin_name)
  end
end, { desc = "Reload and setup the plugin" })

-- Better navigation
map("n", "<C-d>", "<C-d>zz", { desc = "better half page down scroll", remap = true })
map("n", "<C-u>", "<C-u>zz", { desc = "better half page up scroll", remap = true })
map("n", "n", "nzz", { desc = "better jump for searched word", remap = true })
map("n", "<C-o>", "<C-o>zz", { desc = "better next jump", remap = true })
map("n", "<C-i>", "<C-i>zz", { desc = "better prev jump", remap = true })

-- plugin development
map("n", "<leader>t", ":lua require('dbgln').setup()<CR>", { desc = "dbgln" })
map("n", "<leader>d", "<cmd>DbgLn<CR>", { desc = "Print Debgging Line" })

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
map("n", "<leader>m", function()
  require("harpoon.ui").toggle_quick_menu()
end, { desc = "toggle harpoon menu", remap = true })

map("n", "<leader>a", function()
  require("harpoon.mark").add_file()
end, { desc = "Add file to harpoon", remap = true })

map("n", "<leader>q", function()
  require("harpoon.ui").nav_file(1)
end, { desc = "navigate to first harpoon mark", remap = true })

map("n", "<leader>w", function()
  require("harpoon.ui").nav_file(2)
end, { desc = "navigate to second harpoon mark", remap = true })

map("n", "<leader>e", function()
  require("harpoon.ui").nav_file(3)
end, { desc = "navigate to third harpoon mark", remap = true })

map("n", "<leader>h", "<Cmd>noh<CR>", { desc = "remove highlights", remap = true })
map("n", "<leader>j", "/<++><CR>ciw<CR><C-o>O", { desc = "jump to <++>", remap = true })
map("n", "<leader><space>", "<Cmd>bprevious<CR>", { desc = "Jump to recently used buffer" })
map("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", { desc = "Line diagnostics", remap = true })

-- oil.nvim keymaps
map("n", "<leader>o", "<cmd>Oil<CR>", { desc = "Open Oil.nvim", remap = true })
map("n", "<leader>e", function()
  if vim.o.filetype == "oil" then
    vim.cmd("bd")
  else
    vim.cmd("vsplit | vertical resize -60 | wincmd r")
    require("oil").open()
  end
end, { desc = "Open Oil.nvim ins split mode", remap = true })
map("n", "-", "<cmd>Oil<CR>", { desc = "Open Oil.nvim", remap = true })

-- competitest keymaps
map("n", "<F2>", "<cmd> CompetiTest receive problem <CR>", { desc = "Receive test", remap = true })
map("n", "<F4>", "<cmd> CompetiTest run <CR>", { desc = "Run test", remap = true })
map("n", "<F5>", "<cmd> CompetiTest add_testcase <CR>", { desc = "Add test", remap = true })
