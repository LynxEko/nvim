return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    -- or
    -- branch = '0.1.x',
    dependencies = { "nvim-lua/plenary.nvim" },

    config = function()
        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
        vim.keymap.set("n", "<C-p>", builtin.git_files, {})
        vim.keymap.set("n", "<leader>fs", function() builtin.grep_string({ search = vim.fn.input("Grep > ") }) end)
        vim.keymap.set("v", "<leader>fs", function()
            local mode = vim.api.nvim_get_mode().mode
            local opts = (mode == "v" or mode == "V" or mode == "\22") and { type = mode } or vim.empty_dict() -- \22 is the escaped version of ctrl-v
            local selection = vim.fn.getregion(vim.fn.getpos("."), vim.fn.getpos("v"), opts)
            builtin.grep_string({ search = selection[1] })
        end)
        vim.keymap.set("n", "<leader>fw", function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set("n", "<leader>fW", function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
    end,
}
