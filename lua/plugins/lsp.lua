return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            -- lsp downloader
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            -- completion
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/nvim-cmp",
            "onsails/lspkind.nvim",
            -- lsp menu
            "j-hui/fidget.nvim",
            -- snippets
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },

        config = function()
            local cmp = require("cmp")
            local cmp_lsp = require("cmp_nvim_lsp")
            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                cmp_lsp.default_capabilities()
            )

            require("fidget").setup({})
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    -- lua
                    "lua_ls",
                    -- rust
                    "rust_analyzer",
                    -- python
                    -- javascript, typescript
                    -- "vtsls",
                },
            })
            vim.lsp.config("lua_ls", {
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim" } },
                    },
                },
            })
            vim.lsp.config("pyright", { capabilities = capabilities })
            vim.lsp.config("vtsls", {
                capabilities = capabilities,
                settings = {
                    typescript = {},
                    vtsls = {
                        autoUseWorkspaceTsdk = true,
                    },
                },
            })

            local cmp_select = { behavior = cmp.SelectBehavior.Select }

            local lspkind = require("lspkind")
            lspkind.init({
                symbol_map = {
                    Copilot = "",
                },
            })

            cmp.setup({
                snippet = {
                    expand = function(args) require("luasnip").lsp_expand(args.body) end,
                },

                mapping = cmp.mapping.preset.insert({
                    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
                    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
                    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "copilot", group_index = 2 },
                }, {
                    { name = "buffer" },
                }),
                formatting = {
                    format = lspkind.cmp_format({
                        format = lspkind.cmp_format({
                            mode = "symbol_text",
                            menu = {
                                nvim_lsp = "[LSP]",
                                luasnip = "[LuaSnip]",
                                copilot = "[Copilot]",
                                buffer = "[Buffer]",
                            },
                        }),
                    }),
                },
            })

            vim.diagnostic.config({
                virtual_text = true,
                float = {
                    focusable = false,
                    style = "minimal",
                    border = "rounded",
                    source = "always",
                    header = "",
                    prefix = "",
                },
            })
        end,
    },
    {
        "nvimtools/none-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup()
        end,
    },
}
