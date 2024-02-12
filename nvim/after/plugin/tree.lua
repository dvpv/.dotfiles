local tree = require("neo-tree").setup({
    default_component_configs = {
        icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "",
        }
    },
})



vim.keymap.set("n", "<C-B>", "<cmd>Neotree source=filesystem reveal=true position=left toggle=true<CR>")


