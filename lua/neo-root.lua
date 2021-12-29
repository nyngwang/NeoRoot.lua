local NOREF_NOERR_TRUNC = { noremap = true, silent = true, nowait = true }
local NOREF_NOERR = { noremap = true, silent = true }
local EXPR_NOREF_NOERR_TRUNC = { expr = true, noremap = true, silent = true, nowait = true }

vim.cmd'au CursorHold * pwd'
vim.cmd'au BufEnter * call v:lua.change_cwd_to_grandparent()'
vim.api.nvim_set_keymap('n', '<Leader>prr', '<cmd>lua _G.reset_project_root(); print("Project Root Has Been Reset"); _G.change_cwd_to_grandparent()<CR>', NOREF_NOERR_TRUNC)
_G.__PROJECT_ROOT_CONST = {
  "GitHub",
  "GitHub%-2",
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
vim.api.nvim_set_keymap('n', '<Leader>pra', '<cmd>lua table.insert(_G.__PROJECT_ROOT, vim.fn.input("Extend Project Root: ")); _G.change_cwd_to_grandparent()<CR>', NOREF_NOERR_TRUNC)
_G.__PROJECT_ROOT = {
  "GitHub",
  "GitHub-2",
}
function _G.change_cwd_to_grandparent()
  if (
    -- Don't use `string.find` or you will match when `vim.bo.buftype` is `''` empty string!
    vim.bo.buftype ~= "terminal"
    and vim.opt.filetype ~= "dashboard"
    and vim.opt.filetype ~= "NvimTree"
  ) then
    local test_path = "%:p:h"
    local count = 0
    while (
      count+1 <= 2
      and string.len(vim.fn.expand(test_path .. ":h")) >= string.len(vim.fn.expand("$HOME"))
    ) do
      local found_root = false
      for idx = 1, #_G.__PROJECT_ROOT do
        local _, last = string.find(vim.fn.expand(test_path .. ":h"), _G.__PROJECT_ROOT[idx], nil, true)
        if string.len(vim.fn.expand(test_path .. ":h")) == last then
            found_root = true
            break
        end
      end
      if found_root then break end
      test_path = test_path .. ":h"
      count = count + 1
    end
    vim.api.nvim_set_current_dir(vim.fn.expand(test_path))
  end
end
