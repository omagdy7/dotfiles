return {
  -- add any tools you want to have installed below
  {
    "williamboman/mason.nvim",
    keys = {
      { "<leader>cm", false },
    },
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
      },
    },
  },
}
