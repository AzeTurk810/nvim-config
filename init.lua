-- Set leader key before any mappings
vim.g.mapleader = ' '

-- Lazy.nvim bootstrap (unchanged)
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)
vim.keymap.set("n", "<C-r>", function()
  -- 1) Faylı saxla, ki, g++ həmişə son versiyanı tutsun
  vim.cmd("write")

  -- 2) Ad və tam yol
  local file = vim.fn.expand("%:t:r")
  local path = vim.fn.expand("%")

  -- 3) Bir bash -lc içində:
  --    a) g++ əmri stderr-i də stdout-a yönləndirir (2>&1)
  --    b) compile uğurlu olsa icra et, əks halda mesaj ver
  local bash_cmd = string.format([[
    bash -lc %q
  ]],
    -- `&&` və `||` ilə axını idarə edirik
    string.format(
      "g++ -std=c++17 -Wall -Wextra -O2 %q -o %q 2>&1 && echo '\\n✅ Compilation succeeded, running...' && ./%s || echo '\\n❌ Compilation failed.'",
      path, file, file
    )
  )

  -- 4) Yeni split açıb, terminalda bütün çıxışı göstər
  vim.cmd("split")
  vim.cmd("terminal " .. bash_cmd)
end, { noremap = true })


vim.keymap.set("n", "<C-m>", function()
  local file = vim.fn.expand("%:t:r")
  local path = vim.fn.expand("%")
  local exec = "./" .. file

  -- Compile
  local compile_cmd = string.format("g++ -std=c++17 -Wall -Wextra -O2 %s -o %s", path, file)
  vim.cmd("!" .. compile_cmd)

  -- Prepare script for running test cases
  local script = [[
#!/bin/bash
i=0
while [ -f input${i}.txt ]; do
  echo "== Test Case $i =="
  ./%s < input${i}.txt > out${i}.txt
  if [ -f output${i}.txt ]; then
    diff -q output${i}.txt out${i}.txt > /dev/null
    if [ $? -eq 0 ]; then
      echo "✅ Passed"
    else
      echo "❌ Failed"
      echo "Expected:"
      cat output${i}.txt
      echo "Got:"
      cat out${i}.txt
    fi
  else
    echo "⚠️  output${i}.txt not found"
  fi
  echo ""
  i=$((i+1))
done
]]

  -- Write and run temporary test script
  local script_path = "/tmp/vim_test_runner.sh"
  local f = io.open(script_path, "w")
  f:write(string.format(script, file))
  f:close()
  os.execute("chmod +x " .. script_path)

  -- Run test script in terminal
  vim.cmd("split | terminal bash " .. script_path)
end, { noremap = true, silent = true })

vim.keymap.set("n", "<C-,>", function()
  local i = 0
  while vim.fn.filereadable("input" .. i .. ".txt") == 1 do
    i = i + 1
  end
  local input_path = "input" .. i .. ".txt"
  local output_path = "output" .. i .. ".txt"

  local input = io.open(input_path, "w")
  local output = io.open(output_path, "w")

  input:write("-- input " .. i .. " buraya yaz\n")
  output:write("-- output " .. i .. " buraya yaz\n")

  input:close()
  output:close()

  print("✅ Test " .. i .. " yaradıldı: " .. input_path .. " / " .. output_path)
  vim.cmd("edit " .. input_path)
end, { noremap = true, silent = true })


-- Bütün testləri sil: <C-.>
vim.keymap.set("n", "<C-.>", function()
  local deleted = os.execute("rm -f input*.txt output*.txt out*.txt")
  if deleted then
    print("🧹 Bütün test faylları silindi")
  else
    print("⚠️ Silmə zamanı problem oldu")
  end
end, { noremap = true, silent = true })

-- plugin/test_commands.lua
-- User commands for competitive programming test management

-- Create test cases, clear tests, run tests, list tests, edit specific test
local fn = vim.fn
local api = vim.api

-- Add a new test: inputN.txt and outputN.txt
local function create_test_case()
  local i = 0
  while fn.filereadable("input" .. i .. ".txt") == 1 do i = i + 1 end
  local in_path = "input" .. i .. ".txt"
  local out_path = "output" .. i .. ".txt"
  -- initialize with example content
  local f_in = io.open(in_path, "w")
  local f_out = io.open(out_path, "w")
  f_in:write("3 5\n")   -- example input
  f_out:write("8\n")    -- expected output
  f_in:close(); f_out:close()
  print(string.format("✅ Test %d created: %s / %s", i, in_path, out_path))
  -- open both files side by side
  vim.cmd("edit " .. in_path)
  vim.cmd("vsplit " .. out_path)
end
api.nvim_create_user_command('TestAdd', create_test_case, {desc = 'Create new test case files and open them'})

-- Clear all tests: remove input*.txt, output*.txt, out*.txt
local function clear_all_tests()
  local ok = os.execute('rm -f input*.txt output*.txt out*.txt')
  if ok then
    print('🧹 All test files removed')
  else
    print('⚠️ Error removing test files')
  end
end
api.nvim_create_user_command('TestClear', clear_all_tests, {desc = 'Delete all test files'})

-- List existing tests
local function list_tests()
  print('🔍 Available test cases:')
  local i = 0
  while fn.filereadable("input" .. i .. ".txt") == 1 do
    print(string.format("  - %d: input%d.txt / output%d.txt", i, i, i))
    i = i + 1
  end
  if i == 0 then print('  (none)') end
end
api.nvim_create_user_command('TestList', list_tests, {desc = 'List all test cases'})

-- Edit a specific test case: opens inputN and outputN
local function edit_test(opts)
  local idx = tonumber(opts.args)
  if not idx then
    print('⚠️ Usage: :TestEdit <number>')
    return
  end
  local in_path = "input" .. idx .. ".txt"
  local out_path = "output" .. idx .. ".txt"
  if fn.filereadable(in_path) ~= 1 then
    print('⚠️ ' .. in_path .. ' not found')
    return
  end
  vim.cmd("edit " .. in_path)
  vim.cmd("vsplit " .. out_path)
end
api.nvim_create_user_command('TestEdit', edit_test, {nargs = 1, desc = 'Edit a specific test case by index'})

-- Run all test cases against current buffer's compiled program
local function run_tests()
  -- get file name and compile
  local file = fn.expand('%:t:r')
  local path = fn.expand('%')
  local exec = './' .. file
  -- compile
  vim.cmd('!' .. string.format('g++ -std=c++17 -Wall -Wextra -O2 %s -o %s', path, file))
  -- run each test
  local i = 0
  while fn.filereadable("input" .. i .. ".txt") == 1 do
    print(string.format("== Test %d ==", i))
    -- run and capture
    os.execute(exec .. ' < input' .. i .. '.txt > out' .. i .. '.txt')
    if fn.filereadable('output' .. i .. '.txt') == 1 then
      -- show diff inline
      local diff_cmd = string.format('diff --color output%d.txt out%d.txt || true', i, i)
      os.execute(diff_cmd)
    else
      print('⚠️ output' .. i .. '.txt not found')
    end
    i = i + 1
  end
  if i == 0 then print('⚠️ No test files found') end
end
api.nvim_create_user_command('TestRun', run_tests, {desc = 'Compile and run all test cases'})



require('options')
require('keymaps')
require('lazy').setup({
  spec = { { import = 'plugins' } },
  ui = { border = 'rounded' },
})

