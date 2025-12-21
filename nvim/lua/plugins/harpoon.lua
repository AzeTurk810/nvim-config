return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup()

        -- Faylı bookmark et (<leader>z)
        vim.keymap.set("n", "<leader>z", function()
            harpoon:list():add()
            print("✅ File bookmarked")
        end, { desc = "Bookmark file" })

        -- Bookmark siyahısını aç (<leader>x)
        vim.keymap.set("n", "<leader>x", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end, { desc = "Show bookmarks" })

        -- Sürətli keçidlər (1–4)
        vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
        vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
        vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
        vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)
    end
}

