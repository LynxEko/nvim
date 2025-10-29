return {
    {
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
                    vim.keymap.set("n", "<leader>rf", vim.cmd.PythonCopyReferencePytest, { buffer = args.buf })
                end,
            })
        end,
    },
    {
        "brentyi/isort.vim",
        config = function()
            local null_ls = require("null-ls")
            null_ls.register({
                name = "isort",
                method = { null_ls.methods.CODE_ACTION },
                filetypes = { "python" },
                generator = {
                    fn = function()
                        return {
                            {
                                title = "isort",
                                action = function() vim.cmd("Isort") end,
                            },
                        }
                    end,
                },
            })
        end,
    },
}
