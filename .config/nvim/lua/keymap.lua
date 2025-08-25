-- Key mapping
-- telescope
local telescope_builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, {})
vim.keymap.set('n', '<leader>fl', telescope_builtin.live_grep, {})
-- vim.keymap.set('n', '<leader>fg', telescope_builtin.grep_string, {})
vim.keymap.set('n', '<leader>b', telescope_builtin.buffers, {})
vim.keymap.set('n', '<C-p>', telescope_builtin.git_files, {})

-- nvim-tree
vim.keymap.set('n', '<C-n>', '<Cmd>NvimTreeToggle<CR>', {silent = true})
vim.keymap.set('n', '<leader>+', '<Cmd>NvimTreeResize +20<CR>', {silent = true})
vim.keymap.set('n', '<leader>-', '<Cmd>NvimTreeResize -20<CR>', {silent = true})

-- Custom
-- Move lines like Sublime
vim.keymap.set('n', '<S-Up>',':m-2<CR>')
vim.keymap.set('n', '<S-Down>', ':m+<CR>')
vim.keymap.set('i', '<S-Up>', '<Esc>:m-2<CR>')
vim.keymap.set('i', '<S-Down>', '<Esc>:m+<CR>')

-- Move selected lines
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Switch between the last two files
vim.keymap.set('n', '<leader><leader>','<C-^>')

-- Search word
vim.keymap.set('n', '<leader>fw','bvey/<C-r>"<CR>')

-- Copy to system clipboard
vim.keymap.set('n', '<leader>y', "\"+y")
vim.keymap.set('v', '<leader>y', "\"+y")
vim.keymap.set('n', '<leader>Y', "\"+y")

-- Preserve copy content
vim.keymap.set('x', '<leader>p', '\"_dP')

vim.keymap.set('n', 'zz','zt')
vim.keymap.set('n', 'sr','ysiw')
vim.keymap.set('n', 'n','nzz')
vim.keymap.set('n', 'N','Nzz')
vim.keymap.set('n', '<C-d>','<C-d>zz')
vim.keymap.set('n', '<C-u>','<C-u>zz')
vim.keymap.set('n', '*','*zz')
vim.keymap.set('n', '#','#zz')
vim.keymap.set('n', 'vv','<C-v>')
vim.keymap.set('n', '<CR>',':noh<C-v>')
vim.keymap.set('t', '<Esc>','<C-\\><C-n>')

-- Repeat search files from grep string for both normal and visual mode
local last_grep_string = ""

-- Function with memory for normal mode
local function grep_string_with_memory()
  local word = vim.fn.expand("<cword>")
  last_grep_string = word
  require('telescope.builtin').grep_string({ search = word })
end

local function repeat_last_grep()
  if last_grep_string ~= "" then
    require('telescope.builtin').grep_string({ search = last_grep_string })
  else
    print("No previous grep string to repeat")
  end
end

-- Visual selection function
local function grep_visual_selection()
  local text = vim.fn.getline("'<", "'>")
  text = table.concat(text, "\n")
  -- Remove leading/trailing whitespace
  text = text:gsub("^%s*(.-)%s*$", "%1")
  last_grep_string = text  -- Also store visual selection for repeat
  require('telescope.builtin').grep_string({ search = text })
end
vim.keymap.set('n', '<leader>fg', grep_string_with_memory, {})
vim.keymap.set('n', '<leader>fr', repeat_last_grep, {})
vim.keymap.set('v', '<leader>fg', grep_visual_selection, {})

