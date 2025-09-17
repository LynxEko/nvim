local home = "/Users/erikvillarrealgallardo"

return {
    "mfussenegger/nvim-jdtls",
    config = function()
        local java_group = vim.api.nvim_create_augroup("java_group", {})
        local autocmd = vim.api.nvim_create_autocmd

        local jdtls = require("jdtls")

        local on_attach = function(client, bufnr)
            local bufopts = { noremap = true, silent = true, buffer = bufnr }

            vim.keymap.set("n", "<leader>o", jdtls.organize_imports, bufopts)
            vim.keymap.set("n", "<leader>ev", jdtls.extract_variable, bufopts)
            vim.keymap.set("n", "<leader>ec", jdtls.extract_constant, bufopts)
            vim.keymap.set("v", "<leader>em", function() jdtls.extract_method(true) end, bufopts)
        end

        autocmd("FileType", {
            group = java_group,
            pattern = "java",
            callback = function(args)
                local root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1])
                local workspace_folder = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
                local config = {
                    cmd = {
                        home .. "/.sdkman/candidates/java/21.0.8-tem/bin/java",
                        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
                        "-Dosgi.bundles.defaultStartLevel=4",
                        "-Declipse.product=org.eclipse.jdt.ls.core.product",
                        "-Dlog.protocol=true",
                        "-Dlog.level=ALL",
                        "-Xmx4g",
                        "--add-modules=ALL-SYSTEM",
                        "--add-opens",
                        "java.base/java.util=ALL-UNNAMED",
                        "--add-opens",
                        "java.base/java.lang=ALL-UNNAMED",
                        "-jar",
                        vim.fn.glob(
                            "/opt/homebrew/Cellar/jdtls/1.48.0/libexec/plugins/org.eclipse.equinox.launcher_*.jar"
                        ),
                        "-configuration",
                        "/opt/homebrew/Cellar/jdtls/1.48.0/libexec/config_mac",
                        "-data",
                        workspace_folder,
                    },
                    on_attach = on_attach,
                    root_dir = root_dir,
                    settings = {
                        java = {
                            signatureHelp = { enabled = true },
                            sources = {
                                organizeImports = {
                                    starThreshold = 99,
                                    staticStarThreshold = 99,
                                },
                            },
                        },
                    },
                }

                jdtls.start_or_attach(config)
            end,
        })
    end,
}
