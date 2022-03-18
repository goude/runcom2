" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={,} foldmethod=marker spell:

" Pre-Workarounds {

" Needs to be defined before loading polyglot
let g:polyglot_disabled = ['python']

" set rtp+=~/tabnine-vim

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

source ~/.config/vim-shared/bundles-shared.vim
source ~/.config/nvim/bundles.vim

call plug#end()

filetype plugin indent on

" https://github.com/zchee/deoplete-jedi/wiki/Setting-up-Python-for-Neovim
"let g:python3_host_prog=$HOME . '/.pyenv/versions/3.7.9/envs/neovim3/bin/python3'
let g:python3_host_prog=$HOME . '/bin/neovim-python3'
" }

" Load shared init {
if filereadable(expand("~/.config/vim-shared/init-shared.vim"))
  source ~/.config/vim-shared/init-shared.vim
endif
" }

" Load shared mappings {
if filereadable(expand("~/.config/vim-shared/mappings.vim"))
  source ~/.config/vim-shared/mappings.vim
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

let g:ale_markdown_remark_lint_options = '--rc-path=$HOME/.remarkrc'

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
\   ],
\   'markdown': [
\      'prettier'
\   ],
\   'arduino': [
\      'clang-format'
\   ],
\   'cpp': [
\      'clang-format'
\   ],
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
      \ }

let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }

let g:lightline.colorscheme = 'gruvbox'

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

" Completion (CoC) {

" Configuration from coc readme.

" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
"nmap <silent> [g <Plug>(coc-diagnostic-prev)
"nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
"nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
"xmap <leader>f  <Plug>(coc-format-selected)
"nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
"xmap <leader>a  <Plug>(coc-codeaction-selected)
"nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
"nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
"nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
"xmap if <Plug>(coc-funcobj-i)
"omap if <Plug>(coc-funcobj-i)
"xmap af <Plug>(coc-funcobj-a)
"omap af <Plug>(coc-funcobj-a)
"xmap ic <Plug>(coc-classobj-i)
"omap ic <Plug>(coc-classobj-i)
"xmap ac <Plug>(coc-classobj-a)
"omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
"nmap <silent> <C-s> <Plug>(coc-range-select)
"xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
"nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
"" Manage extensions.
"nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
"" Show commands.
"nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
"" Find symbol of current document.
"nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
"" Search workspace symbols.
"nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
"" Do default action for next item.
"nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
"" Do default action for previous item.
"nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
"" Resume latest coc list.
"nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
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
"hi! Normal ctermbg=NONE guibg=NONE
"hi! NonText ctermbg=NONE guibg=NONE

" Make tildes go away
"hi! EndOfBuffer ctermfg=NONE guibg=NONE

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
