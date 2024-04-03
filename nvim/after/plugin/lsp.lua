local lsp_zero = require('lsp-zero')
lsp_zero.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp_zero.default_keymaps({ buffer = bufnr })
    lsp_zero.buffer_autoformat()

    local opts = { buffer = bufnr, remap = false }

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
            --   filter = allow_format({'clang-format'}) -- Allow only selected servers
        })
    end, opts)
end)

-- Format on save
-- lsp_zero.format_on_save({
--     format_opts = {
--         async = false,
--         timeout_ms = 10000,
--     },
--     servers = {
--         ['clang-format'] = {'cpp'},
--         ['flake8'] = {'py'},
-- --        ['black'] = {'py'},
--     }
-- })

require('mason').setup({})
require('mason-lspconfig').setup({
    handlers = {
        lsp_zero.default_setup,
        lua_ls = function()
            -- (Optional) configure lua language server
            local lua_opts = lsp_zero.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
        end,
    }
})

local cmp = require('cmp')
local cmp_action = lsp_zero.cmp_action()
local cmp_select = { behavior = cmp.SelectBehavior.Select }
cmp.setup({
    mapping = cmp.mapping.preset.insert({
        -- Ctrl+Space to trigger completion menu
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        -- ['<C-y>'] = cmp.mapping.confirm({select = true}),
        ['<Tab>'] = cmp.mapping.confirm({ select = true }),
        -- ['<CR>'] = cmp.mapping.confirm({select = false}),

        -- Navigate between snippet placeholder
        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        ['<C-b>'] = cmp_action.luasnip_jump_backward(),

        -- Scroll up and down in the completion documentation
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
    })
})

local dap = require('dap')
local dapui = require('dapui')
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
vim.keymap.set("n", "<leader>dsr", vim.cmd.DapStepOut)
vim.keymap.set("n", "<leader>dsi", vim.cmd.DapStepInto)

require("mason-nvim-dap").setup({
    ensure_installed = { "codelldb" },
    handlers = {},
})

require('dap.ext.vscode').load_launchjs(nil, { cppdbg = { 'c', 'cpp' } })

dap.adapters.gdb = {
    type = 'executable',
    command = 'gdb',
    args = { '-i', 'dap' }
}

dap.adapters.cppdbg = {
    type = 'executable',
    command = 'gdb',
    args = { '-i', 'dap' }
}
