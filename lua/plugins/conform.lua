return {
    "stevearc/conform.nvim",
    opts = {},
    config = function()
        local conform = require("conform")
        conform.setup({
            formatters_by_ft = {
                lua = { "stylua" },
                rust = { "rustfmt", lsp_format = "fallback" },
                python = { "black" },
                javascript = { "prettierd" },
                typescript = { "prettierd" },
                css = { "prettierd" },
                scss = { "prettierd" },
                html = { "prettierd" },
            },
            -- log_level = vim.log.levels.DEBUG,
        })

        conform.formatters.stylua = {
            prepend_args = { "--indent-type=Spaces", "--collapse-simple-statement=FunctionOnly" },
        }

        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*",
            callback = function(args) require("conform").format({ bufnr = args.buf }) end,
        })
    end,
}
