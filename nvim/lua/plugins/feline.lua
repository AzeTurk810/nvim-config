return {
  "famiu/feline.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "lewis6991/gitsigns.nvim",
    "nvim-neo-tree/neo-tree.nvim",
  },
  config = function()
    vim.o.termguicolors = true
    vim.o.laststatus = 3
    vim.o.mouse = "a"

    local feline = require("feline")
    local vi_mode = require("feline.providers.vi_mode")

    -- Colors
    local colors = {
      bg      = "#1e1e2e",
      fg      = "#cdd6f4",
      yellow  = "#f9e2af",
      cyan    = "#89b4fa",
      green   = "#a6e3a1",
      orange  = "#fab387",
      violet  = "#cba6f7",
      magenta = "#f5c2e7",
      red     = "#f38ba8",
    }

    local vi_mode_colors = {
      NORMAL = colors.green,
      INSERT = colors.cyan,
      VISUAL = colors.magenta,
      OP = colors.violet,
      BLOCK = colors.violet,
      REPLACE = colors.red,
      ["V-REPLACE"] = colors.red,
      ENTER = colors.cyan,
      MORE = colors.cyan,
      SELECT = colors.orange,
      COMMAND = colors.yellow,
      SHELL = colors.green,
      TERM = colors.green,
      NONE = colors.red,
    }

    local components = {
      active = { {}, {}, {} },
      inactive = { {}, {}, {} },
    }

    -- MODE
    table.insert(components.active[1], {
      provider = "vi_mode",
      hl = function()
        return {
          name = vi_mode.get_mode_highlight_name(),
          fg = colors.bg,
          bg = vi_mode.get_mode_color(),
          style = "bold",
        }
      end,
      left_sep = " ",
      right_sep = " ",
    })

    -- Git branch
    table.insert(components.active[1], {
      provider = "git_branch",
      icon = " ",
      hl = { fg = colors.violet, bg = colors.bg },
      right_sep = " ",
      on_click = function()
        vim.cmd("Neotree toggle source=git_status position=left")
      end,
    })

    -- Git diff
    local git_icons = {
      { provider = "git_diff_added",   icon = " ", hl = { fg = colors.green } },
      { provider = "git_diff_removed", icon = " ", hl = { fg = colors.red } },
      { provider = "git_diff_changed", icon = "󰦓 ", hl = { fg = colors.yellow }, right_sep = " " },
    }

    for _, comp in ipairs(git_icons) do
      comp.on_click = function()
        vim.cmd("Neotree toggle source=git_status position=left")
      end
      table.insert(components.active[1], comp)
    end

    -- FILE INFO (middle)
    table.insert(components.active[2], {
      provider = "file_info",
      hl = { fg = colors.fg, bg = colors.bg, style = "bold" },
      left_sep = " ",
      right_sep = " ",
    })

    -- DIAGNOSTICS
    local diagnostics = {
      { provider = "diagnostic_errors",   icon = " ", hl = { fg = colors.red } },
      { provider = "diagnostic_warnings", icon = " ", hl = { fg = colors.yellow } },
      { provider = "diagnostic_info",     icon = " ", hl = { fg = colors.cyan } },
      { provider = "diagnostic_hints",    icon = " ", hl = { fg = colors.violet }, right_sep = " " },
    }

    for _, comp in ipairs(diagnostics) do
      comp.on_click = function()
        vim.cmd("Neotree toggle source=diagnostics position=bottom")
      end
      table.insert(components.active[3], comp)
    end

    -- Cursor position + encoding + format + type
    table.insert(components.active[3], {
      provider = "position",
      hl = { fg = colors.green, bg = colors.bg },
      left_sep = " ",
      right_sep = " ",
    })

    table.insert(components.active[3], {
      provider = "file_encoding",
      hl = { fg = colors.orange },
      right_sep = " ",
    })

    table.insert(components.active[3], {
      provider = "file_format",
      hl = { fg = colors.magenta },
      right_sep = " ",
    })

    table.insert(components.active[3], {
      provider = "file_type",
      hl = { fg = colors.yellow },
      right_sep = " ",
    })

    -- Final setup
    feline.setup({
      components = components,
      theme = colors,
      vi_mode_colors = vi_mode_colors,
    })
  end,
}

