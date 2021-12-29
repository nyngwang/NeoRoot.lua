NeoRoot.lua
---

Keep your `cwd` in the right place by defining your own default project roots in your config. __And__ you can change your mind in the runtime :)

__WARNING__: I just copy-pasted the code from my working `init.lua`. It might not work after installation.

### Features

- Always display the result of `pwd` in cmdline
- When you do "project root append"(`<Leader>pra`), the `pwd` will update immediately

### Compatibility

- Work with
  - dashboard.nvim
  - nvim-tree.lua

### Shortcuts & Defaults & Usage

Two shortcuts, customizable:

- `<Leader>prr`, where `prr` means "project root reset"
- `<Leader>pra`, where `pra` means "project root append"

Defaults & Usage:

- `_G.__PROJECT_ROOT`
  - default: `{ "GitHub", "GitHub-2" }`
  - how to append: `<Leader>pra` and then enter `whatever_folder_name` as project root

### DEMO

(to be recorded.)

