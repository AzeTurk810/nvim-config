return {
  "pwntester/octo.nvim",
  cmd = { "Octo" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("octo").setup({
      default_remote = { "upstream", "origin" }, -- order to try remotes
      enable_builtin = true, -- use built-in actions for editing
      picker = "telescope", -- or "fzf-lua"
    })
  end,
  keys = {
    { "<leader>gi", "<cmd>Octo issue list<cr>", desc = "List GitHub Issues" },
    { "<leader>gp", "<cmd>Octo pr list<cr>", desc = "List GitHub PRs" },
    { "<leader>gr", "<cmd>Octo review start<cr>", desc = "Start GitHub Review" },
  },
}

