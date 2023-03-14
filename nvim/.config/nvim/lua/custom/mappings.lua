local M = {}

M.competitest = {
  n = {
    ["<F2>"] = {"<cmd> CompetiTestReceive problem <CR>", "Receive test"},
    ["<F4>"] = {"<cmd> CompetiTestRun <CR>", "Receive test"},
    ["<F5>"] = {"<cmd> CompetiTestAdd <CR>", "Receive test"},
  }
}

return M
