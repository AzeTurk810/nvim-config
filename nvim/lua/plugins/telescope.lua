return {
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-telescope/telescope-ui-select.nvim' },
  config = function()
    require('telescope').setup({
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown({})
        }
      }
    })
    require('telescope').load_extension('ui-select')
    require('telescope').load_extension('project')
    require('telescope').load_extension('noice')
  end
}
