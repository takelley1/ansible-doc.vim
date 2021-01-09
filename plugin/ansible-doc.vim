" File:        ansible-doc.vim
" Description: View Ansible documentation without leaving Vim.
" Author:      takelley1 <hxyz@protonmail.com>
" Website:     https://github.com/takelley1/ansible-doc.vim
" License:     MIT

" Set default variables.
if !exists("g:ansibledoc_extra_mappings")
  let g:ansibledoc_extra_mappings = 1
endif
if !exists("g:ansibledoc_wrap_text")
  let g:ansibledoc_wrap_text = 0
endif
if !exists("g:ansibledoc_float_opts")
  let g:ansibledoc_float_opts = {
    \ 'relative': 'editor',
    \ 'style': 'minimal',
    \ 'width': float2nr(round(0.45 * &columns)),
    \ 'height': float2nr(round(0.75 * &lines)),
    \ 'col': float2nr(round(0.27 * &columns)),
    \ 'row': float2nr(round(0.07 * &lines)),
    \ }
endif

command! AnsibleDocFloat call ansible_doc#AnsibleDoc('call s:OpenFloatingWin()')
command! AnsibleDocSplit call ansible_doc#AnsibleDoc('new')
command! AnsibleDocVSplit call ansible_doc#AnsibleDoc('vnew')

autocmd FileType ansible-doc
  \ setlocal bufhidden=delete shiftwidth=3 scrolloff=999 nonumber

if g:ansibledoc_wrap_text ==# 1
  autocmd FileType ansible-doc setlocal wrap
else
  autocmd FileType ansible-doc setlocal nowrap
endif

if g:ansibledoc_extra_mappings ==# 1
  " Mimic less's mappings.
  autocmd FileType ansible-doc nnoremap <buffer> <space> <C-d>
  autocmd FileType ansible-doc nnoremap <buffer> b       <C-u>

  autocmd FileType ansible-doc nnoremap <buffer> q       :close!<CR>
  autocmd FileType ansible-doc nnoremap <buffer> Q       :close!<CR>
  autocmd FileType ansible-doc nnoremap <buffer> <CR>    :close!<CR>
  autocmd FileType ansible-doc nnoremap <buffer> <Esc>   :close!<CR>

  " Prevent the user from accidentally clearing the buffer.
  autocmd FileType ansible-doc nnoremap <buffer> u       <Nop>
endif
