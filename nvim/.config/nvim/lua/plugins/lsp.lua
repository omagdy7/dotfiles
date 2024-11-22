return {
  -- add tsserver and setup with typescript.nvim instead of lspconfig
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- disable default lazy keymaps for lsp
      keys[#keys + 1] = { "<leader>ca", false }
      keys[#keys + 1] = { "<leader>c<S-A>", false }
      keys[#keys + 1] = { "<leader>cc", false }
      keys[#keys + 1] = { "<leader>c<S-C>", false }
      keys[#keys + 1] = { "<leader>cd", false }
      keys[#keys + 1] = { "<leader>cf", false }
      keys[#keys + 1] = { "<leader>c<S-F>", false }
      keys[#keys + 1] = { "<leader>cl", false }
      keys[#keys + 1] = { "<leader>cm", false }
      keys[#keys + 1] = { "<leader>co", false }
      keys[#keys + 1] = { "<leader>cr", false }
      keys[#keys + 1] = { "<leader>c<S-R>", false }
      keys[#keys + 1] = { "<leader>cs", false }

      keys[#keys + 1] = { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "Rename variable" }
      keys[#keys + 1] = { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "code actions" }
    end,

    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      init = function()
        require("lazyvim.util").lsp.on_attach(function(_, buffer)
          -- stylua: ignore
          -- vim.keymap.set( "n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
          -- vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
        end)
      end,
    },
    ---@class PluginLspOpts
    opts = {
      inlay_hints = { enabled = false },
      ---@type lspconfig.options
      servers = {
        -- tsserver will be automatically installed with mason and loaded with lspconfig
        tsserver = {},
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- example to setup with typescript.nvim
        tsserver = function(_, opts)
          require("typescript").setup({ server = opts })
          return true
        end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
  },
}
