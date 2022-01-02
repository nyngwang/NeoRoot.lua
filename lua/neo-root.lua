local NOREF_NOERR_TRUNC = { noremap = true, silent = true, nowait = true }
local NOREF_NOERR = { noremap = true, silent = true }
local EXPR_NOREF_NOERR_TRUNC = { expr = true, noremap = true, silent = true, nowait = true }
---------------------------------------------------------------------------------------------------

vim.cmd'au BufEnter * call v:lua.blue_pill_or_red_pill()'
_G.__CURRENT_MODE = 'RED_PILL'
vim.api.nvim_set_keymap('n', '<Leader>p', '<cmd>lua _G.change_pill(); _G.blue_pill_or_red_pill(); print(vim.fn.getcwd())<CR>', NOREF_NOERR_TRUNC)
function _G.change_pill()
  if _G.__CURRENT_MODE == 'BLUE_PILL' then
    _G.__CURRENT_MODE = 'RED_PILL'
  elseif _G.__CURRENT_MODE == 'RED_PILL' then
    _G.__CURRENT_MODE = 'BLUE_PILL'
  end
end
vim.api.nvim_set_keymap('n', '<Leader>prr', '<cmd>lua _G.reset_project_root(); _G.blue_pill_or_red_pill()<CR>', NOREF_NOERR_TRUNC)
_G.__PROJECT_ROOT_CONST = {
}
function _G.reset_project_root()
  for k in pairs(_G.__PROJECT_ROOT) do
    local found = false
    for kk in pairs(_G.__PROJECT_ROOT_CONST) do
      if k == kk then
        found = true
        break
      end
    end
    if not found then
      _G.__PROJECT_ROOT[k] = nil
    end
  end
end
vim.api.nvim_set_keymap('n', '<Leader>pra', '<cmd>lua table.insert(_G.__PROJECT_ROOT, vim.fn.input("Extend Project Root: ")); _G.blue_pill_or_red_pill()<CR>', NOREF_NOERR_TRUNC)
_G.__PROJECT_ROOT = {
}
function _G.blue_pill_or_red_pill()
  if (
    -- Don't use `string.find` or you will match when `vim.bo.buftype` is `''` empty string!
    vim.bo.buftype ~= "terminal"
    and vim.bo.filetype ~= "dashboard"
    and vim.bo.filetype ~= "NvimTree"
    -- Don't use `vim.opt.filetype`, since everyone set it locally.
    and vim.bo.filetype ~= "FTerm"
  ) then
    if _G.__CURRENT_MODE == 'RED_PILL' then
      vim.api.nvim_set_current_dir(vim.fn.expand("%:p:h"))
      return
    end
    local test_path = "%:p"
    local count = 0
    while (
      count+1 <= 3
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
end
