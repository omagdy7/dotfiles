return {
  "nvim-telescope/telescope.nvim",
  keys = {
    {
      "<leader>fl",
      function()
        local pickers = require("telescope.pickers")
        local finders = require("telescope.finders")
        local conf = require("telescope.config").values
        local actions = require("telescope.actions")
        local action_state = require("telescope.actions.state")

        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
        local urls, seen = {}, {}

        for _, line in ipairs(lines) do
          for url in line:gmatch("https?://[%w-_%%&?./=+#]+") do
            if not seen[url] then
              seen[url] = true
              table.insert(urls, url)
            end
          end
        end

        if vim.tbl_isempty(urls) then
          print("No links found in buffer")
          return
        end

        pickers
          .new({}, {
            prompt_title = "Buffer Links",
            finder = finders.new_table({ results = urls }),
            sorter = conf.generic_sorter({}),
            attach_mappings = function(prompt_bufnr, map)
              local copy_and_close = function()
                local selection = action_state.get_selected_entry().value
                vim.fn.system({ "wl-copy" }, selection)
                print("Copied ➜ " .. selection)
                actions.close(prompt_bufnr)
              end
              map("i", "<CR>", copy_and_close)
              map("n", "<CR>", copy_and_close)
              return true
            end,
          })
          :find()
      end,
      desc = "Find links in current buffer",
    },
  },
}
