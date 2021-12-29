if vim.fn.has("nvim-0.5") == 0 then
  return
end

if vim.g.loaded_neorooter_nvim ~= nil then
  return
end

-- TODO: Let users setup neo-root with some global variables defined in README.md.

require('neo-root')

vim.g.loaded_neorooter_nvim = 1
