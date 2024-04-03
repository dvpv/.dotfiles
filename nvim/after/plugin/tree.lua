require("neo-tree").setup({
    event_handlers = {
        {
            event = "file_opened",
            handler = function(file_path)
                require("neo-tree.command").execute({ action = "close" })
            end
        },
    },
    close_if_last_window = true,
    popup_border_style = "NC",
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
    },
    window = {
        position = "right"
    }
})

vim.keymap.set("n", "<C-B>", "<cmd>Neotree source=filesystem reveal=true position=right toggle=true<CR>")
