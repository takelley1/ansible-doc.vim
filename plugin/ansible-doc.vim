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

function! OpenFloatingWin()
  let opts = g:ansibledoc_float_opts
  let buf = nvim_create_buf(v:false, v:true)
  let win = nvim_open_win(buf, v:true, opts)
endfunction

function! AnsibleDoc(wintype)
  " Get the WORD under the cursor, then filter out unneeded characters.
  " See https://superuser.com/a/868955 for reference.
  execute a:wintype '| 0read ! ansible-doc'
      \ substitute(expand("<cWORD>"), "[^a-zA-Z.].*", "", "")
  setlocal filetype=ansible-doc
  " Format window.
  if a:wintype == 'call OpenFloatingWin()'
    " Jump to top of file (gg)
    " Select entire file (vG)
    " Indent (>)
    " Move cursor to middle of screen (M)
    normal! ggvG>M
  else
    normal! ggM
  endif
endfunction

command! AnsibleDocFloat call AnsibleDoc('call OpenFloatingWin()')
command! AnsibleDocSplit call AnsibleDoc('new')
command! AnsibleDocVSplit call AnsibleDoc('vnew')

autocmd FileType ansible-doc
  \ setlocal bufhidden=delete nonumber shiftwidth=3 scrolloff=999

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
