vim.g.mapleader = ' '

vim.keymap.set('n', '<leader>w', ':silent w<CR>', { silent = true })
vim.keymap.set('n', '<leader>q', ':q!<CR>', { silent = true })
vim.keymap.set('n', '<leader>e', ':%y+<CR>', { silent = true })
vim.keymap.set('n', '<leader>=', 'gg=G', { silent = true })

vim.keymap.set('n', '<leader>t', ':Telescope<CR>', { silent = true })
vim.keymap.set('n', '<leader>o', ':Telescope lsp_document_symbols<CR>', { silent = true , desc = "funksiyalari gorster"})
vim.keymap.set('n', '<leader>nd', '<cmd>NoiceDismiss<CR>',{desc = "Noice mesajlarini dissmis et"})

vim.api.nvim_set_keymap('n', '<leader>m', ':Dashboard<CR>', { noremap = true, silent = true , desc = "Dashboard a get" })

-- cava
vim.api.nvim_set_keymap('n', '<leader>cv', ':botright 10split | terminal cava<CR>', { noremap = true, silent = true })


-- cmus
vim.api.nvim_set_keymap('n', '<leader>cu', ':terminal cmus<CR>', { noremap = true, silent = true })



vim.keymap.set('n', '<C-h>', ':TmuwNavigateLeft<CR>', { silent = true })
vim.keymap.set('n', '<C-j>', ':TmuxNavigateDown<CR>', { silent = true })
vim.keymap.set('n', '<C-k>', ':TmuxNavigateUp<CR>', { silent = true })
vim.keymap.set('n', '<C-l>', ':TmuxNavigateRight<CR>', { silent = true })

vim.keymap.set('n', '<C-e>', ':Neotree toggle<CR>', { silent = true })

vim.api.nvim_set_keymap('n', '<leader>h', ':bdelete<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>j', ':tabnew<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>k', function()
    -- Close cava terminal split if open
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_option(buf, 'buftype') == 'terminal' then
      local name = vim.api.nvim_buf_get_name(buf)
      if name:match('cava') then
        vim.api.nvim_buf_delete(buf, { force = true })
      end
    end
  end
    vim.cmd('Neotree close')
  vim.cmd('SessionSave')
  vim.cmd('qa')
end, { desc = 'Save session and quit all' })



vim.keymap.set('n', '<C-g>', '', { silent = true })

vim.keymap.set('n', 'K', vim.lsp.buf.hover, { silent = true })
vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, { silent = true })
vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, { silent = true })
vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, { silent = true })
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { silent = true })

vim.keymap.set('n', '<leader>f', function()
  local filename = vim.fn.expand('%:t')
  local extension = vim.fn.expand('%:e')
  local modified = vim.bo.modified and '●' or ''
  local icon, icon_hl = require('nvim-web-devicons').get_icon(filename, extension, { default = true })
  local fullpath = vim.fn.expand('%:p:h')
  local home = vim.fn.expand('~')
  local path = fullpath:gsub('^' .. vim.pesc(home), '~')

  if filename == '' or vim.bo.filetype == 'neo-tree' then
    return
  end

  local message = {
    { modified .. ' ', 'DiagnosticWarn' },
    { icon and (icon .. ' ') or '', icon_hl or 'Normal' },
    { path .. '/', 'Comment' },
    { filename, 'Title' },
  }

  local tick = vim.b.file_info_tick or 0
  tick = (tick + 1) % 2
  vim.b.file_info_tick = tick

  local dummy_hl = tick == 0 and 'Comment' or 'Normal'
  table.insert(message, { ' ', dummy_hl })

  vim.api.nvim_echo(message, false, {})
end, { desc = 'Show full file info' })
