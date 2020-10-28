set encoding=utf-8

" default file types
set ffs=unix,dos,mac

" doc strs
au BufNewFile,BufRead *.py set tabstop=4
au BufNewFile,BufRead *.py set softtabstop=4
au BufNewFile,BufRead *.py set shiftwidth=4
au BufNewFile,BufRead *.py set textwidth=79
au BufNewFile,BufRead *.py set expandtab
au BufNewFile,BufRead *.py set autoindent
au BufNewFile,BufRead *.py set fileformat=unix

au BufNewFile,BufRead *.js,*.html,*.css,*.jsx,*.json,*.scss,*.less set tabstop=2
au BufNewFile,BufRead *.js,*.html,*.css,*.jsx,*.json,*.scss,*.less set softtabstop=2
au BufNewFile,BufRead *.js,*.html,*.css,*.jsx,*.json,*.scss,*.less set shiftwidth=2

au BufRead,BufNewFile *.sql set ai sw=4 sts=4 et tw=72

" special filetypes
au BufNewFile *.html,*.py,*.pyw,*.c,*.h,*.json set fileformat=unix
au! BufRead,BufNewFile *.json setfiletype json
au BufNewFile,BufRead *.less set filetype=less
au BufNewFile,BufRead *.scss set filetype=sass
au BufNewFile,BufRead *.styl set filetype=styl
au BufNewFile,BufRead *.groovy set filetype=groovy
au BufNewFile,BufRead *.erb set filetype=ruby

let python_highlight_all=1
syntax on

" bad whitespace
highlight BadWhitespace ctermbg=red guibg=red
" display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

filetype plugin indent on
set iskeyword+=.

" don not be compatible with vi
set nocompatible

" Tell vim which characters to show for expanded TABs,
" trailing whitespace, and end-of-lines. VERY useful!
"set list
"set listchars=tab:\|-,trail:·

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" searching patterns
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" search is case insensitive
set ignorecase
" search case sensitive if caps on
set smartcase
" show best match so far
set incsearch
" Highlight matches to the search
set hlsearch

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" display
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" I use dark background
set background=dark
" Don't repaint when scripts are running
set lazyredraw
" Keep 3 lines below and above the cursor
set scrolloff=3
" row and column cursor is on
set cursorline cursorcolumn
" line numbers and column the cursor is on
set ruler
" Show line numbering
set number
" Use 1 col + 1 space for numbers
set numberwidth=1
set ttyfast

" tab labels show the filename without path(tail)
set guitablabel=%N/\ %t\ %M

if exists(":tab")
	" Try to move to other windows if changing buf
	set switchbuf=useopen,usetab
else
	" Try other windows & tabs if available
	set switchbuf=useopen
endif

" add mouse interaction
if has('mouse')
  set mouse=a
endif

" We know xterm-debian is a color terminal
if &term =~ "xterm-debian" || &term =~ "xterm-xfree86"
  set t_Co=16
  set t_Sf=[3%dm
  set t_Sb=[4%dm
else
  set t_Co=256
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" messages, info, status
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use [+] [RO] [w] for modified, read-only, modified
set shortmess+=a
" Display what command is waiting for an operator
set showcmd
" Always show statusline, even if only 1 window
set laststatus=2
set statusline=%<%F%m%r%y%=%b\ 0x%B\ \ %l,%c%V\ %P
" Notify me whenever any lines have changed
set report=0
" Y-N-C prompt if closing with unsaved changes
set confirm
" Disable visual bell!  I hate that flashing.
set vb t_vb=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" editing
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"set autochdir
" backspace over anything! (Super backspace!)
set backspace=indent,eol,start
" For .2 seconds
set matchtime=2
" I can format for myself, thank you very much
set formatoptions-=tc
set nosmartindent
set autoindent
set cindent
" tab stop of 4
set tabstop=4
" sw 4 spaces (used on auto indent)
set shiftwidth=4
" 4 spaces as a tab for bs/del
set softtabstop=4
" specially for html
set matchpairs+=<:>
" briefly jump to the previous matching parent
set showmatch
" remember more commands and search history
set history=1000
" se many muchos levels of undo
set undolevels=1000
" Autocomplete features in the status bar
set wildmenu
set wildmode=longest,list
set wildignore=*.o,*.obj,*.bak,*.exe,*.py[co],*.swp,*~,*.class
" paste mode
set pastetoggle=<F2>
set clipboard=unnamed

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" autocommands
""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" delete trailing white space, useful for Python ;)
""""""""""""""""""""""""""""""""""""""""""""""""""""""
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite * :call DeleteTrailingWS()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" python with virtualenv support
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"py << EOF
"import os
"import sys
"if 'VIRTUAL_ENV' in os.environ:
"  project_base_dir = os.environ['VIRTUAL_ENV']
"  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
"  execfile(activate_this, dict(__file__=activate_this))
"EOF

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-plug
""""""""""""""""""""""""""""""""""""""""""""""""""""""
if empty(glob('~/.nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.nvim/plugged')

" Make sure you use single quotes

" Colors
Plug 'joshdick/onedark.vim'

" Status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Initial page
Plug 'mhinz/vim-startify'

" Icons
Plug 'ryanoasis/vim-devicons'

" Nerd stuff
Plug 'preservim/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'junegunn/fzf.vim'

" Git
Plug 'tpope/vim-fugitive'

" Python it!
Plug 'jeetsukumaran/vim-pythonsense'
Plug 'sheerun/vim-polyglot'
Plug 'jiangmiao/auto-pairs'

" Code completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Snippets
Plug 'honza/vim-snippets', {'for': ['sh', 'python', 'django', 'htmldjango', 'javascript', 'javascript_react', 'json', 'markdown']}

" Initialize plugin system
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""
" function keys
""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>

nnoremap <C-c> :bdelete<CR>
nmap <C-S-Left> :tabprevious<cr>
map <C-S-Left> :tabprevious<cr>
imap <C-S-Left> <ESC>:tabprevious<cr>
nmap <C-S-Right> :tabnext<cr>
map <C-S-Right> :tabnext<cr>
imap <C-S-Right> <ESC>:tabnext<cr>
nmap <C-t> :tabnew<cr>
map <C-t> :tabnew<cr>
imap <C-t> <ESC>:tabnew<cr>

nmap <C-k> :bp<CR>
nmap <C-j> :bn<CR>

" Ctrl + Arrows - Move around quickly
nnoremap <c-up> {
nnoremap <c-down> }

" Shift + Arrows - Visually Select text
nnoremap  <s-up>     Vk
nnoremap  <s-down>   Vj
nnoremap  <s-right>  vl
nnoremap  <s-left>   vh

map <leader>cs :mksession! ~/.nvim/session<CR>
map <leader>ls :source ~/.nvim/session<CR>

map q :q<CR>

" Some Debian-specific things
if has("autocmd")
  augroup filetype
    au BufRead reportbug.*		set ft=mail
    au BufRead reportbug-*		set ft=mail
  augroup END
endif

" Set paper size from /etc/papersize if available (Debian-specific)
if filereadable("/etc/papersize")
  try
    let s:shellbak = &shell
    let &shell="/bin/sh"
    let s:papersize = matchstr(system("cat /etc/papersize"), "\\p*")
    let &shell=s:shellbak
    if strlen(s:papersize)
      let &printoptions = "paper:" . s:papersize
    endif
  catch /^Vim\%((\a\+)\)\=:E145/
  endtry
endif

" grep in files
cabbrev lvim
      \ lvim /\<lt><C-R><C-W>\>/gj
      \ **/*<C-R>=(expand("%:e")=="" ? "" : ".".expand("%:e"))<CR>
      \ <Bar> lw
      \ <C-Left><C-Left><C-Left>


""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Startify
""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:startify_files_number           = 8
let g:startify_bookmarks = ['~/.dotfiles/nvim/init.vim']

" Update session automatically as you exit vim
let g:startify_session_persistence    = 1

" Fancy custom header
let g:startify_custom_header = [
  \ "  ",
  \ '   ╻ ╻   ╻   ┏┳┓',
  \ '   ┃┏┛   ┃   ┃┃┃',
  \ '   ┗┛    ╹   ╹ ╹',
  \ '   ',
  \ ]


""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Airline
""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme onedark
set guifont=Ubuntu\ Mono\ derivative\ Powerline:12
let g:Powerline_symbols = 'fancy'
let g:airline_theme='onedark'
let g:airline_powerline_fonts=1
let g:airline_skip_empty_sections = 1
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#formatter = 'unique_tail'

""""""""""""""""""""""""""""""""""""""""""""""""""""""
" toggle comments with NERDCommenter
""""""""""""""""""""""""""""""""""""""""""""""""""""""
vmap <C-c> <Leader>c<space>gv
map <C-c> <Leader>c<space>

""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autolaunch NERDTree
""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDTreeWinPos = "left"
let g:NERDTreeIgnore = []
let g:NERDTreeGitStatusUseNerdFonts = 1

map <C-b> :NERDTreeToggle<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF
""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:fzf_layout = { 'up' : '20%' }

let $FZF_DEFAULT_OPTS=' --layout=reverse --margin=1'
let g:fzf_layout = { 'window': 'call FloatingFZF()' }

function! FloatingFZF()
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')

  let height = 20
  let width = 120
  let horizontal = float2nr(width / 2)
  let vertical = 1

  let opts = {
        \ 'relative': 'editor',
        \ 'row': vertical,
        \ 'col': horizontal,
        \ 'width': width,
        \ 'height': height,
        \ 'style': 'minimal'
        \ }

  call nvim_open_win(buf, v:true, opts)
endfunction

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

nnoremap <silent> <leader>f :FZF<cr>
nnoremap <silent> <leader>F :FZF ~<cr>
nnoremap <silent> <leader>w :FZF ~/workplace<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""
" coc.nvim
""""""""""""""""""""""""""""""""""""""""""""""""""""""

" TextEdit might fail if hidden is not set.
"set hidden

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
if has("patch-8.1.1564")
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
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

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
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}

let g:coc_filetype_map = {
  \ 'htmldjango': 'html',
  \ 'django': 'python',
  \ }

let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python3'
