return {
    { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
    { "nvim-neotest/nvim-nio" },
    { "nvim-neotest/neotest", dependencies = { "nvim-neotest/nvim-nio", "nvim-lua/plenary.nvim", "antoinemadec/FixCursorHold.nvim", "nvim-treesitter/nvim-treesitter" } },
    {
        "nvim-neotest/neotest-python",
        dependencies = { "nvim-neotest/neotest" },

        config = function()
            local neotest = require("neotest")
            neotest.setup({
                adapters = {
                    require("neotest-python")({
                        dap = { justMyCode = false },
                        args = { "--log-level", "DEBUG" },
                        runner = "pytest",
                        pytest_discover_instances = false,
                    })
                }
            })

            vim.keymap.set("n", "<leader>tt", function() neotest.run.run(vim.fn.expand("%")) end)
            vim.keymap.set("n", "<leader>tT", function() neotest.run.run(vim.uv.cwd()) end)
            vim.keymap.set("n", "<leader>td", function() neotest.run.attach() end)
            vim.keymap.set("n", "<leader>tr", function() neotest.run.run() end)
            vim.keymap.set("n", "<leader>td", function() neotest.run.run({ strategy = "dap" }) end)
            vim.keymap.set("n", "<leader>tl", function() neotest.run.run_last() end)
            vim.keymap.set("n", "<leader>ts", function() neotest.summary.toggle() end)
            vim.keymap.set("n", "<leader>to", function() neotest.output.open({ enter = true, auto_close = true }) end)
            vim.keymap.set("n", "<leader>tO", function() neotest.output_panel.toggle() end)
            vim.keymap.set("n", "<leader>tS", function() neotest.run.stop() end)
            vim.keymap.set("n", "<leader>tw", function() neotest.watch.toggle(vim.fn.expand("%")) end)
        end
    }
}
