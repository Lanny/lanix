" Visual junk
syntax on
set nowrap
let g:char_ruler = 80
let &t_ut=""

set clipboard=unnamedplus

" Default tabbing behavior
set expandtab
set tabstop=2 
set shiftwidth=2 

au FileType python setl sw=4 sts=4 ts=4 et
au FileType matlab setl sw=4 sts=4 ts=4 et
au FileType go setl noexpandtab sw=4 ts=4
au BufReadPost,BufNewFile *.tex,*.md,COMMIT_EDITMSG English

autocmd BufNewFile,BufRead *.tsx,*.jsx,*.js set filetype=typescriptreact
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

" Custom TSX syntax coloring
hi tsxTagName guifg=#F8BD7F
hi tsxCloseTagName guifg=#F8BD7F
hi tsxComponentName guifg=#00a120
hi tsxCloseComponentName guifg=#00a120
hi tsxAttrib guifg=#0081cc gui=italic
hi! def link tsxCloseTag tsxTag

" notes file
autocmd BufNewFile,BufRead notes set syntax=markdown | English

set wildignore+=*.pyc,*.swp

" Key remaps
nmap <silent> <Tab> :wincmd w<CR>
nmap <silent> <S-Tab> :wincmd W<CR>
nnoremap <silent> <F4> :syn sync fromstart<CR>

" Commands
function! English()
  call pencil#init({'wrap': 'soft'})
  set spell
endfunction

command! -nargs=0 English call English()

command! -bang -nargs=? -complete=dir MyCtrlP
  \ call fzf#vim#files(<q-args>, {'options': ['--info=inline', '--tiebreak=end', '--preview', 'ptf {}']}, <bang>0)

nmap <silent> <C-p> :MyCtrlP<CR>

function! SetServer()
  execute "silent !echo " . v:servername . " > ~/.vimsid"
endfunction

command! -nargs=0 SetServer call SetServer()

" Reload vimrc file. I should have done this years ago
if exists('*ReloadVimRC') == 0
  function ReloadVimRC()
    so ~/.vimrc
  endfunction
end
command! -nargs=0 Reload call ReloadVimRC()

function! GetJestCmd()
  let jestCmd = 'npm run test -- --watch --runInBand --runTestsByPath ' . expand('%:.')
  call setreg("+", jestCmd)
endfunction
command! -nargs=0 GetJestCmd call GetJestCmd()


" Enable cursorline in normal mode. Only with in gui mode
if has("gui_running")
  let g:lanny_cursorline = 1
else
  let g:lanny_cursorline = 0
end

highlight CursorLine guibg=#4f0402
highlight CursorLineNR guibg=#4f0402 guifg=#ffd77a

function! CondCurLin()
  if g:lanny_cursorline
    set cursorline
  else
    set nocursorline
  end
endfunction

function! EnableRuler()
  if exists('+colorcolumn')
    let &colorcolumn = g:char_ruler
  else
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>'.g:char_ruler.'v.\+', -1)
  endif
endfunction

function! DisableRuler()
  if exists('+colorcolumn')
    set colorcolumn=
  else
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>0v.\+', -1)
  endif
endfunction

autocmd InsertEnter * set nocursorline
autocmd InsertLeave * call CondCurLin()

autocmd WinEnter * call CondCurLin()
autocmd WinLeave * set nocursorline

autocmd WinEnter * call EnableRuler()
"autocmd WinLeave * call DisableRuler()

function! ToggleCursorLine()
  if g:lanny_cursorline
    let g:lanny_cursorline = 0
    set nocursorline
  else
    let g:lanny_cursorline = 1
    set cursorline
  end
endfunction

call CondCurLin()
call EnableRuler()

nmap <silent> C :call ToggleCursorLine()<CR>
