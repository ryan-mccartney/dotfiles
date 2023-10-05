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

" Don't add empty newlines at the end of files
set binary
set noeol

" Yank to clipboard
set clipboard=unnamed

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

" Show white spaces a
set listchars=tab:>·,trail:~,extends:>,precedes:<,space:·
set list

" 2 spaces indentation
set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab

" Enable command-line completion wildmenu menu type
set wildmenu

" Ignore case when searching
set ignorecase

" Show matching brackets when text indicator is over them
set showmatch
" Set how many tenths of a second to blink when matching brackets
set mat=2

" Disable error sounds and other annoying error notifications
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Set autowriteall - autosave buffers on most actions, like :edit :quit :next
" :previous etc.
set autowriteall

" Open new splits to the right instead of left
set splitright

" Deal with unwanted white spaces (show them in red)
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

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
"Plug 'wellle/context.vim'
Plug 'puremourning/vimspector'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'mhinz/vim-startify'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'folke/tokyonight.nvim'
Plug 'pangloss/vim-javascript'    " JavaScript support
Plug 'leafgarland/typescript-vim' " TypeScript syntax
Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax
Plug 'jparise/vim-graphql'        " GraphQL syntaxPlug 
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'junegunn/vim-after-object'
Plug 'tomtom/tcomment_vim'
"Plug 'chrisbra/vim-commentary' " This damn thing buggers up indents when commenting
Plug 'airblade/vim-gitgutter'
Plug 'vim-scripts/visSum.vim'

  autocmd VimEnter * silent! call after_object#enable('=', ':', '#', ' ', '|')
call plug#end()

" ====== coc settings start =============================
let g:coc_global_extensions=[ 'coc-omnisharp', 'coc-json', 'coc-sql', 'coc-eslint', 'coc-html', 'coc-db', 'coc-tsserver', 'coc-docthis' ]

" NOTE: For XAML files, in vim you can run :setf xml
" and this will treat it as an xml file and will show coloring which makes it easier to read.

" Use <c-space> to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

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
nmap <leader>rn <Plug>(coc-rename)

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

" Mappings for CoCList
" Show Code Actions under cursor
nnoremap <silent><nowait> <space>c :<C-u>CocAction<cr>
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
"nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
" ====== coc settings end ===============================

" ====== vimspector settings start =============================
let g:vimspector_enable_mappings = 'VISUAL_STUDIO'
" ====== vimspector settings end   =============================

" ========= airline settings start ======================

" to see the full path of the editing file
let g:airline#extensions#tabline#formatter = 'unique_tail'

" to see the buffer numbs in the top list of buffers
let g:airline#extensions#tabline#buffer_nr_show = 1

let g:airline_powerline_fonts = 1

" show branch information
let g:airline#extensions#branch#enabled = 1
"let g:airline_theme='badwolf'
let g:airline_theme='onedark'

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
let g:OmniSharp_selector_ui = 'ctrlp'

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

" Contextual code actions (using selector_ui)
nmap <silent> <buffer> <Leader>ca <Plug>(omnisharp_code_actions)
xmap <silent> <buffer> <Leader>ca <Plug>(omnisharp_code_actions)
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
" - Popup window
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
" =================== FZF Settings End ==================

" =================== CtrlSF Settings ===================
nmap <C-F>f <Plug>CtrlSFPrompt
vmap <C-F>f <Plug>CtrlSFVwordPath
vmap <C-F>F <Plug>CtrlSFVwordExec
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
" Set NerdTree Window Position
let g:NERDTreeWinPos = "left"
" =================NERDTree settings end=================

" =================vim Sharpenup settings start==========
let g:sharpenup_map_prefix = '.'
" =================vim Sharpenup settings end============

" =================VimRoom w/ Goyo ======================
let g:goyo_width=100
let g:goyo_margin_top=2
let g:goyo_margin_bottom=2
nnoremap <silent> <leader>z :Goyo<cr>
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
" Number of preceding/following paragraphs to include (default: 0)
" let g:limelight_paragraph_span=1
" =================VimRoom w/ Goyo ======================

" ================= Vim StatusLine Scrollbar ============
" func! STL()
" let stl = '%f [%{(&fenc==""?&enc:&fenc).((exists("+bomb") && &bomb)?",B":"")}%M%R%H%W] %y [%l/%L,%v] [%p%%]'
" let barWidth = &columns - 65 " <-- wild guess
" let barWidth = barWidth < 3 ? 3 : barWidth

" if line('$') > 1
" let progress = (line('.')-1) * (barWidth-1) / (line('$')-1)
" else
" let progress = barWidth/2
" endif

" line + vcol + %
" let pad = strlen(line('$'))-strlen(line('.')) + 3 - strlen(virtcol('.')) + 3 - strlen(line('.')*100/line('$'))
" let bar = repeat(' ',pad).' [%1*%'.barWidth.'.'.barWidth.'('
" \.repeat('-',progress )
" \.'%2*0%1*'
" \.repeat('-',barWidth - progress - 1).'%0*%)%<]'

" return stl.bar
" endfun

" hi def link User1 DiffAdd
" hi def link User2 DiffDelete
" set stl=%!STL()
" ================= Vim StatusLine Scrollbar ============

" ================= Generic Keybind Mappings ============
" Resize splits using Arrowkey
map <silent> <Left> 5<C-w>>
map <silent> <Down> 5<C-w>+
map <silent> <Up> 5<C-w>-
map <silent> <Right> 5<C-w><
" Swap splits using Shift+Arrowkey
map <silent> <S-Left> <C-w>H
map <silent> <S-Down> <C-w>J
map <silent> <S-Up> <C-w>K
map <silent> <S-Right> <C-w>L

" Quickly open a buffer for scribble
map <leader>q :e ~/buffer<cr>
" Quickly open a json buffer for JQ'ing and scribble
map <leader>j :e ~/buffer.json<cr>
" Make Y behave like other capitals
nnoremap Y y$
" =======================================================
" ----------------------------------------------------------------------------
" Buffers
" ----------------------------------------------------------------------------
nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>

" ----------------------------------------------------------------------------
" Tabs
" ----------------------------------------------------------------------------
nnoremap ]t :tabn<cr>
nnoremap [t :tabp<cr>

" ----------------------------------------------------------------------------
" <tab> / <s-tab> | Circular windows navigation
" ----------------------------------------------------------------------------
nnoremap <tab>   <c-w>w
nnoremap <S-tab> <c-w>W
" ============= Generic Settings and Funcs  =============
set number relativenumber

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

" Open a popup of the current line's git blame
map <silent><Leader>g :call setbufvar(winbufnr(popup_atcursor(systemlist("cd " . shellescape(fnamemodify(resolve(expand('%:p')), ":h")) . " && git log --no-merges -n 1 -L " . shellescape(line("v") . "," . line(".") . ":" . resolve(expand("%:p")))), { "padding": [1,1,1,1], "pos": "botleft", "wrap": 0 })), "&filetype", "git")<CR>

" Fast reload .vimrc whenever you save it
autocmd! bufwritepost ~/.vimrc source ~/.vimrc
" ----------------------------------------------------------------------------
" ?ii / ?ai | indent-object func for use with detecting line indents
" ----------------------------------------------------------------------------
function! s:indent_len(str)
  return type(a:str) == 1 ? len(matchstr(a:str, '^\s*')) : 0
endfunction
" ----------------------------------------------------------------------------
" #gi / #gpi | go to next/previous indentation level
" ----------------------------------------------------------------------------
function! s:go_indent(times, dir)
  for _ in range(a:times)
    let l = line('.')
    let x = line('$')
    let i = s:indent_len(getline(l))
    let e = empty(getline(l))

    while l >= 1 && l <= x
      let line = getline(l + a:dir)
      let l += a:dir
      if s:indent_len(line) != i || empty(line) != e
        break
      endif
    endwhile
    let l = min([max([1, l]), x])
    execute 'normal! '. l .'G^'
  endfor
endfunction
nnoremap <silent> gi :<c-u>call <SID>go_indent(v:count1, 1)<cr>
nnoremap <silent> gpi :<c-u>call <SID>go_indent(v:count1, -1)<cr>
" =======================================================
" Generic Autocmds/Commands

" Map a way to remove annoying msdos EOL characters in current file
" Autocmd runs on BufRead to automatically remove these, should they exist
nnoremap <leader>fd :u \| e!++ff=dos<cr>
autocmd BufRead * silent! exec 'u | e!++ff=dos'
" =======================================================
" Bookmarks:
" It's best to use vim's native bookmarks:
" https://www.thegeekstuff.com/2009/02/how-to-add-bookmarks-inside-vi-and-vim-editor/
" I personally use numbers because they are easier to remember and are global

" fix colors
set t_Co=256

" use awesome Xcode dark color scheme (for some reason this only works if I specify it at the end of the file)
colorscheme xcodedark
"colorscheme tokyonight-night
"colorscheme onehalfdark
syntax on