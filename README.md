NeoRoot.lua
---

This plugin will:

1. Change your _current working directory_ to the buffer your cursor is on
2. Try to go up 2 levels __but stop__ after it encounters one of the project roots __you define__

Now you won't have a hard time `:cd` to the right place to see more files before executing commands that takes your current working directory into account
 (i.e. you need to go up some levels to make tools like `rg`/`fd` to "see" more files).
You can also change your defaults __in the runtime__, so you can temporarily pin a folder like `Project/src/` as root with ease.

__Disclaimer__: This plugin is still in very-early stage. I have only confirmed that it works after installation.

### Features

- Automatically set your `cwd` three-level up (`%:p:h:h:h`) according to the buffer your cursor is on,
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
  - dashboard.nvim
  - nvim-tree.lua
  - fzf-lua (highly recommended)

### Usage: Shortcuts & Defaults

Two shortcuts only, customizable:

- `<Leader>prr`, where `prr` means "project root reset"
- `<Leader>pra`, where `pra` means "project root append"

Default project roots:

- `_G.__PROJECT_ROOT`: `{ }`
  - how to append: `<Leader>pra` and then enter `whatever_folder_name`, __not path__, as project root

### DEMO

https://user-images.githubusercontent.com/24765272/147693438-00688642-b4c7-4d09-93a2-9aed009b314c.mov



