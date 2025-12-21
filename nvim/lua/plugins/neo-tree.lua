return {
  'nvim-neo-tree/neo-tree.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('neo-tree').setup({ 
        window = {
            position = "right",  -- "left", "right", "top", "bottom"
            width = 30,
        },
      default_component_configs = {
        git_status = {
          symbols = {
            added     = '',
            modified  = '',
            deleted   = '',
            renamed   = '',
            untracked = '',
            ignored   = '',
            unstaged  = '',
            staged    = '',
            conflict  = '',
          }
        },
        modified = {
          symbol = '●',
          highlight = 'NeoTreeModified',
        },
      },
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },

    })
  end
}
