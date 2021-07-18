set nocompatible
filetype plugin on
syntax on
set clipboard+=unnamedplus
set undofile
set nojoinspaces
let g:EasyMotion_verbose = 0
"g Leader key
let mapleader=" "
noremap \ ,
noremap H ^
noremap L $
noremap <leader>H H
noremap <leader>L L
noremap <leader>n nzz
noremap <leader>N Nzz
set tabstop=2
set shiftwidth=2
set expandtab

" Better indenting
vnoremap < <gv
vnoremap > >gv
if exists('g:vscode')
  nnoremap gk :<C-u>call VSCodeCall('cursorMove', { 'to': 'up', 'by': 'wrappedLine', 'value': v:count ? v:count : 1 })<CR>
  nnoremap gj :<C-u>call VSCodeCall('cursorMove', { 'to': 'down', 'by': 'wrappedLine', 'value': v:count ? v:count : 1 })<CR>
  call plug#begin('~/.config/nvim/plugged')
  Plug 'lyokha/vim-xkbswitch'
  " Plug 'https://github.com/asvetliakov/vim-easymotion.git'
  Plug 'ChristianChiarulli/vscode-easymotion'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-abolish'
  Plug 'haya14busa/incsearch.vim'
  Plug 'haya14busa/incsearch-easymotion.vim'
  Plug 'tpope/vim-surround'
  Plug 'unblevable/quick-scope'
  Plug 'michaeljsmith/vim-indent-object'
  Plug 'bkad/CamelCaseMotion'
  call plug#end()
  set textwidth=145
  let g:XkbSwitchEnabled = 1
  " Simulate same TAB behavior in VSCode
  nmap <Tab> :Tabnext<CR>
  nmap <S-Tab> :Tabprev<CR>
  " Workaround for gk/gj
  "nnoremap gj j
  "nnoremap gk k
  " workaround for calling command picker in visual mode
  function! s:openVSCodeCommandsInVisualMode()
    normal! gv
    let visualmode = visualmode()
    if visualmode == "V"
      let startLine = line("v")
      let endLine = line(".")
      call VSCodeNotifyRange("workbench.action.showCommands", startLine, endLine, 1)
    else
      let startPos = getpos("v")
      let endPos = getpos(".")
      call VSCodeNotifyRangePos("workbench.action.showCommands", startPos[1], endPos[1], startPos[2], endPos[2], 1)
    endif
  endfunction
  function! s:RunSelectedRCode()
    normal! gv
    let visualmode = visualmode()
    if visualmode == "V"
      let startLine = line("v")
      let endLine = line(".")
      call VSCodeNotifyRange("r.runSelection", startLine, endLine, 1)
    else
      let startPos = getpos("v")
      let endPos = getpos(".")
      call VSCodeNotifyRangePos("r.runSelection", startPos[1], endPos[1], startPos[2], endPos[2], 1)
    endif
  endfunction
  function! s:RunSelectedPyCode()
    normal! gv
    let visualmode = visualmode()
    if visualmode == "V"
      let startLine = line("v")
      let endLine = line(".")
      call VSCodeNotifyRange("workbench.action.terminal.runSelectedText", startLine, endLine, 1)
    else
      let startPos = getpos("v")
      let endPos = getpos(".")
      call VSCodeNotifyRangePos("workbench.action.terminal.runSelectedText", startPos[1], endPos[1], startPos[2], endPos[2], 1)
    endif
  endfunction
  xmap gc  <Plug>VSCodeCommentary
  nmap gc  <Plug>VSCodeCommentary
  omap gc  <Plug>VSCodeCommentary
  nmap gcc <Plug>VSCodeCommentaryLine
  xnoremap <silent> <D-CR> :<C-u>call <SID>RunSelectedPyCode()<CR>

  augroup filetypedetect

    " R
    autocmd! BufNewFile,BufRead *.[rRsS] setfiletype r
    autocmd! BufNewFile,BufRead *.[rR]history setfiletype r

  augroup END

  au FileType r xnoremap <silent> <D-CR> :<C-u>call <SID>RunSelectedRCode()<CR>

  function! s:split(...) abort
    let direction = a:1
    let file = a:2
    call VSCodeCall(direction == 'h' ? 'workbench.action.splitEditorDown' : 'workbench.action.splitEditorRight')
    if file != ''
      call VSCodeExtensionNotify('open-file', expand(file), 'all')
    endif
  endfunction

  function! s:splitNew(...)
    let file = a:2
    call s:split(a:1, file == '' ? '__vscode_new__' : file)
  endfunction

  function! s:closeOtherEditors()
    call VSCodeNotify('workbench.action.closeEditorsInOtherGroups')
    call VSCodeNotify('workbench.action.closeOtherEditors')
  endfunction

  function! s:manageEditorSize(...)
    let count = a:1
    let to = a:2
    for i in range(1, count ? count : 1)
      call VSCodeNotify(to == 'increase' ? 'workbench.action.increaseViewSize' : 'workbench.action.decreaseViewSize')
    endfor
  endfunction

  function! s:vscodeCommentary(...) abort
    if !a:0
      let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
      return 'g@'
    elseif a:0 > 1
      let [line1, line2] = [a:1, a:2]
    else
      let [line1, line2] = [line("'["), line("']")]
    endif

    call VSCodeCallRange("editor.action.commentLine", line1, line2, 0)
  endfunction

  function! s:openVSCodeCommandsInVisualMode()
    normal! gv
    let visualmode = visualmode()
    if visualmode == "V"
      let startLine = line("v")
      let endLine = line(".")
      call VSCodeNotifyRange("workbench.action.showCommands", startLine, endLine, 1)
    else
      let startPos = getpos("v")
      let endPos = getpos(".")
      call VSCodeNotifyRangePos("workbench.action.showCommands", startPos[1], endPos[1], startPos[2], endPos[2], 1)
    endif
  endfunction

  function! s:openWhichKeyInVisualMode()
    normal! gv
    let visualmode = visualmode()
    if visualmode == "V"
      let startLine = line("v")
      let endLine = line(".")
      call VSCodeNotifyRange("whichkey.show", startLine, endLine, 1)
    else
      let startPos = getpos("v")
      let endPos = getpos(".")
      call VSCodeNotifyRangePos("whichkey.show", startPos[1], endPos[1], startPos[2], endPos[2], 1)
    endif
  endfunction


  command! -complete=file -nargs=? Split call <SID>split('h', <q-args>)
  command! -complete=file -nargs=? Vsplit call <SID>split('v', <q-args>)
  command! -complete=file -nargs=? New call <SID>split('h', '__vscode_new__')
  command! -complete=file -nargs=? Vnew call <SID>split('v', '__vscode_new__')
  command! -bang Only if <q-bang> == '!' | call <SID>closeOtherEditors() | else | call VSCodeNotify('workbench.action.joinAllGroups') | endif

  " Better Navigation
  nnoremap <silent> <C-j> :call VSCodeNotify('workbench.action.navigateDown')<CR>
  xnoremap <silent> <C-j> :call VSCodeNotify('workbench.action.navigateDown')<CR>
  nnoremap <silent> <C-k> :call VSCodeNotify('workbench.action.navigateUp')<CR>
  xnoremap <silent> <C-k> :call VSCodeNotify('workbench.action.navigateUp')<CR>
  nnoremap <silent> <C-h> :call VSCodeNotify('workbench.action.navigateLeft')<CR>
  xnoremap <silent> <C-h> :call VSCodeNotify('workbench.action.navigateLeft')<CR>
  nnoremap <silent> <C-l> :call VSCodeNotify('workbench.action.navigateRight')<CR>
  xnoremap <silent> <C-l> :call VSCodeNotify('workbench.action.navigateRight')<CR>

  nnoremap gr <Cmd>call VSCodeNotify('editor.action.goToReferences')<CR>

  " Bind C-/ to vscode commentary since calling from vscode produces double comments due to multiple cursors
  xnoremap <expr> <C-/> <SID>vscodeCommentary()
  nnoremap <expr> <C-/> <SID>vscodeCommentary() . '_'

  nnoremap <silent> <C-w>_ :<C-u>call VSCodeNotify('workbench.action.toggleEditorWidths')<CR>

  nnoremap <silent> , :call VSCodeNotify('whichkey.show')<CR>
  xnoremap <silent> <Space> :<C-u>call <SID>openWhichKeyInVisualMode()<CR>

  xnoremap <silent> <C-P> :<C-u>call <SID>openVSCodeCommandsInVisualMode()<CR>

else
  call plug#begin('~/.config/nvim/plugged')
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
  Plug 'https://github.com/easymotion/vim-easymotion', {'dir': g:plug_home.'/vim-easymotion-original'}
  Plug 'lyokha/vim-xkbswitch'
  Plug 'tpope/vim-abolish'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'tpope/vim-repeat'
  Plug 'haya14busa/incsearch.vim'
  Plug 'tpope/vim-surround'
  " Plug 'ayu-theme/ayu-vim' " or other package manager
  Plug 'dylanaraps/wal.vim'
  Plug 'junegunn/goyo.vim'
  Plug 'tpope/vim-commentary'
  Plug 'unblevable/quick-scope'
  Plug 'michaeljsmith/vim-indent-object'
  Plug 'bkad/CamelCaseMotion'
  call plug#end()
  colorscheme wal
  nnoremap <leader>ff <cmd>Telescope find_files<cr>
  nnoremap <leader>fg <cmd>Telescope live_grep<cr>
  nnoremap <leader>fb <cmd>Telescope buffers<cr>
  nnoremap <leader>fh <cmd>Telescope help_tags<cr>
  map <leader>f :Goyo \| set bg=light \| set linebreak<CR>
  let g:XkbSwitchEnabled = 1
  noremap j jzz
  noremap k kzz
  set number relativenumber
  set nu rnu
  set t_Co=256   " This is may or may not needed.
  inoremap <expr> <Tab> pumvisible() ? "\<C-y>" : "\<Tab>"

  " coc#refresh
  " Use <c-space> to trigger completion.
  inoremap <silent><expr> <TAB> pumvisible() ? coc#_select_confirm()
            \: "\<C-g>u\<TAB>\<c-r>=coc#on_enter()\<CR>"
  inoremap <silent><expr> <S-TAB>
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction
  if exists('g:started_by_firenvim')
    colorscheme wal
    set spell spelllang=en,cjk
    " set guifont=Operator\ Mono\ Lig:h24
    " set ft=markdown
    inoremap <D-v> <c-r>+
    let g:firenvim_config = { 
          \ 'globalSettings': {
          \ 'alt': 'all',
          \  },
          \ 'localSettings': {
          \ '.*': {
          \ 'cmdline': 'firenvim',
          \ 'priority': 0,
          \ 'selector': 'textarea',
          \ 'takeover': 'never',
          \ },
          \ }
          \ }
  endif
endif

let g:camelcasemotion_key = "<leader>"
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
map <Leader><Leader> <Plug>(easymotion-prefix)
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
map z/ <Plug>(incsearch-easymotion-/)
map z? <Plug>(incsearch-easymotion-?)
map zg/ <Plug>(incsearch-easymotion-stay)
map <Leader><Leader>j <Plug>(easymotion-j)
map <Leader><Leader>k <Plug>(easymotion-k)
map <leader><leader>h <Plug>(easymotion-linebackward)
map <leader><leader>l <Plug>(easymotion-lineforward)
map <leader><leader>. <Plug>(easymotion-repeat)
function! s:config_easyfuzzymotion(...) abort
  return extend(copy({
        \   'converters': [incsearch#config#fuzzy#converter()],
        \   'modules': [incsearch#config#easymotion#module()],
        \   'keymap': {"\<CR>": '<Over>(easymotion)'},
        \   'is_expr': 0,
        \   'is_stay': 1
        \ }), get(a:, 1, {}))
endfunction
noremap <silent><expr> <Space>/ incsearch#go(<SID>config_easyfuzzymotion())
let s:pattern = '^\(.* \)\([1-9][0-9]*\)$'
let s:minfontsize = 6
let s:maxfontsize = 16
function! AdjustFontSize(amount)
  if has("gui_gtk2") && has("gui_running")
    let fontname = substitute(&guifont, s:pattern, '\1', '')
    let cursize = substitute(&guifont, s:pattern, '\2', '')
    let newsize = cursize + a:amount
    if (newsize >= s:minfontsize) && (newsize <= s:maxfontsize)
      let newfont = fontname . newsize
      let &guifont = newfont
    endif
  else
    echoerr "You need to run the GTK2 version of Vim to use this function."
  endif
endfunction

function! LargerFont()
  call AdjustFontSize(1)
endfunction
command! LargerFont call LargerFont()

function! SmallerFont()
  call AdjustFontSize(-1)
endfunction
command! SmallerFont call SmallerFont()

" prose function
let g:ProseOn=0

function! ToggleProse()
    if !g:ProseOn
        call Prose()
    else
        call ProseOff()
    endif
endfunction

function! Prose()
    echo "Prose: On"
    let g:ProseOn=1
    if exists('g:vscode')
      noremap j :<C-u>call VSCodeCall('cursorMove', { 'to': 'down', 'by': 'wrappedLine', 'value': v:count ? v:count : 1 })<CR>
      noremap k :<C-u>call VSCodeCall('cursorMove', { 'to': 'up', 'by': 'wrappedLine', 'value': v:count ? v:count : 1 })<CR>
    else
      noremap j gj
      noremap k gk
    endif
    noremap H g^
    noremap L g$
    noremap A g$a
    noremap I g0i
    setlocal linebreak nonumber norelativenumber t_Co=0 foldcolumn=2
    hi! link FoldColumn Normal
endfunction

function! ProseOff()
    echo "Prose: Off"
    let g:ProseOn=0

    noremap j j
    noremap k k
    noremap H ^
    noremap L $
    noremap A A
    noremap I I
    setlocal nolinebreak number relativenumber t_Co=256 foldcolumn=0

endfunction
" end prose ===================
"
nm <leader><leader>d :call ToggleDeadKeys()<CR>
imap <leader><leader>d <esc>:call ToggleDeadKeys()<CR>a
nm <leader><leader>i :call ToggleIPA()<CR>
imap <leader><leader>i <esc>:call ToggleIPA()<CR>a
nm <leader><leader>p :call ToggleProse()<CR>
