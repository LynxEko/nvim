local switch_source = function(folder, file_prefix, extensions)
    file_prefix = file_prefix or ""
    extensions = extensions or { "py" }
    if folder == nil then
        -- error
        vim.notify("Error in configuration `folder` argument is required", vim.log.levels.ERROR)
        return
    end
    local filepath = vim.fn.expand("%")
    -- matches
    -- src/module/test/something/something/test_file.py
    --    1^^^^^^     2^^^^^^^^^^^^^^^^^^^3^^^^^^^^^^^^
    local pattern_for_files = "src/([%a%d_]*)/" .. folder .. "/([%a%d_/]*)/(" .. file_prefix .. "[%a%d_]*.py)"
    -- matches
    -- src/module/something/something/file.py
    --    1^^^^^^2^^^^^^^^^^^^^^^^^^^3^^^^^^^
    local pattern_for_source_files = "src/([%a%d_]*)/([%a%d_/]*)/([%a%d_]*.py)"

    local _, _, module_name, sub_modules, filename = string.find(filepath, pattern_for_files)
    local _, _, source_module_name, source_sub_modules, source_filename =
        string.find(filepath, pattern_for_source_files)

    if module_name ~= nil then
        -- we are in a test file, go to source file
        local source_filepath = "src/"
            .. module_name
            .. "/"
            .. sub_modules
            .. "/"
            .. string.gsub(filename, file_prefix, "")
        vim.cmd("edit " .. source_filepath)
        return
    elseif source_module_name ~= nil then
        local other_filepath = "src/"
            .. source_module_name
            .. "/"
            .. folder
            .. "/"
            .. source_sub_modules
            .. "/"
            .. file_prefix
            .. source_filename
        vim.cmd("edit " .. other_filepath)
        return
    else
        vim.notify("Could not determine source/" .. folder .. " file path", vim.log.levels.WARN)
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
                    vim.keymap.set("n", "<leader>rt", vim.cmd.PythonCopyReferencePytest, { buffer = args.buf })
                    -- custom keymaps
                    vim.keymap.set("n", "<leader>t", function() switch_source("tests", "test_") end)
                    vim.keymap.set("n", "<leader>d", function() switch_source("_dependency_injection") end)
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
