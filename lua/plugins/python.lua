return {
    "ranelpadon/python-copy-reference.vim",
    config = function()
        local python_group = vim.api.nvim_create_augroup("python_group", {})
        local autocmd = vim.api.nvim_create_autocmd
        autocmd("FileType", {
            group = python_group,
            pattern = "python",
            callback = function(args)
                vim.keymap.set("n", "<leader>ry", vim.cmd.PythonCopyReferenceDotted, { buffer = args.buf })
                vim.keymap.set("n", "<leader>ri", vim.cmd.PythonCopyReferenceImport, { buffer = args.buf })
            end,
        })
    end,
}
