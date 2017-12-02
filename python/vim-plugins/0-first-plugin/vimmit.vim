if !has('python3')
  echo "Error: nvim needs python3 support. Please run :CheckHealth"
  finish
endif

" Vim comments start with a double quote.
" Function definition is VimL. We can mix VimL and Python in
" function definition.
function! Reddit()
  py3file hello.py
endfunction

command! Reddit call Reddit()
