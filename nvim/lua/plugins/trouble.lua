-- ~/.config/nvim/lua/plugins.lua
-- Lazy.nvim minimal konfiqurasiya nümunəsi

-- Pluginləri qeyd edirik
return {
  -- Lazy.nvim özü əgər quraşdırılıbsa, buraya yazmaya da bilərsən
  {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        -- default parametrlər
        position = "bottom", -- "bottom" or "right"
        height = 10,         -- hündürlük (bottom üçün)
        width = 50,          -- genişlik (right üçün)
        icons = true,
        mode = "workspace_diagnostics", -- default view
      }

      -- shortcut-lar
      vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>TroubleToggle<cr>", {silent=true, noremap=true})
      vim.api.nvim_set_keymap("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", {silent=true, noremap=true})
      vim.api.nvim_set_keymap("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", {silent=true, noremap=true})
      vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", {silent=true, noremap=true})
      vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", {silent=true, noremap=true})
    end
  },
}

