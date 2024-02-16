local tree = require("neo-tree").setup({
    default_component_configs = {
        icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "",
        }
    },
    filesystem = {
        filtered_items = {
            hide_hidden = false,
            hide_dotfiles = false,
            hide_gitignored = true,
        },
        hide_by_pattern = {
            "**/__pycache__/**",
        }
    }
})



vim.keymap.set("n", "<C-B>", "<cmd>Neotree source=filesystem reveal=true position=left toggle=true<CR>")


