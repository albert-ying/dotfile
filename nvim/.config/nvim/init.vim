set nocompatible
filetype plugin on
syntax on
set clipboard+=unnamedplus
set undofile
set incsearch
let g:EasyMotion_verbose = 0
" set nojoinspaces
"g Leader key
noremap \ ,
let mapleader=" "
noremap H ^
noremap L $
noremap Y y$
noremap <leader>H H
noremap <leader>L L
noremap n nzz
noremap N Nzz
noremap J mzJ`z
noremap <c-d> 20jzz
noremap <c-u> 20kzz
nnoremap <leader>o mzo<Esc>`z`z
nnoremap <leader>O mzO<Esc>`z`z

" input breakpoint
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

" moving text
nnoremap <leader>j :m .+1<CR>==
nnoremap <leader>k :m .-2<CR>==
vnoremap <leader>j :m '>+1<CR>gv=gv
vnoremap <leader>k :m '>-2<CR>gv=gv
nnoremap gp `[v`]

set tabstop=2
set shiftwidth=2
set expandtab

inoremap � <c-w>
inoremap <M-BS> <c-w>

" Better indenting
vnoremap < <gv
vnoremap > >gv
if exists('g:vscode')
  nnoremap gk :<C-u>call VSCodeCall('cursorMove', { 'to': 'up', 'by': 'wrappedLine', 'value': v:count ? v:count : 1 })<CR>
  nnoremap gj :<C-u>call VSCodeCall('cursorMove', { 'to': 'down', 'by': 'wrappedLine', 'value': v:count ? v:count : 1 })<CR>
  call plug#begin('~/.config/nvim/plugged')
  " Plug 'lyokha/vim-xkbswitch'
  Plug 'FooSoft/vim-argwrap'
  Plug 'ybian/smartim'
  Plug 'ChristianChiarulli/vscode-easymotion'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-abolish'
  Plug 'haya14busa/incsearch.vim'
  Plug 'haya14busa/incsearch-easymotion.vim'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  " Plug 'tpope/vim-surround'
  Plug 'unblevable/quick-scope'
  Plug 'michaeljsmith/vim-indent-object'
  Plug 'bkad/CamelCaseMotion'
  Plug 'wellle/targets.vim'
  Plug 'godlygeek/tabular'
  Plug 'junegunn/vim-easy-align'
  " Plug 'justinmk/vim-sneak'
  Plug 'ferrine/md-img-paste.vim'
  Plug 'kana/vim-textobj-user'
  Plug 'kana/vim-textobj-function'
  Plug 'preservim/vim-textobj-sentence'
  Plug 'machakann/vim-sandwich'
  " Plug 'ggandor/lightspeed.nvim'
  call plug#end()
  set textwidth=145
  " map s <Plug>Lightspeed_omni_s
  " let g:XkbSwitchEnabled = 1
  " Simulate same TAB behavior in VSCode
  nnoremap <Tab> :Tabnext<CR>
  nnoremap <S-Tab> :Tabprev<CR>
  " Workaround for gk/gj
  "nnoremap gj j
  "nnoremap gk k
  " workaround for calling command picker in visual mode
  " function! VSCodeNotifyVisual(cmd, leaveSelection, ...)
  "     let mode = mode()
  "     if mode ==# 'V'
  "         let startLine = line('v')
  "         let endLine = line('.')
  "         call VSCodeNotifyRange(a:cmd, startLine, endLine, a:leaveSelection, a:000)
  "     elseif mode ==# 'v' || mode ==# "\<C-v>"
  "         let startPos = getpos('v')
  "         let endPos = getpos('.')
  "         call VSCodeNotifyRangePos(a:cmd, startPos[1], endPos[1], startPos[2], endPos[2] + 1, a:leaveSelection, a:000)
  "     else
  "         call VSCodeNotify(a:cmd, a:000)
  "     endif
  " endfunction

  xnoremap <D-P> <Cmd>call VSCodeNotifyVisual('workbench.action.showCommands', 1)<CR>

  augroup filetypedetect

    " R
    autocmd! BufNewFile,BufRead *.[rRsS] setfiletype r
    autocmd! BufNewFile,BufRead *.[rR]history setfiletype r
    autocmd! BufNewFile,BufRead *.rmd setfiletype markdown
    autocmd! BufNewFile,BufRead *.md setfiletype markdown

  augroup END

  xnoremap <silent> <D-CR> <Cmd>call VSCodeNotifyVisual('workbench.action.terminal.runSelectedText', 1)<CR>
  " au FileType r xnoremap <silent> <D-CR> <Cmd>call VSCodeNotifyVisual('workbench.action.showCommands', 1)<CR><Esc>call VSCodeNotify('r.runSelection')<CR>
  au FileType r xnoremap <silent> <D-CR> <Cmd>call VSCodeNotifyVisual('workbench.action.files.save', 1)<CR><Cmd>call VSCodeCall('r.runSelection')<CR>

  xmap gc  <Plug>VSCodeCommentary
  nmap gc  <Plug>VSCodeCommentary
  omap gc  <Plug>VSCodeCommentary
  nmap gcc <Plug>VSCodeCommentaryLine

  highlight OperatorSandwichBuns guifg='#aa91a0' gui=underline ctermfg=172 cterm=underline 
  highlight OperatorSandwichChange guifg='#edc41f' gui=underline ctermfg='yellow' cterm=underline
  highlight OperatorSandwichAdd guibg='#b1fa87' gui=none ctermbg='green' cterm=none
  highlight OperatorSandwichDelete guibg='#cf5963' gui=none ctermbg='red' cterm=none


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
  nnoremap gx <Cmd>call VSCodeNotify('editor.action.openLink')<CR>

  " Bind C-/ to vscode commentary since calling from vscode produces double comments due to multiple cursors
  xnoremap <expr> <C-/> <SID>vscodeCommentary()
  nnoremap <expr> <C-/> <SID>vscodeCommentary() . '_'

  nnoremap <silent> <C-w>_ :<C-u>call VSCodeNotify('workbench.action.toggleEditorWidths')<CR>

  nnoremap <silent> , :call VSCodeNotify('whichkey.show')<CR>
  xnoremap <silent> , :<C-u>call <SID>openWhichKeyInVisualMode()<CR>

  xnoremap <silent> <C-P> :<C-u>call <SID>openVSCodeCommandsInVisualMode()<CR>

  augroup textobj_sentence
    autocmd!
    autocmd FileType markdown call textobj#sentence#init()
    autocmd FileType textile call textobj#sentence#init()
  augroup END

else
  call plug#begin('~/.config/nvim/plugged')
  Plug 'FooSoft/vim-argwrap'
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  " Plug 'nvim-telescope/telescope.nvim'
  Plug 'ybian/smartim'
  Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
  Plug 'https://github.com/easymotion/vim-easymotion', {'dir': g:plug_home.'/vim-easymotion-original'}
  Plug 'lyokha/vim-xkbswitch'
  Plug 'tpope/vim-abolish'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'tpope/vim-repeat'
  Plug 'haya14busa/incsearch.vim'
  " Plug 'tpope/vim-surround'
  " Plug 'ayu-theme/ayu-vim' " or other package manager
  Plug 'typkrft/wal.vim', {'dir': g:plug_home.'/gupywal', 'as': 'pywal_gui'}
  " Plug 'dylanaraps/wal.vim'
  Plug 'junegunn/goyo.vim'
  Plug 'itchyny/calendar.vim'
  Plug 'tpope/vim-commentary'
  Plug 'kristijanhusak/orgmode.nvim'
  Plug 'unblevable/quick-scope'
  Plug 'michaeljsmith/vim-indent-object'
  Plug 'bkad/CamelCaseMotion'
  Plug 'wellle/targets.vim'
  Plug 'godlygeek/tabular'
  Plug 'junegunn/vim-easy-align'
  " Plug 'justinmk/vim-sneak'
  Plug 'machakann/vim-sandwich'
  Plug 'kana/vim-textobj-user'
  Plug 'ferrine/md-img-paste.vim'
  Plug 'preservim/vim-textobj-sentence'
  Plug 'ggandor/lightspeed.nvim'
  call plug#end()
  colorscheme gupywal

  map s <Plug>Lightspeed_omni_s
  augroup textobj_sentence
    autocmd!
    autocmd FileType markdown call textobj#sentence#init()
    autocmd FileType textile call textobj#sentence#init()
  augroup END
  " Calendar
  source ~/.cache/calendar.vim/credentials.vim
  let g:calendar_google_calendar = 1
  let g:calendar_google_task = 1
  let g:goyo_width = '50%'
  nmap <silent> gx :!open <cWORD><cr>
  nnoremap <leader>ff <cmd>Telescope find_files<cr>
  nnoremap <leader>fg <cmd>Telescope live_grep<cr>
  nnoremap <leader>fb <cmd>Telescope buffers<cr>
  nnoremap <leader>fh <cmd>Telescope help_tags<cr>
  map <leader>f :Goyo <CR>
  let g:XkbSwitchEnabled = 1
  noremap j jzz
  noremap k kzz
  set termguicolors
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
  if exists('g:neovide')
    colorscheme gupywal
    " let g:neovide_cursor_animation_length=0.12
    let g:neovide_cursor_trail_length=5
    let g:neovide_cursor_vfx_mode = "pixiedust"
    let g:neovide_cursor_vfx_particle_lifetime=4
  endif
  if exists('g:started_by_firenvim')
    set spell spelllang=en,cjk
    set guifont=Operator\ Mono\ Lig:h30
    set ft=markdown
    set termguicolors
    colorscheme gupywal
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

" bind comment to <C-/>
" nmap <C-/> gcc
" vmap <C-/> gc
" greatest remap ever
vnoremap <leader>p "_dP

" next greatest remap ever : asbjornHaland
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG

" wrap paragraph
nnoremap <leader><leader>W gwip
nnoremap <leader><leader>J vipJ

nnoremap <leader>d "_d
vnoremap <leader>d "_dmap
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
      hi! link FoldColumn Normal
      setlocal linebreak nonumber norelativenumber t_Co=0 foldcolumn=2
    endif
    noremap H g^
    noremap L g$
    noremap A g$a
    noremap I g0i
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
    if !exists('g:vscode')
      setlocal nolinebreak number relativenumber t_Co=256 foldcolumn=0
    endif
endfunction
" end prose ===================
"
nm <leader><leader>d :call ToggleDeadKeys()<CR>
" imap <leader><leader>d <esc>:call ToggleDeadKeys()<CR>a
nm <leader><leader>i :call ToggleIPA()<CR>
" imap <leader><leader>i <esc>:call ToggleIPA()<CR>a
nm <leader><leader>p :call ToggleProse()<CR>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

call textobj#user#plugin('datetime', {
\   'date': {
\     'pattern': '\<\d\d\d\d-\d\d-\d\d\>',
\     'select': ['ad', 'id'],
\   },
\   'time': {
\     'pattern': '\<\d\d:\d\d:\d\d\>',
\     'select': ['at', 'it'],
\   },
\ })

" For R function

call textobj#user#plugin('functionx', {
\   'dae': {
\     'pattern': '\S\+(.*)',
\     'select': ['af'],
\   },
\ })

call textobj#user#plugin('functiony', {
\   'angle': {
\     'pattern': ['\S\+(', ')'],
\     'select-i': 'if',
\   },
\ })

" nmap <buffer><silent> <leader><leader>p :call mdip#MarkdownClipboardImage()<CR>
" " there are some defaults for image directory and image name, you can change them
" " let g:mdip_imgdir = 'img'
" " let g:mdip_imgname = 'image'
"

" Config Sandwich

let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)

let g:sandwich#recipes += [
      \   {
      \     'buns'        : ['{', '}'],
      \     'motionwise'  : ['line'],
      \     'kind'        : ['add'],
      \     'linewise'    : 1,
      \     'command'     : ["'[+1,']-1normal! >>"],
      \   },
      \   {
      \     'buns'        : ['{', '}'],
      \     'motionwise'  : ['line'],
      \     'kind'        : ['delete'],
      \     'linewise'    : 1,
      \     'command'     : ["'[,']normal! <<"],
      \   }
      \ ]

let g:sandwich#recipes += [
      \   {
      \     'buns'        : ['(', ')'],
      \     'motionwise'  : ['line'],
      \     'kind'        : ['add'],
      \     'linewise'    : 1,
      \     'command'     : ["'[+1,']-1normal! >>"],
      \   },
      \   {
      \     'buns'        : ['(', ')'],
      \     'motionwise'  : ['line'],
      \     'kind'        : ['delete'],
      \     'linewise'    : 1,
      \     'command'     : ["'[,']normal! <<"],
      \   }
      \ ]

let g:textobj_sandwich_no_default_key_mappings = 1
xmap ie <Plug>(textobj-sandwich-auto-i)
omap ie <Plug>(textobj-sandwich-auto-i)
xmap ae <Plug>(textobj-sandwich-auto-a)
omap ae <Plug>(textobj-sandwich-auto-a)

xmap iq <Plug>(textobj-sandwich-query-i)
omap iq <Plug>(textobj-sandwich-query-i)
xmap aq <Plug>(textobj-sandwich-query-a)
omap aq <Plug>(textobj-sandwich-query-a)
runtime macros/sandwich/keymap/surround.vim
nmap <silent> w <Plug>(coc-ci-w)
nmap <silent> b <Plug>(coc-ci-b)
" vmap <silent> w <Plug>(coc-ci-w)
" vmap <silent> b <Plug>(coc-ci-b)
" omap <silent> w <Plug>(coc-ci-w)
" omap <silent> b <Plug>(coc-ci-b)

nnoremap <silent> S f(l:ArgWrap<CR>


nmap s <Plug>(easymotion-s2)
map <Leader><Leader> <Plug>(easymotion-prefix)
map <leader><leader>/ <Plug>(easymotion-sn)
" map ? <Plug>(incsearch-backward)
" map g/ <Plug>(incsearch-stay)
" map  n <Plug>(easymotion-next)
" map  N <Plug>(easymotion-prev)
map <Leader><Leader>j <Plug>(easymotion-j)
map <Leader><Leader>k <Plug>(easymotion-k)
map <leader><leader>h <Plug>(easymotion-linebackward)
map <leader><leader>l <Plug>(easymotion-lineforward)
map <leader><leader>. <Plug>(easymotion-repeat)

