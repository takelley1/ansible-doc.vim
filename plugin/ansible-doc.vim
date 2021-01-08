" File:        ansible-doc.vim
" Description: View Ansible documentation without leaving Vim.
" Author:      takelley1 <hxyz@protonmail.com>
" Website:     https://github.com/takelley1/ansible-doc.vim
" License:     MIT

augroup ansibledoc
  autocmd!
augroup END

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
    \ 'width': float2nr(round(0.45 * &columns)),
    \ 'height': float2nr(round(0.75 * &lines)),
    \ 'col': float2nr(round(0.27 * &columns)),
    \ 'row': float2nr(round(0.07 * &lines)),
    \ }
endif

" Set other useful variables for DRY.
let s:word_regex="[^a-zA-Z.].*"

function! OpenFloatingWin()
  let opts = g:ansibledoc_float_opts
  let buf = nvim_create_buf(v:false, v:true)
  let win = nvim_open_win(buf, v:true, opts)
  setlocal filetype=ansible-doc
endfunction

function! AnsibleDocFloat()
  " See https://superuser.com/a/868955 for reference.
  " Get the WORD under the cursor, then filter out unneeded characters.
  execute 'call OpenFloatingWin() | 0read ! ansible-doc' substitute(expand("<cWORD>"), s:word_regex, "", "")
  " Set number of lines to indent.
  setlocal shiftwidth=3 scrolloff=999
  " Jump to top of file (gg)
  " Select entire file (vG)
  " Indent (>)
  " Move cursor to middle of screen (M)
  normal! ggvG>M
endfunction

function! AnsibleDocSplit(vertical)
  if a:vertical == 0
    execute 'new | 0read ! ansible-doc' substitute(expand("<cWORD>"), s:word_regex, "", "")
  else
    execute 'vnew | 0read ! ansible-doc' substitute(expand("<cWORD>"), s:word_regex, "", "")
  endif
  setlocal filetype=ansible-doc
  " Jump to top of buffer.
  normal! gg
endfunction

command! AnsibleDocFloat call AnsibleDocFloat()
command! AnsibleDocSplit call AnsibleDocSplit(0)
command! AnsibleDocVSplit call AnsibleDocSplit(1)

autocmd FileType ansible-doc setlocal bufhidden=delete nonumber

if g:ansibledoc_wrap_text == 1
  autocmd FileType ansible-doc setlocal wrap
else
  autocmd FileType ansible-doc setlocal nowrap
endif

if g:ansibledoc_extra_mappings == 1
  " Mimic `less`-style pagination mappings.
  autocmd FileType ansible-doc nnoremap <buffer> <space> <C-d>
  autocmd FileType ansible-doc nnoremap <buffer> b       <C-u>

  autocmd FileType ansible-doc nnoremap <buffer> q       :close!<CR>
  autocmd FileType ansible-doc nnoremap <buffer> Q       :close!<CR>
  autocmd FileType ansible-doc nnoremap <buffer> <CR>    :close!<CR>
  autocmd FileType ansible-doc nnoremap <buffer> <Esc>   :close!<CR>
  " Prevent the user from accidentally clearing the buffer.
  autocmd FileType ansible-doc nnoremap <buffer> u       <Nop>
endif
