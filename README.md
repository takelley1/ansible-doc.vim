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

| Command             | Description                                            |
|---------------------|--------------------------------------------------------|
| `:AnsibleDocFloat`  | Open documentation in a floating window (Neovim only), |
| `:AnsibleDocSplit`  | ..or in a horizontal split,                            |
| `:AnsibleDocVSplit` | ..or a vertical split.                                 |

You can map these commands however you like, such as:
```vim
nnoremap <leader>d :AnsibleDocFloat<CR>C-L>
nnoremap <leader>v :AnsibleDocVSplit<CR>C-L>
```

The following mappings are available in windows and splits created by
this plugin:
| Mapping                      | Description  |
|------------------------------|--------------|
| `<space>`                    | Page-down    |
| `b`                          | Page-up      |
| `q`, `Q`, `<CR>`, or `<Esc>` | Close window |

## Options

Enable/disable extra key mappings (default is `1`):
```vim
let g:ansibledoc_extra_mappings = 1
```

Modify the floating window's size and position (default is below):
```vim
  let g:ansibledoc_float_opts = {
    \ 'relative': 'editor',
    \ 'style': 'minimal',
    \ 'width': float2nr(round(0.45 * &columns)),
    \ 'height': float2nr(round(0.75 * &lines)),
    \ 'col': float2nr(round(0.27 * &columns)),
    \ 'row': float2nr(round(0.07 * &lines)),
    \ }
```

Enable/disable text wrapping in windows created by this plugin (default is `0`):
```vim
let g:ansibledoc_wrap_text = 0
```
