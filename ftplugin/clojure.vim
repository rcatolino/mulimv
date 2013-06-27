"mulimv-lisp.vim
"moderately useful lisp interaction mode for vim"
"Uses gnu screen to send S-expressions to a lisp repl from inside a vim session
"(based on http://technotales.wordpress.com/2007/10/03/like-slime-for-vim/ idea).

let g:mulimv_sessionname = "mulimv"
let g:mulimv_repl = "lein repl"
let g:mulimv_term_emulator = "konsole -e"

function Mulimv_start_repl()
  echo system("screen -S mulimv -X quit&")
  echo system(g:mulimv_term_emulator . " screen -S " . g:mulimv_sessionname . " " . g:mulimv_repl . "&")
endfunction

function Send_to_Screen(text)
  "Make sure the line ends with a newline so that the repl evaluate the
  "expression.
  if match(a:text, "\n") == -1
    let text = a:text . "\n"
  else
    let text = a:text
  endif
  echo system("screen -S " . g:mulimv_sessionname . " -X stuff '" . substitute(text, "'", "'\\\\''", 'g') . "'")
endfunction

vmap ,s "ry :call Send_to_Screen(@r)<CR>
vmap ,b "ry :call Send_to_Screen(@r)<CR>
nmap ,b vip,b
nmap ,s l?(<CR>v%,s
nmap ,r :call Mulimv_start_repl()<CR>
