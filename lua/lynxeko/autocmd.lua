local augroup = vim.api.nvim_create_augroup
local lynxeko_group = augroup("lynxeko", {})

local autocmd = vim.api.nvim_create_autocmd

autocmd("LspAttach", {
    group = lynxeko_group,
    callback = function(args)
        local opts = { buffer = args.buf }
        vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
        vim.keymap.set("n", "<C-h>", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)

        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)

        vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)

        vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end)
    end,
})
