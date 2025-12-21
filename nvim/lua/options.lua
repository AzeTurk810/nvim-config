vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.mouse = 'a'

vim.opt.laststatus = 0
vim.opt.statusline = ' '

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.signcolumn = 'no'

-- vim.o.wildmenu = true
-- vim.o.wildmode = 'list:longest,full'
-- vim.o.wildoptions = 'pum' -- show as popup menu
-- vim.o.pumblend = 10       -- transparency

vim.api.nvim_create_autocmd("TabNewEntered", {
  callback = function()
    vim.cmd("Dashboard")
  end,
})



vim.opt.fillchars:append({ eob = ' ' })

vim.opt.updatetime = 200
