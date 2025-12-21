return {
  -- CMake Tools
  {
    "Civitasv/cmake-tools.nvim",
    ft = { "c", "cpp" },        -- yalnız C/C++ açılınca yüklə
    dependencies = {
      "nvim-lua/plenary.nvim",
      "akinsho/toggleterm.nvim", -- terminal dependency
    },
    config = function()
      require("cmake-tools").setup({
        cmake_command = "cmake", -- sistemdə cmake olmalıdır
        cmake_build_directory = "build",
        cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
        cmake_build_options = {},
        cmake_soft_link_compile_commands = true,
        cmake_regenerate_on_save = true,
      })
    end,
  },

  -- ToggleTerm
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = { "ToggleTerm", "TermExec" }, -- lazy load
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<c-\>]],
        direction = "float", -- float / horizontal / vertical
        float_opts = {
          border = "rounded",
        },
      })
    end,
  },
}

