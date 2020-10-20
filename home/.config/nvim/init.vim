" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={,} foldmethod=marker spell:

" Pre-Workarounds {

" Needs to be defined before loading polyglot
let g:polyglot_disabled = ['python']

" }

" Initialization / load bundles {
if has('vim_starting')
  set nocompatible
endif

let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')

" If this fails, it's usually because we're in the fish shell. Run once in
" bash first.
if !filereadable(vimplug_exists)
  echo "Installing Vim-Plug..."
  echo ""
  silent !\curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  let g:not_finish_vimplug = "yes"

  au VimEnter * PlugInstall
endif

call plug#begin(expand('~/.config/nvim/plugged'))

source ~/.config/nvim/bundles-shared.vim
source ~/.config/nvim/bundles.vim

call plug#end()

filetype plugin indent on

" https://github.com/zchee/deoplete-jedi/wiki/Setting-up-Python-for-Neovim
let g:python3_host_prog=$HOME . '/.pyenv/versions/3.7.9/envs/neovim3/bin/python3'
" }

" Load shared init {
if filereadable(expand("~/.config/nvim/init-shared.vim"))
  source ~/.config/nvim/init-shared.vim
endif
" }

" Load shared mappings {
if filereadable(expand("~/.config/nvim/mappings.vim"))
  source ~/.config/nvim/mappings.vim
endif
" }

" Mappings - nvim specific {

" Edit init.vim
nnoremap <silent> <leader>ev :e $HOMESHICK_REPOS/runcom/home/.config/nvim/init.vim<CR>

" Reload init.vim
nnoremap <silent> <leader>er :source $MYVIMRC<CR>:filetype detect<CR>:exe ":echo $MYVIMRC 'reloaded'"<CR>

" }

" Autocommands {

"" The PC is fast enough, do syntax highlight syncing from start unless 200 lines
augroup vimrc-sync-fromstart
  au!
  au BufEnter * :syntax sync maxlines=200
augroup END

"" Remember cursor position
augroup vimrc-remember-cursor-position
  au!
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

"" Remember Folds (TODO: what else is remembered? / do we need a clear cmd?)
augroup vimrc-autosave-folds
  au!
  au BufWinLeave *.txt,*.md,*.py,*.vim mkview
  au BufWinEnter *.txt,*.md,*.py,*.vim silent! loadview
augroup END

" }

" Autocommands & language-specific configs {

" yaml
augroup vimrc-yaml
  au!
  au Filetype yaml setlocal ts=2 sts=2 sw=2 expandtab indentkeys-=0# indentkeys-=<:>
augroup END

" html
" for html files, 2 spaces
augroup vimrc-html
  au!
  au Filetype html setlocal ts=2 sw=2 expandtab
augroup END

" python {
" vim-python
augroup vimrc-python
  au!
  au FileType python setlocal expandtab shiftwidth=4 tabstop=8 colorcolumn=80,100
        \ formatoptions+=croq softtabstop=4
        \ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
augroup END

" jedi-vim
let g:jedi#popup_on_dot = 0
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = "<leader>d"
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#rename_command = "<leader>r"
let g:jedi#show_call_signatures = "0"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#smart_auto_mappings = 0

" Syntax highlight
" Default highlight is better than polyglot
let python_highlight_all = 1

" }

" }

" Plugin Settings {

" FZF {
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"

" The Silver Searcher
if executable('ag')
  let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
  set grepprg=ag\ --nogroup\ --no-color
endif
" }

" ALE {
let g:ale_sign_error = '»'
let g:ale_sign_warning = '•'
let g:ale_lint_delay = 1000
let g:ale_fix_on_save = 1
let g:ale_python_flake8_options = '--ignore=E501'
"let g:ale_fix_on_save_ignore = ['']

" python autopep8, isort, yapf
let g:ale_fixers = {
\   'rust': [
\      'rustfmt'
\   ],
\   'python': [
\      'isort',
\      'black'
\   ],
\   'javascript': [
\      'eslint',
\      'prettier'
\   ],
\   'html': [
\      'prettier'
\   ],
\   'css': [
\      'prettier',
\      'stylelint'
\   ]
\}

" }

" Lightline {

set noshowmode      " disabled, since it's displayed by lightline
set showtabline=2   " needed for lightline-tabline

let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste'],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified', 'workdir', 'gutentag' ] ],
      \   'right': [
      \              [ 'linter_checking', 'linter_warnings', 'linter_errors', 'linter_ok'],
      \              [ 'wordcount', 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'pencil', 'filetype', ]
      \            ],
      \ },
      \ 'tabline': {
      \   'left': [ ['buffers'] ],
      \   'right': [ ['close'] ]
      \ },
      \ }

let g:lightline.component = {
      \   'helloworld': 'Hello, World!',
      \   'charvaluehex': '0x%B',
      \ }

let g:lightline.component_function = {
      \   'gitbranch': 'fugitive#head',
      \   'wordcount': 'wordCount#WordCount',
      \   'workdir': 'Foobar',
      \   'pencil': 'PencilMode',
      \   'gutentag': 'gutentag#statusline',
      \ }

let g:lightline.component_type = {
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'left',
      \     'buffers': 'tabsel',
      \ }

let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \  'buffers': 'lightline#bufferline#buffers',
      \ }

let g:lightline#ale#indicator_checking = "\uf110"
let g:lightline#ale#indicator_warnings = "\uf071"
let g:lightline#ale#indicator_errors = "\uf05e"
let g:lightline#ale#indicator_ok = "\uf00c"

" }

" Pencil {
"let g:pencil#mode_indicators = {'hard': '␍', 'auto': 'ª', 'soft': '⤸', 'off': '',}
let g:pencil#mode_indicators = {'hard': '', 'auto': '', 'soft': '⤸', 'off': '',}
" }

" NERDTree {
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 50
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
" }

" Completion (ncm2) {

autocmd BufEnter * call ncm2#enable_for_buffer()

" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

"let g:ncm2_look_mark = '👀'
"let g:ncm2_look_enabled = 0

set shortmess+=c

inoremap <c-c> <ESC>
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" }

" }

" Workarounds {

" For autoread
" https://stackoverflow.com/questions/2490227/how-does-vims-autoread-work
" From: https://github.com/fphilipe/dotfiles/blob/64c0921d3601edf8c2a59e24097a80f430ad215c/vimrc#L183-L188
"
" Save whenever switching windows or leaving vim. This is useful when running
" the tests inside vim without having to save all files first.
"au FocusLost,WinLeave * :silent! wa
" (disabled until I've had a chance to think through implications)

" Trigger autoread when changing buffers or coming back to vim.
augroup focus_workaround
  au!
  au FocusGained,BufEnter * :silent! !
augroup END

" Fix neovim color problems in hyper terminal
" https://github.com/zeit/hyper/issues/364
set termguicolors

" Speed up alacritty on OSX
hi! Normal ctermbg=NONE guibg=NONE
hi! NonText ctermbg=NONE guibg=NONE

" Override search highlights
" https://upload.wikimedia.org/wikipedia/commons/1/15/Xterm_256color_chart.svg
set hlsearch
hi! Search guifg=lightgrey guibg=236 ctermfg=lightgrey ctermbg=236
hi! IncSearch guifg=lightgrey guibg=236 ctermfg=lightgrey ctermbg=236

hi! MatchParen guibg=#3a3a3a
hi! Sneak guibg=#3a3a3a
hi! SneakScope guibg=#3a3a3a

" Allow crontab editing
set backupskip=/tmp/*,/private/tmp/*

" Make yaml front matter in notes look like a comment
augroup vimrc-yaml-notes
  au!
  au BufNewFile,BufRead */notes/*.md syntax match Comment /\%^---\_.\{-}---$/
augroup END
"}

" Disabled {

"let g:make = 'gmake'
"if exists('make')
  "let g:make = 'make'
"endif

"" make/cmake
"augroup vimrc-make-cmake
  "au!
  "au FileType make setlocal noexpandtab
  "au BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
"augroup END

" Prose / markdown / txt {
"function! MarkdownWriting()
  " call pencil#init()
  "call lexical#init()
  "call litecorrect#init()
  "call textobj#quote#init()
  "call textobj#sentence#init()

  " manual reformatting shortcuts
  "nnoremap <buffer> <silent> Q gqap
  "xnoremap <buffer> <silent> Q gq
  "nnoremap <buffer> <silent> <leader>Q vapJgqap

  " force top correction on most recent misspelling
  "nnoremap <buffer> <c-s> [s1z=<c-o>
  "inoremap <buffer> <c-s> <c-g>u<Esc>[s1z=`]A<c-g>u

  " replace common punctuation
  "iabbrev <buffer> -- –
  "iabbrev <buffer> --- —
  "iabbrev <buffer> << «
  "iabbrev <buffer> >> »

  " open most folds
  "setlocal foldlevel=6

  " replace typographical quotes (reedes/vim-textobj-quote)
  "map <silent> <buffer> <leader>qc <Plug>ReplaceWithCurly
  "map <silent> <buffer> <leader>qs <Plug>ReplaceWithStraight

  " highlight words (reedes/vim-wordy)
  "noremap <silent> <buffer> <F8> :<C-u>NextWordy<cr>
  "xnoremap <silent> <buffer> <F8> :<C-u>NextWordy<cr>
  "inoremap <silent> <buffer> <F8> <C-o>:NextWordy<cr>

"endfunction

" automatically initialize buffer by file type
"augroup vimrc-markdownwriting
  "au!
  "au FileType markdown,mkd call MarkdownWriting()
"augroup END

" invoke manually by command for other file types
"command! -nargs=0 MarkdownWriting call MarkdownWriting()

" }

" }
