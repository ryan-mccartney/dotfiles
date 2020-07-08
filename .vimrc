"Allow project specific .vimrc execution
set exrc

"Disable unsafe commands since we are allowing project specific .vimrc file execution
set secure

"no backup files
set nobackup

"only in case you don't want a backup file while editing
set nowritebackup

"no swap files
set noswapfile

" No wrapping
set nowrap

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=500

" all utf-8
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8

" enable backspace...
set bs=2

"show line numbers
set number

"highlight search results when using /
set hlsearch

"Allow using system clipboard
set clipboard=unnamed

" Show white spaces a
set listchars=tab:>·,trail:~,extends:>,precedes:<,space:·
set list

" Move the cursor to matched string while typing searches
set incsearch

" 4 spaces indentation
set tabstop=4 softtabstop=0 expandtab shiftwidth=4

" Deal with unwanted white spaces (show them in red)
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

"Let's setup the plugins
call plug#begin()

Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ctrlpvim/ctrlp.vim'
Plug 'OmniSharp/omnisharp-vim'
Plug 'mhinz/vim-signify'
Plug 'nickspoons/vim-sharpenup'
Plug 'arzg/vim-colors-xcode'
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'
Plug 'dense-analysis/ale'
Plug 'vim-scripts/dbext.vim'
Plug 'tpope/vim-dispatch'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'dyng/ctrlsf.vim'
Plug 'wellle/context.vim'
Plug 'gabesoft/vim-ags'

call plug#end()

" ====== coc settings start =============================
let g:coc_global_extensions=[ 'coc-omnisharp', 'coc-json', 'coc-sql', 'coc-eslint', 'coc-html', 'coc-db' ]

" NOTE: For XAML files, in vim you can run :setf xml
" and this will treat it as an xml file and will show coloring which makes it easier to read.

" ====== coc settings end ===============================

" ========= airline settings start ======================

" to see the full path of the editing file
let g:airline#extensions#tabline#formatter = 'unique_tail'

let g:airline_powerline_fonts = 1

" show branch information
let g:airline#extensions#branch#enabled = 1
let g:airline_theme='badwolf'

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.maxlinenr = '㏑'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.whitespace = 'Ξ'

" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.dirty='⚡'

let g:airline#extensions#tabline#enabled = 1
" ========= airline settings end ========================

" =============== OmniSharp settings start===============
" OmniSharp won't work without this setting
filetype plugin on

" Use Roslyn and also better performance than HTTP
let g:OmniSharp_server_stdio = 1
let g:omnicomplete_fetch_full_documentation = 1
let g:OmniSharp_want_snippet=1
"let g:OmniSharp_selector_ui = 'fzf'

" Popup options
let g:OmniSharp_popup_options = {
\ 'highlight': 'Normal',
\ 'padding': [1],
\ 'border': [1]
\}

" Timeout in seconds to wait for a response from the server
let g:OmniSharp_timeout = 30

" this will make it so any subsequent C# files that you open are using the same solution and you aren't prompted again (so you better choose the right solution the first time around :) )
let g:OmniSharp_autoselect_existing_sln = 1
" =============== OmniSharp settings end=================

" =================== ALE Settings Start ================
let g:ale_linters = { 'cs': ['OmniSharp'] }
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_list_window_size = 5

" =================== ALE Settings End ==================

" =================== FZF Settings End ==================
nmap <leader>fz :FZF<cr>
" This is the default extra key bindings
let g:fzf_action = {
\ 'ctrl-t': 'tab split',
\ 'ctrl-x': 'split',
\ 'ctrl-n': 'vsplit'
\}
" =================== FZF Settings End ==================

" =================== CtrlSF Settings ===================
nmap <C-F>f <Plug>CtrlSFPrompt
vmap <C-F>f <Plug>CtrlSFVwordPath
vmap <C-F>F <Plug>CtrlSFVwordExec

" vim-ags Settings as well
" Search for the word under cursor
nnoremap <Leader>s :Ags<Space><C-R>=expand('<cword>')<CR><CR>
" Search for the visually selected text
vnoremap <Leader>s y:Ags<Space><C-R>='"' . escape(@", '"*?()[]{}.') . '"'<CR><CR>
" Run Ags
nnoremap <Leader>a :Ags<Space>
" Quit Ags
nnoremap <Leader><Leader>a :AgsQuit<CR>
" =======================================================


" =================NERDTree settings start===============
" For more docos check out https://github.com/preservim/nerdtree/blob/master/doc/NERDTree.txt
" Open new NERDTree instance bt typing nto
nmap nt :NERDTree<cr>
" Open existing NERDTree buffer (if any) at current tab
nmap ntm :NERDTreeMirror<cr>
" Refresh NT to current file
nmap <leader>r :NERDTreeFind<cr>
" If you are using vim-plug, you'll also need to add these lines to avoid crashes when calling vim-plug functions while the cursor is on the NERDTree window
let g:plug_window = 'noautocmd vertical topleft new'
" =================NERDTree settings end=================

" =================vim Sharpenup settings start==========
" note that using CTRL isn't feasible so we will use z instead, I chose z because it's the closest key to left ctrl
let g:sharpenup_map_prefix = '.'
" =================vim Sharpenup settings end============

" ================= Generic Keybind Mappings ============
" Resize splits using Arrowkey
map <silent> <Left> <C-w>>
map <silent> <Down> <C-w>+
map <silent> <Up> <C-w>-
map <silent> <Right> <C-w><
" Swap splits using Shift+Arrowkey
map <silent> <S-Left> <C-w>H
map <silent> <S-Down> <C-w>J
map <silent> <S-Up> <C-w>K
map <silent> <S-Right> <C-w>L
" =======================================================

" ============= Generic Settings and Funcs  =============
set number relativenumber

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" =======================================================

" Bookmarks:
" It's best to use vim's native bookmarks:
" https://www.thegeekstuff.com/2009/02/how-to-add-bookmarks-inside-vi-and-vim-editor/
" I personally use numbers because they are easier to remember and are global

" fix colors
set t_Co=256

" use awesome Xcode dark color scheme (for some reason this only works if I specify it at the end of the file)
colorscheme xcodedark
syntax on
