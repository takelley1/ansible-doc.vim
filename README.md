# ansible-doc.vim

View Ansible documentation without leaving Vim.


## Installation

Use your favorite plugin manager, such as vim-plug:
```vim
Plug 'takelley1/ansible-doc.vim'
```

## Usage

Run one of the following commands when your cursor is over the name of an
Ansible module:
```
AnsibleDocFloat   # Open in a floating window (Neovim only).
AnsibleDocSplit   # Open in a horizontal split.
AnsibleDocVSplit  # Open in a vertical split.
```

The following mappings are available in the floating window created by
`AnsibleDocFloat`:
```
<space>           # Page-down
b                 # Page-up
q, Q, <CR>, <Esc> # Close window
```

## Options

Disable floating window mappings:
```vim
let g:ansibledoc_extra_mappings = 0
```

Modify the floating window's size and position:
```vim
  let g:ansibledoc_float_opts = {
    \ 'relative': 'editor',
    \ 'width': float2nr(round(0.45 * &columns)),
    \ 'height': float2nr(round(0.75 * &lines)),
    \ 'col': float2nr(round(0.27 * &columns)),
    \ 'row': float2nr(round(0.07 * &lines)),
    \ }
```
