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
    {
        "ThePrimeagen/99",
        config = function()
            local _99 = require("99")

            local cwd = vim.uv.cwd()
            local basename = vim.fs.basename(cwd)
            _99.setup({
                logger = {
                    level = _99.DEBUG,
                    path = "/tmp/" .. basename .. ".99.debug",
                    print_on_error = true,
                },
                model = "github-copilot/claude-sonnet-4.5",

                completion = {
                    custom_rules = {
                        "scratch/custom_rules/",
                        ".cursor/skills/",
                    },
                    source = "cmp",
                },

                md_files = {
                    "AGENTS.md",
                },
            })

            vim.keymap.set("n", "<leader>9ff", function() _99.fill_in_function() end)
            vim.keymap.set("n", "<leader>9fp", function() _99.fill_in_function_prompt() end)

            vim.keymap.set("v", "<leader>9vv", function() _99.visual() end)
            vim.keymap.set("v", "<leader>9vp", function() _99.visual_prompt() end)

            vim.keymap.set("n", "<leader>9s", function() _99.stop_all_requests() end)

            -- debugging
            vim.keymap.set("n", "<leader>9i", function() _99.info() end)
            vim.keymap.set("n", "<leader>9l", function() _99.view_logs() end)
            vim.keymap.set("n", "<leader>9n", function() _99.next_view_logs() end)
            vim.keymap.set("n", "<leader>9p", function() _99.prev_view_logs() end)
        end,
    },
}
