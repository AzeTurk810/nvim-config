return {
  "nvim-lualine/lualine.nvim",
  enabled = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup {
      options = {
        theme = "auto",
        section_separators = '',
        component_separators = '',
      },
    }
  end
}

