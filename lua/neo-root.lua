local NOREF_NOERR_TRUNC = { noremap = true, silent = true, nowait = true }
local NOREF_NOERR = { noremap = true, silent = true }
local EXPR_NOREF_NOERR_TRUNC = { expr = true, noremap = true, silent = true, nowait = true }
---------------------------------------------------------------------------------------------------
-- constants
RED_PILL = 1
BLUE_PILL = 2
-- globals
CUR_MODE = RED_PILL
_PROJ_ROOT = vim.fn.getcwd()
PROJ_ROOT = vim.fn.getcwd() -- will not save invalid

local M = {}

local function execute_mode_behaviour()
  if CUR_MODE == RED_PILL then
    vim.cmd('cd ' .. vim.fn.expand('%:p:h'))
  else -- CUR_MODE == BLUE_PILL
    vim.cmd('cd ' .. PROJ_ROOT)
  end
end

local function apply_change()
  M.execute()
  print(vim.fn.getcwd())
end
---------------------------------------------------------------------------------------------------
function M.execute()
  -- NOTE: Don't use `string.find` to compare type, since empty string `''` will always match
  -- NOTE: Don't use `vim.opt.filetype`, since everyone set it locally.
  if vim.bo.buftype ~= "terminal" -- TODO: should be customizable
    and vim.bo.filetype ~= "dashboard"
    and vim.bo.filetype ~= "NvimTree"
    and vim.bo.filetype ~= "FTerm" then
    execute_mode_behaviour()
  end
end

function M.change_mode()
  if CUR_MODE == BLUE_PILL then
    CUR_MODE = RED_PILL
  elseif CUR_MODE == RED_PILL then
    CUR_MODE = BLUE_PILL
  end
  apply_change()
end

function M.change_project_root()
  local input = vim.fn.input('Set Project Root: ')
  if (input == '' or input:match('%s+')) then
    PROJ_ROOT = _PROJ_ROOT
  else
    -- should check path exist
    PROJ_ROOT = input
  end
  execute_mode_behaviour()
end

local function setup_vim_commands()
  vim.cmd [[
    command! NeoRoot lua require('neo-root').execute()
    command! NeoRootSwitchMode lua require('neo-root').change_mode()
    command! NeoRootChange lua require('neo-root').change_project_root()
  ]]
end

setup_vim_commands()

return M
