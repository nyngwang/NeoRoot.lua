NeoRoot.lua
---

### DEMO

TODO: update

### New Intro.

With NeoRoot.lua, you will be able to:

- Run `nvim MyProj` to open neovim with Project Root at `../somewhere/MyProj/`
- During development, you can use toggle to temporarily change between `cwd` to your current buffer, and `../somewhere/MyProj/` .
- During development, you can temporarily re-define your project root to, for example: `~/.config`. (shorthand `~`, `../`s are available :))
  - if you want to change back to `../somewhere/MyProj/`, just leave the prompt blank. Simple
- That's it!

### Old Promo.

Now you won't have a hard time `:cd` to the right place to see more files before executing commands that takes your current working directory into account
 (i.e. you need to go up some levels to make tools like `rg`/`fd` to "see" more files).
You can also change your project root __in the runtime__, without typing any command, anymore!

### Features

- No dependencies
- No requirements
- free
- Light-weight, ~100 lines

### Compatibility

- Work with
  - [glepnir/dashboard-nvim](https://github.com/glepnir/dashboard-nvim)
  - [numToStr/FTerm.nvim](https://github.com/numtostr/FTerm.nvim)
  - [kyazdani42/nvim-tree.lua](https://github.com/kyazdani42/nvim-tree.lua)
  - [ibhagwan/fzf-lua](https://github.com/ibhagwan/fzf-lua), __highly recommended__

### Setup

#### Packer.nvim

```lua
local NOREF_NOERR_TRUNC = { noremap = true, silent = true, nowait = true }
use {
  'nyngwang/NeoRoot.lua'
}
vim.cmd'au BufEnter * NeoRoot'
vim.keymap.set('n', '<Leader>p', function() vim.cmd('NeoRootSwitchMode') end, NOREF_NOERR_TRUNC)
vim.keymap.set('n', '<Leader>pre', function() vim.cmd('NeoRootChange') end, NOREF_NOERR_TRUNC)
```

### Hint

To see your current working directory, simply call `NeoRootSwitchMode` twice.

### TODO list

- [x] Add installation guide in README.md
  - [x] packer.nvim
- [x] Customizable
  - [x] keymappings
  - [ ] ignore list

