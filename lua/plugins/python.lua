local switch_source_test = function()
    local filepath = vim.fn.expand("%")
    -- matches
    -- src/module/test/something/something/test_file.py
    --    1^^^^^^     2^^^^^^^^^^^^^^^^^^^3^^^^^^^^^^^^
    local pattern_for_test_files = "src/([%a%d_]*)/tests/([%a%d_/]*)/(test_[%a%d_]*.py)"
    -- matches
    -- src/module/something/something/file.py
    --    1^^^^^^2^^^^^^^^^^^^^^^^^^^3^^^^^^^
    local pattern_for_source_files = "src/([%a%d_]*)/([%a%d_/]*)/([%a%d_]*.py)"

    local _, _, test_module_name, test_sub_modules, test_filename = string.find(filepath, pattern_for_test_files)
    local _, _, source_module_name, source_sub_modules, source_filename =
        string.find(filepath, pattern_for_source_files)

    if test_module_name ~= nil then
        -- we are in a test file, go to source file
        local source_filepath = "src/"
            .. test_module_name
            .. "/"
            .. test_sub_modules
            .. "/"
            .. string.sub(test_filename, 6)
        vim.cmd("edit " .. source_filepath)
        return
    elseif source_module_name ~= nil then
        local test_filepath = "src/"
            .. source_module_name
            .. "/tests/"
            .. source_sub_modules
            .. "/test_"
            .. source_filename
        vim.cmd("edit " .. test_filepath)
        return
    else
        vim.notify("Could not determine source/test file path", vim.log.levels.WARN)
    end
end

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
                    -- python-copy-reference
                    vim.keymap.set("n", "<leader>ry", vim.cmd.PythonCopyReferenceDotted, { buffer = args.buf })
                    vim.keymap.set("n", "<leader>ri", vim.cmd.PythonCopyReferenceImport, { buffer = args.buf })
                    vim.keymap.set("n", "<leader>rf", vim.cmd.PythonCopyReferencePytest, { buffer = args.buf })
                    -- custom keymaps
                    vim.keymap.set("n", "<leader>gt", function() switch_source_test() end)
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
    {
        "nvimtools/none-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local null_ls = require("null-ls")

            null_ls.register({
                name = "go to source/test",
                method = { null_ls.methods.CODE_ACTION },
                filetypes = { "python" },
                generator = {
                    fn = function()
                        return {
                            {
                                title = "go to source/test",
                                action = function() switch_source_test() end,
                            },
                        }
                    end,
                },
            })
        end,
    },
}
