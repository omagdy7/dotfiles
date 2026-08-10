return {
  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "rust",
        "cpp",
        "c",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
      autotag = {
        enable = true,
      },
    },
  },
}
