local telescope = require('telescope')
telescope.setup({
    defaults = {
        file_ignore_patterns = {
            "build",
            "thirdparty",
            ".git",
            ".cache",
        },
    },
    pickers = {
        find_files = {
            hidden = true,
        },
    },
})
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>pg', builtin.live_grep, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
