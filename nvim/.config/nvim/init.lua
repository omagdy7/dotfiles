-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.g.transparent_groups = vim.list_extend(vim.g.transparent_groups or {}, { "ExtraGroup" })
require("transparent").clear_prefix("NeoTree")
require("transparent").clear_prefix("Trouble")

-- require("notify").setup({
--   background_colour = "#000000",
-- })
