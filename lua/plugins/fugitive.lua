return {
    "tpope/vim-fugitive",
    dependencies = {
        "tpope/vim-rhubarb",
        "ruifm/gitlinker.nvim",
        "nvim-lua/plenary.nvim",
    },
    config = function()
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

        require("gitlinker").setup({
            mappings = "<leader>rg",
        })
    end,
}
