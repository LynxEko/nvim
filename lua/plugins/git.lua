return {
    {
        "tpope/vim-fugitive",
        dependencies = { "tpope/vim-rhubarb" },
        config = function()
            vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
            vim.keymap.set("n", "<leader>gb", function() vim.cmd.Git("blame") end)
        end,
    },
    {
        "ruifm/gitlinker.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("gitlinker").setup({
                mappings = "<leader>rg",
            })
        end,
    },
}
