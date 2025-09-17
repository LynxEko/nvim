return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        config = function()
            -- remember to auth using :Copilot auth
            require("copilot").setup({
                suggestion = { enabled = false },
                panel = { enabled = false },
            })
        end,
    },
    {
        "zbirenbaum/copilot-cmp",
        dependencies = { "zbirenbaum/copilot.lua", "hrsh7th/nvim-cmp" },
        config = function() require("copilot_cmp").setup() end,
    },
}
