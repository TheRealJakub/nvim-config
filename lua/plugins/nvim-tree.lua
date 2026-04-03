return {
    "nvim-tree/nvim-tree.lua",
    config = function()
        require("nvim-tree").setup {}
        -- Keymaps
	vim.keymap.set("n", "<localleader>e", ":NvimTreeFocus<CR>")
	vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

    end,
}

