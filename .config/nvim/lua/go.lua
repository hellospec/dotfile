vim.api.nvim_create_user_command('GoTags',
  function(opts)
    local file = vim.fn.expand('%')
    local struct = vim.fn.expand('<cword>')
    local tag_type = opts.args or 'db'  -- default to db if no argument provided

    -- Validate tag type
    if tag_type ~= 'db' and tag_type ~= 'json' then
      vim.notify('Invalid tag type. Use "db" or "json"', vim.log.levels.ERROR)
      return
    end

    -- Execute gomodifytags and capture its output
    local output = vim.fn.system('gomodifytags -file ' .. file .. 
      ' -struct ' .. struct .. 
      ' -add-tags ' .. tag_type .. 
      ' -w')  -- -w flag writes to file directly

    -- Reload the buffer to show changes
    vim.cmd('e!')

    -- Show error if any
    if vim.v.shell_error ~= 0 then
      vim.notify('Error: ' .. output, vim.log.levels.ERROR)
    end

  end,
  {
    nargs = '?',  -- Optional argument
    complete = function()
      return {'db', 'json'}  -- Provide completion options
    end
  }
)
