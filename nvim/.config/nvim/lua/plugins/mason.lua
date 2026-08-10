return {
  -- add any tools you want to have installed below
  {
    "mason-org/mason.nvim",
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
