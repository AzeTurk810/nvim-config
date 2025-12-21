return {
  "folke/todo-comments.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    signs = true, -- show icons in the sign column
    keywords = {
      FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG" } },
      TODO = { icon = " ", color = "info" },
      HACK = { icon = " ", color = "warning" },
      WARN = { icon = " ", color = "warning", alt = { "WARNING" } },
      PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
      NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
    },
    highlight = {
      before = "",
      keyword = "wide",
      after = "fg",
      pattern = [[.*<(KEYWORDS)\s*:]],
      comments_only = true,
      max_line_len = 400,
    },
    search = {
      command = "rg",
      args = {
        "--color=never", "--no-heading", "--with-filename", "--line-number", "--column",
      },
      pattern = [[\b(KEYWORDS):]],
    },
  },
  keys = {
    { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Search TODOs" },
  },
}

