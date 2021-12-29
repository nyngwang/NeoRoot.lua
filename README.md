NeoRoot.lua
---

This plugin __automatically Level-up__ your `cwd` __within__ the project roots __you define__,
so you don't have to run <br> `cd ..` again to see more files before running CLI tools like `rg` and `fd`. You can also change your defaults <br> __in the runtime__,
so your root can be set to `Project/src/` with ease.

__Disclaimer__: This plugin is still in very-early stage. I have only confirmed that it works after installation.

### Features

- Automatically set your `cwd` three-level up (`%:p:h:h:h`) according to your current buffer the cursor is on
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

(to be recorded.)

