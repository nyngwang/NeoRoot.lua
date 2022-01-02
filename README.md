NeoRoot.lua
---

### DEMO

https://user-images.githubusercontent.com/24765272/147872679-6ca99110-d7fa-44fe-80cf-5cf71a3093bb.mov

### Intro.

This plugin will:

1. Change your _current working directory_ to the buffer your cursor is on
2. Try to go up 2 levels __but stop__ after it encounters one of the project roots __you define__

Now you won't have a hard time `:cd` to the right place to see more files before executing commands that takes your current working directory into account
 (i.e. you need to go up some levels to make tools like `rg`/`fd` to "see" more files).
You can also change your defaults __in the runtime__, so you can temporarily pin a folder like `Project/src/` as root with ease.

__Disclaimer__: This plugin is still in very-early stage. I have only confirmed that it works after installation.

### Features

- Automatically set your `cwd` two-level up (`%:p:h:h:h`) according to the buffer your cursor is on,
  while it will never _go beyond_ the project roots you setup.
- When you do "project root append"(`<Leader>pra`), the `pwd` printed in the cmdline will get updated immediately
- Always display the result of `pwd` in cmdline (You might not like this, I'm going to set this as a toggle)
- Light-weight, < 100 lines
- No dependencies

---

### Requirements

- Your `$HOME` should not be empty

### Compatibility

- Work with
  - [glepnir/dashboard-nvim](https://github.com/glepnir/dashboard-nvim)
  - [kyazdani42/nvim-tree.lua](https://github.com/kyazdani42/nvim-tree.lua)
  - [ibhagwan/fzf-lua](https://github.com/ibhagwan/fzf-lua), __highly recommended__

### Usage: Shortcuts & Defaults

Two shortcuts only, customizable:

- `<Leader>prr`, where `prr` means "project root reset"
- `<Leader>pra`, where `pra` means "project root append"
- `<Leader>p`, where `p` means "pill"
  - blue pill mode: move to `%:p:h:h:h`
  - red pill mode: stay at `%:p:h`

__So, to see the `pwd` of the current mode, we have to run `<Leader>p` twice, sadly.__

Default project roots:

- `_G.__PROJECT_ROOT`: `{ }`
  - how to append: `<Leader>pra` and then enter `whatever_folder_name`, __not path__, as project root

### TODO list

- [ ] Add installation guide in README.md
  - [ ] packer.nvim
- [ ] Customizable
  - [ ] ignore list
    - [ ] filetype
    - [ ] buftype
  - [ ] keymappings
  - [ ] go up levels
- [ ] Make it works on Vim too (if possible)
- [ ] Learn and use commit template
- [ ] Design a logo for it

