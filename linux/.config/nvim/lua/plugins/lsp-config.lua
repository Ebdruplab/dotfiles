-- lsp setup is done manually using npm
-- mason
return {
    {
        "williamboman/mason.nvim",
        lazy = false,
        config = function()
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            })
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = false,
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "bashls",
                    "ansiblels",
                    "pyright",
                    "sqlls",
                    "helm_ls",
                    "html",
                },
                automatic_installation = true,
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()
            local lspconfig = require("lspconfig")

            -- lua
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                settings = { -- custom settings for lua
                    Lua = {
                        -- make the language server recognize "vim" global
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            -- make language server aware of runtime files
                            library = {
                                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                [vim.fn.stdpath("config") .. "/lua"] = true,
                            },
                        },
                    },
                },
            })
            -- html
            lspconfig.html.setup({})

            -- bash, shell, zsh
            lspconfig.bashls.setup({
                capabilities = bilities,
                on_attach = on_attach,
                filetypes = { "sh" },
            })
            -- python
            lspconfig.pyright.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    pyright = {
                        disableOrganizeImports = false,
                        analysis = {
                            useLibraryCodeForTypes = true,
                            autoSearchPaths = true,
                            diagnosticMode = "workspace",
                            autoImportCompletions = true,
                        },
                    },
                },
            })
            -- ansible
            lspconfig.ansiblels.setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })

            -- sql
            lspconfig.sqlls.setup({})

            -- helm
            lspconfig.helm_ls.setup({})

            -- docker
            lspconfig.dockerls.setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })


            -- Keymappings
            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
            vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
            vim.keymap.set("n", "<leader>ga", vim.lsp.buf.code_action, {})
        end,
    },
}
