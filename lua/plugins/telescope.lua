return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("telescope").setup {}

    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Find files" })
    -- New keymaps:
    vim.keymap.set("n", "<leader>pg", builtin.live_grep, { desc = "Live grep" })
    vim.keymap.set("n", "<leader>pb", builtin.buffers, { desc = "Buffers" })
    vim.keymap.set("n", "<leader>ps", builtin.lsp_document_symbols, { desc = "Document symbols" })
    vim.keymap.set("n", "<leader>pd", builtin.diagnostics, { desc = "Diagnostics" })
    vim.keymap.set("n", "<leader>ph", builtin.help_tags, { desc = "Help tags" })
  end,
}

