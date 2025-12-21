return {
    'folke/noice.nvim',
    dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "MunifTanjim/nui.nvim",
        -- OPTIONAL:
        --   `nvim-notify` is only needed, if you want to use the notification view.
        --   If not available, we use `mini` as the fallback
        "rcarriga/nvim-notify",
    },
    
    config = function()
        require('notify').setup({
            background_colour = "#000000",
        });
        require('noice').setup({
            lsp = {
                signature = {
                    enabled = false,
                },
            },
            cmdline = {
                enabled = true,
                view = 'cmdline_popup'
            },
            views = {
                cmdline_popup = {
                    position = {
                        row = '95%',
                        col = '50%'
                    }
                }
            },
            messages = {
                enabled = true,
            },
        })
    end
}
