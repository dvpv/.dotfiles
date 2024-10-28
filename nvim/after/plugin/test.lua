local neotest = require("neotest")
neotest.setup({
    adapters = {
        require("neotest-python")({
            -- Extra arguments for nvim-dap configuration
            -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
            dap = { justMyCode = false },
            -- Command line arguments for runner
            -- Can also be a function to return dynamic values
            args = { "--log-level", "DEBUG" },
            -- Runner to use. Will use pytest if available by default.
            -- Can be a function to return dynamic value.
            runner = "pytest",
            -- Custom python path for the runner.
            -- Can be a string or a list of strings.
            -- Can also be a function to return dynamic value.
            -- If not provided, the path will be inferred by checking for
            -- virtual envs in the local directory and for Pipenev/Poetry configs
            -- python = ".venv/bin/python",
            -- Returns if a given file path is a test file.
            -- NB: This function is called a lot so don't perform any heavy tasks within it.
            -- is_test_file = function(file_path)
            -- end,
            -- !!EXPERIMENTAL!! Enable shelling out to `pytest` to discover test
            -- instances for files containing a parametrize mark (default: false)
            pytest_discover_instances = false,
        })
    }
})

vim.keymap.set("n", "<leader>tt", function() neotest.run.run(vim.fn.expand("%")) end)
vim.keymap.set("n", "<leader>tT", function() neotest.run.run(vim.uv.cwd()) end)
vim.keymap.set("n", "<leader>td", function() neotest.run.attach() end)
vim.keymap.set("n", "<leader>tr", function() neotest.run.run() end)
vim.keymap.set("n", "<leader>tl", function() neotest.run.run_last() end)
vim.keymap.set("n", "<leader>ts", function() neotest.summary.toggle() end)
vim.keymap.set("n", "<leader>to", function() neotest.output.open({ enter = true, auto_close = true }) end)
vim.keymap.set("n", "<leader>tO", function() neotest.output_panel.toggle() end)
vim.keymap.set("n", "<leader>tS", function() neotest.run.stop() end)
vim.keymap.set("n", "<leader>tw", function() neotest.watch.toggle(vim.fn.expand("%")) end)
