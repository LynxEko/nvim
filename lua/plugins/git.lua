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
    {
        "pwntester/octo.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            local octo = require("octo")
            octo.setup()

            vim.keymap.set("n", "<leader>gp", function()
                local pr_number = vim.fn.input("PR number > ")
                vim.cmd.Octo({ "pr", "edit", pr_number })
            end, { desc = "Open GitHub issue/PR by number" })
            vim.keymap.set(
                "n",
                "<leader>go",
                function() vim.cmd.Octo({ "pr", "list" }) end,
                { desc = "Open GitHub issues/PRs" }
            )
        end,
    },
}
