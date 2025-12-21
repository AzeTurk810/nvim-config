return {
  "andweeb/presence.nvim",
  config = function()
    require("presence"):setup({
      neovim_image_text = "Editing with Neovim",
      main_image = "neovim",

      -- Fayl adını gizlədən konfiqurasiya:
      editing_text = "Editing in Neovim", -- Fayl adı olmadan sadə tekst
      file_text = "Editing",             -- Fayl adını göstərməsin
      workspace_text = "Working",        -- Workspace görünsün ya da yox, fərq etmir
      auto_update = false,
      
      -- İstəsən tamamilə neutral bir mesaj belə edə bilərsən:
      -- editing_text = "Neovim is open",
      -- file_text = "Neovim",
    })
  end
}

