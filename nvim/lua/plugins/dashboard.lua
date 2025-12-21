return {
  'nvimdev/dashboard-nvim',
  config = function()
      -- local start_time = vim.g.startup_time or vim.loop.hrtime()
      -- vim.api.nvim_create_autocmd("VimEnter", {
      --     once = true,
      --     callback = function()
      --         local elapsed_ms = (vim.loop.hrtime() - start_time) / 1e6
      --         local plugins = vim.tbl_count(package.loaded) -- rough plugin count
      --         vim.g.startup_stats = { plugins = plugins, time = elapsed_ms }
      --     end,
      -- })
      --
      -- Then inside your dashboard config
      -- local plugin_count = vim.g.startup_stats and vim.g.startup_stats.plugins or 0
      -- local startup_time = vim.g.startup_stats and vim.g.startup_stats.time or 0
      require('dashboard').setup({
      theme = 'doom',
      config = {
          -- header = {
          --     '',
          --     '    ████▌█████▌█ ████████▐▀██▀    ',
          --     '  ▄█████ █████▌ █ ▀██████▌█▄▄▀▄   ',
          --     '  ▌███▌█ ▐███▌▌  ▄▄ ▌█▌███▐███ ▀  ',
          --     ' ▐ ▐██  ▄▄▐▀█   ▐▄█▀▌█▐███▐█      ',
          --     '   ███ ▌▄█▌  ▀  ▀██  ▀██████▌     ',
          --     '    ▀█▌▀██▀ ▄         ███▐███     ',
          --     '     ██▌             ▐███████▌    ',
          --     '     ███     ▀█▀     ▐██▐███▀▌    ',
          --     '     ▌█▌█▄         ▄▄████▀ ▀      ',
          --     '       █▀██▄▄▄ ▄▄▀▀▒█▀█           ',
          --     '',
          -- },
        header = {
          '',
          '',
          '',
          '',
          '',
          '                                                                   ',
          '      ████ ██████           █████      ██                    ',
          '     ███████████             █████                            ',
          '     █████████ ███████████████████ ███   ███████████  ',
          '    █████████  ███    █████████████ █████ ██████████████  ',
          '   █████████ ██████████ █████████ █████ █████ ████ █████  ',
          ' ███████████ ███    ███ █████████ █████ █████ ████ █████ ',
          '██████  █████████████████████ ████ █████ █████ ████ ██████',
          '',
          '',
          '',
          '',
          '',
        },
        center = {
          {
            icon = '  ',
            desc = 'Open File          ',
            key = 'a',
            action = function()
              vim.ui.input({ prompt = 'File name: ' }, function(input)
                if input and input ~= '' then
                  vim.cmd('e ' .. input)
                end
              end)
            end,
          },
          {
            icon = '  ',
            desc = 'File Explorer      ',
            key = 'e',
            action = 'Neotree toggle'
          },
          {
            icon = '  ',
            desc = 'Find Files         ',
            key = 'f',
            action = 'Telescope find_files'
          },
          {
            icon = '  ',
            desc = 'Recent Files       ',
            key = 'r',
            action = 'Telescope oldfiles'
          },
          {
              icon = '  ',         -- Folder icon (or choose any icon you like)
              desc = 'Projects           ',
              key = 'p',
              action = 'Telescope project'
          },
          {
            icon = '  ',
            desc = 'Last Session       ',
            key = 'l',
            action = function()
              require("auto-session").RestoreSession()
            end
          },
          {
              icon = '󰈞  ',
              desc = 'Search Session     ',
              key = 's',
              action = function()
                  require("telescope").extensions["session-lens"].search_session()
              end
          },
          {
            icon = '  ',
            desc = 'Config             ',
            key = 'c',
            action = 'e ~/.config/nvim'
          },
          {
            icon = '  ',
            desc = 'Quit               ',
            key = 'q',
            action = 'qa'
          }
        },
        -- footer = {
            -- local stats = require("lazy").stats()
            -- local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            -- return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
            -- string.format('Neovim loaded %d plugins in %.2f ms', plugin_count, startup_time)
        -- }
        -- footer = function()
            -- local stats = require("lazy").stats()
            -- local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            -- return "⚡ Neovim loaded " .. stats.loaded .. " plugins in " .. ms .. " ms"
        -- end,

      },
    })
  end
}
