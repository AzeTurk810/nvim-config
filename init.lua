local opt = vim.opt
opt.termguicolors = true
opt.number = true
vim.cmd [[
    highlight Normal guibg=NONE ctermbg=NONE
    highlight NonText guibg=NONE ctermbg=NONE
    highlight NormalNC guibg=NONE ctermbg=NONE
    highlight LineNr guibg=NONE ctermbg=NONE
    highlight EndOfBuffer guibg=NONE ctermbg=NONE
]]

opt.relativenumber = true

opt.tabstop = 4         
opt.shiftwidth = 4     
opt.expandtab = true  
opt.autoindent = true
opt.smartindent = true
opt.cindent = true
opt.smarttab = true
opt.softtabstop = 4

opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true
opt.wrap = false    
opt.signcolumn = 'yes'
opt.showmode = false
opt.showcmd = false


opt.updatetime = 200
require("plugins.lazy")


