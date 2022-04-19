local NOREF_NOERR_TRUNC = { noremap = true, silent = true, nowait = true }
local NOREF_NOERR = { noremap = true, silent = true }
local EXPR_NOREF_NOERR_TRUNC = { expr = true, noremap = true, silent = true, nowait = true }
---------------------------------------------------------------------------------------------------
-- constants
RED_PILL = 1
BLUE_PILL = 2
-- globals
CUR_MODE = BLUE_PILL
_PROJ_ROOT = vim.fn.getcwd()
PROJ_ROOT = vim.fn.getcwd() -- this cannot be relative path!

local M = {}

---------------------------------------------------------------------------------------------------
function M.setup(config)
  CUR_MODE = config.CUR_MODE
end

function M.apply_change()
  -- NOTE: Don't use `string.find` to compare type, since empty string `''` will always match
  -- NOTE: Don't use `vim.opt.filetype`, since everyone set it locally.
  if vim.bo.buftype ~= "terminal" -- TODO: should be customizable
    and vim.api.nvim_win_get_config(0).relative == ''
    and vim.bo.filetype ~= "dashboard"
    and vim.bo.filetype ~= "NvimTree"
    and vim.bo.filetype ~= "FTerm" then
    if CUR_MODE == RED_PILL then
      vim.cmd('cd ' .. vim.fn.expand('%:p:h'))
    else -- CUR_MODE == BLUE_PILL
      vim.cmd('cd ' .. PROJ_ROOT)
    end
    print(vim.fn.getcwd() .. ' (cwd = ' .. (CUR_MODE == RED_PILL and 'file' or 'proj-root') .. ')')
  end
end

function M.change_mode()
  if vim.api.nvim_win_get_config(0).relative ~= '' then
    print('[NeoRoot] Cannot change mode in floating window.')
    return
  end
  if CUR_MODE == BLUE_PILL then
    CUR_MODE = RED_PILL
  elseif CUR_MODE == RED_PILL then
    CUR_MODE = BLUE_PILL
  end
  M.apply_change()
end

function M.change_project_root()
  CUR_MODE = BLUE_PILL
  local input = vim.fn.input('Set Project Root: ')
  if (input == '' or input:match('%s+')) then -- reset signal
    PROJ_ROOT = _PROJ_ROOT
    M.apply_change()
    return
  end

  if input:sub(1,2) == './' or input:sub(1,3) == '../' then -- relative path
    local cwd = vim.fn.getcwd()
    if cwd:sub(-1) == '/' then
      vim.cmd('cd ' .. cwd ..  input)
    else
      vim.cmd('cd ' .. cwd .. '/' .. input)
    end
  else -- the last case `~`
    vim.cmd('cd ' .. input)
  end
  -- `PROJ_ROOT` only store normalized result
  PROJ_ROOT = vim.fn.getcwd()
  M.apply_change()
end

local function setup_vim_commands()
  vim.cmd [[
    command! NeoRoot lua require('neo-root').apply_change()
    command! NeoRootSwitchMode lua require('neo-root').change_mode()
    command! NeoRootChange lua require('neo-root').change_project_root()
  ]]
end

setup_vim_commands()

return M
