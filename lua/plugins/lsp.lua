return {
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
        -- lsp menu
        "j-hui/fidget.nvim",
        -- lsp message inline
        "folke/trouble.nvim",
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
                "pyright",
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

        require("trouble").setup({
            icons = false,
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            mapping = cmp.mapping.preset.insert({
                ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
                ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
                ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
            }, {
                { name = "buffer" },
            }),
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

        vim.keymap.set("n", "<leader>tt", function() require("trouble").toggle() end)
        vim.keymap.set("n", "[t", function() require("trouble").next({ skip_groups = true, jump = true }) end)
        vim.keymap.set("n", "]t", function() require("trouble").previous({ skip_groups = true, jump = true }) end)
    end,
}
