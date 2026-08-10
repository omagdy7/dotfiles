-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- vim.g.transparent_groups = vim.list_extend(vim.g.transparent_groups or {}, { "ExtraGroup" })
require("transparent").clear_prefix("NeoTree")
require("transparent").clear_prefix("Trouble")
require("transparent").clear_prefix("FFF")
require("transparent").clear_prefix("SnacksPicker")

-- vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" }) -- Set normal background to black (replace with your desired color)
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#000000" }) -- Set floating window background

-- require("notify").setup({
--   background_colour = "#000000",
-- })
