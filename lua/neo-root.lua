local NOREF_NOERR_TRUNC = { noremap = true, silent = true, nowait = true }
local NOREF_NOERR = { noremap = true, silent = true }
local EXPR_NOREF_NOERR_TRUNC = { expr = true, noremap = true, silent = true, nowait = true }
---------------------------------------------------------------------------------------------------
-- constants
RED_PILL = 1
BLUE_PILL = 2
-- globals
NEO_ZOOM_DID_INIT = false
CUR_MODE = nil
PROJ_ROOT = nil
USER_ROOT = ''

local M = {}

-- TODO: provide this in the next PR :P
local function level_up(total_level)
  local test_path = "%:p"
  local count = 0
  while (
    count+1 <= total_level
    and string.len(vim.fn.expand(test_path .. ":h")) >= string.len(vim.fn.expand("$HOME"))
  ) do
    test_path = test_path .. ":h"
    count = count + 1
    local found_root = false
    for idx = 1, #_G.__PROJECT_ROOT do
      local _, last = string.find(vim.fn.expand(test_path), _G.__PROJECT_ROOT[idx], nil, true)
      if string.len(vim.fn.expand(test_path)) == last then
          found_root = true
          break
      end
    end
    if found_root then break end
  end
  vim.api.nvim_set_current_dir(vim.fn.expand(test_path))
end

local function init()
  CUR_MODE = RED_PILL
  -- NOTE: Both `~`, `-`, `..` works with `vim.cmd`
  PROJ_ROOT = vim.fn.getcwd()
end

local function execute_mode_behaviour()
  if CUR_MODE == RED_PILL then
    vim.api.nvim_set_current_dir(vim.fn.expand('%:p:h'))
  else -- CUR_MODE == BLUE_PILL
    if USER_ROOT ~= '' then
      vim.api.nvim_set_current_dir(USER_ROOT)
    else
      vim.api.nvim_set_current_dir(PROJ_ROOT)
    end
  end
end

local function apply_change()
  M.execute()
  print(vim.cmd('pwd'))
end
---------------------------------------------------------------------------------------------------
function M.execute()
  if not NEO_ZOOM_DID_INIT then
    init()
    NEO_ZOOM_DID_INIT = true
  end
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
  USER_ROOT = vim.fn.input('Set Project Root: ')
  if USER_ROOT ~= '' then -- reset
    vim.cmd('cd ' .. USER_ROOT)
  else
    vim.cmd('cd ' .. PROJ_ROOT)
  end
  apply_change()
end

local function setup_vim_commands()
  vim.cmd'au BufEnter * NeoRoot'
  vim.cmd [[
    command! NeoRoot lua require('neo-root').execute()
    command! NeoRootSwitchMode lua require('neo-root').change_mode()
    command! NeoRootChange lua require('neo-root').change_project_root()
  ]]
end

setup_vim_commands()

return M
