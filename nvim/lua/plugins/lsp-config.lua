return {
    -- Setup mason
    -- Setup mason
    {
        "williamboman/mason.nvim",
        lazy = false,
        config = function()
            local packages = {
                "black",
                "isort",
                "textlint",
                "clang-format",
                "checkmake",
                "shfmt",
                "sqlfluff",
                "stylua",
            }

            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            })

            -- Install all packages in one command
            local registry = require("mason-registry")
            local function ensure_installed()
                for _, package in ipairs(packages) do
                    if not registry.is_installed(package) then
                        vim.cmd("MasonInstall " .. package)
                    end
                end
            end

            -- Run the installation
            ensure_installed()
        end,
    },
    -- Setup lspconfig
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = false,
        opts = {
            auto_install = true,
        },
        config = function()
            require("mason-lspconfig").setup({
                -- A list of servers, formatters and linters to automatically install if they're not already installed
                ensure_installed = { "pyright", "lua_ls", "clangd", "texlab", "bashls", "sqlls" },
            })
        end,
    },
    -- Setup nvim-lspconfig
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            capabilities.offsetEncoding = { "utf-8" }
            local clangd_capabilities = vim.tbl_deep_extend("force", capabilities, { offsetEncoding = { "utf-8" } })

            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
            })
            lspconfig.pyright.setup({
                capabilities = capabilities,
            })
            lspconfig.clangd.setup({
                capabilities = clangd_capabilities,
                cmd = { "clangd", "--compile-commands-dir=build" },
                settings = {
                    clangd = {
                        compileCommands = "build/compile_commands.json", -- Point to the right path if needed
                        includePaths = {
                            "/opt/homebrew/include",                     -- For Apple Silicon
                        },
                    },
                },
            })
            lspconfig.texlab.setup({
                capabilities = capabilities,
            })
            lspconfig.bashls.setup({
                capabilities = capabilities,
            })
            lspconfig.glsl_analyzer.setup({
                capabilities = clangd_capabilities,
            })
            lspconfig.sqlls.setup({
                capabilities = clangd_capabilities,
            })
            -- KEYBINDS
            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
            vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
        end,
    },
}
