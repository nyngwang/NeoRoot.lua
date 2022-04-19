NeoRoot.lua
---

### DEMO

https://user-images.githubusercontent.com/24765272/150794108-890b2ef3-3b4f-4fdb-8b47-0aa7f5d3ccf5.mov

### New Intro. (updated 2022/04/19)

With NeoRoot.lua, you will be able to:

- Before starting NeoVim, first navigate to your project root(can be modified later)
- Run `nvim .` to start your NeoVim. Now `NeoRoot` will enter `proj-mode`(see below) with the path you run `nvim .` as the root
- During development, you can temporarily change the `cwd` to your current buffer.
- During development, you can temporarily re-define your project root. For example: `~/.config`. (shorthand `~`, `../`s are supported!
  - if you want to change back to `../somewhere/MyProj/`, just leave the prompt blank and hit Enter. Simple!


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
  'nyngwang/NeoRoot.lua',
  config = function()
    require('neo-root').setup {
      CUR_MODE = 2 -- 1 for file/buffer mode, 2 for proj-mode
    }
  end
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

