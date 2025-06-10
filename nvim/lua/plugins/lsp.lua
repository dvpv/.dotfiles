return {
    { "nvim-treesitter/nvim-treesitter", branch = "master", lazy = false, build = ":TSUpdate" },
    { "nvim-treesitter/playground" },
    { "nvim-lua/plenary.nvim" },
    {
        "neovim/nvim-lspconfig",
        config = function()
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
                callback = function(args)
                    local opts = { buffer = args.buf }
                    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
                    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
                    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
                    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
                    vim.keymap.set("n", "<leader>vD", function() vim.diagnostic.setloclist() end, opts)
                    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
                    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
                    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
                    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
                    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
                    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
                    vim.keymap.set({ "n", "x" }, "gq", function()
                        vim.lsp.buf.format({
                            async = false,
                            timeout_ms = 10000,
                        })
                    end
                    )
                    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
                    if client:supports_method("textDocument/implementation") then
                    end
                    if client:supports_method("textDocument/completion") then
                        vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = false })
                    end
                    if not client:supports_method("textDocument/willSaveWaitUntil")
                        and client:supports_method("textDocument/formatting") then
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            group = vim.api.nvim_create_augroup("my.lsp", { clear = false }),
                            buffer = args.buf,
                            callback = function()
                                vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
                            end,
                        })
                    end
                end
            })
        end
    },
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = { "mason-org/mason.nvim" },
        config = function()
            require("mason").setup({})
            require("mason-lspconfig").setup({
                handlers = {
                    function(server_name)
                        local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
                        local lspconfig = require("lspconfig")
                        if server_name == "kotlin_language_server" then
                            lspconfig[server_name].setup({
                                capabilities = lsp_capabilities,
                                settings = {
                                    kotlin = {
                                        compiler = {
                                            jvm = {
                                                target = "1.7"
                                            }
                                        }
                                    }
                                }
                            })
                        else
                            lspconfig[server_name].setup({
                                capabilities = lsp_capabilities,
                            })
                        end
                    end,
                }
            })
        end
    },
    {
        "hrsh7th/nvim-cmp",
        config = function()
            local cmp = require("cmp")
            local cmp_select = { behavior = cmp.SelectBehavior.Select }
            cmp.setup({
                sources = {
                    { name = "nvim_lsp" },
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
                    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
                    ["<Tab>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-d>"] = cmp.mapping.scroll_docs(4),
                }),
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
            })
        end
    },
    { "hrsh7th/cmp-nvim-lsp" },
    { "L3MON4D3/LuaSnip" },
    { "mfussenegger/nvim-dap", "jay-babu/mason-nvim-dap.nvim" },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")
            dapui.setup()
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
            vim.keymap.set("n", "<leader>db", vim.cmd.DapToggleBreakpoint)
            vim.keymap.set("n", "<leader>dr", vim.cmd.DapContinue)
            vim.keymap.set("n", "<leader>dso", vim.cmd.DapStepOver)
            vim.keymap.set("n", "<leader>dsO", vim.cmd.DapStepOut)
            vim.keymap.set("n", "<leader>dsi", vim.cmd.DapStepInto)
            require("mason-nvim-dap").setup({
                ensure_installed = { "codelldb" },
                handlers = {},
            })
            require("dap.ext.vscode").load_launchjs(nil, { cppdbg = { "c", "cpp" } })
            dap.adapters.gdb = {
                type = "executable",
                command = "gdb",
                args = { "-i", "dap" }
            }
            dap.adapters.cppdbg = {
                type = "executable",
                command = "gdb",
                args = { "-i", "dap" }
            }
        end
    },
}
