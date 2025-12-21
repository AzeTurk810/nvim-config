return {
    'L3MON4D3/LuaSnip',
    dependencies = { "rafamadriz/friendly-snippets" },

    require("luasnip.loaders.from_vscode").load {
        exclude = { "javascript" , "c++" },
    }
}
