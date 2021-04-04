" File:        ansible-doc.vim
" Description: View Ansible documentation without leaving Vim.
" Author:      takelley1 <hxyz@protonmail.com>
" Website:     https://github.com/takelley1/ansible-doc.vim
" License:     MIT

function! s:OpenFloatingWin()
  let opts = g:ansibledoc_float_opts
  let float_buffer = nvim_create_buf(v:false, v:true)
  let win = nvim_open_win(float_buffer, v:true, opts)
endfunction

function! ansible_doc#AnsibleDoc(wintype)
  " Get the WORD under the cursor, then filter out unneeded characters.
  " See https://superuser.com/a/868955 for reference.
  execute a:wintype '| 0read ! ansible-doc'
      \ substitute(expand("<cWORD>"), "[^a-zA-Z0-9._].*", "", "")
  setlocal filetype=ansible-doc
  if a:wintype ==# 'call s:OpenFloatingWin()'
    " Jump to top of file (gg)
    " Select entire file (vG)
    " Indent (>)
    " Move cursor to middle of screen (M)
    normal! ggvG>M
  else
    normal! ggM
  endif
endfunction
