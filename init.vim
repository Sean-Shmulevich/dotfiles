call plug#begin('~/.local/share/nvim/plugged')
" the other day i was programming in python and i wanted to use the
Plug 'Rigellute/shades-of-purple.vim'
Plug 'frazrepo/vim-rainbow'
"" my fancy bar

Plug 'vim-airline/vim-airline'
"" Git Stuff
Plug 'glepnir/dashboard-nvim'
Plug 'jreybert/vimagit'
Plug 'tpope/vim-fugitive'
    " Branch Viewer for vim-fugitive
Plug 'rbong/vim-flog'
""undo history graph
""Plug 'sjl/gundo.vim'
"" file tree
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
" Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
" Plug 'jistr/vim-nerdtree-tabs'
"Plug 'https://github.com/scrooloose/nerdtree-project-plugin'
""Py venv
Plug 'jmcantrell/vim-virtualenv'

"" Syntax checking
"" Plug 'dense-analysis/ale'
"" File searching
"" Plug 'kien/ctrlp.vim'
 Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
 Plug 'junegunn/fzf.vim'
" " Plug 'preservim/nerdcommenter'brew install fd


 Plug 'terryma/vim-multiple-cursors'

 Plug 'prettier/vim-prettier'
 " gcc to comment out line gc to comment out block in visual mode
 Plug 'tpope/vim-commentary'

" " File outlining
 Plug 'majutsushi/tagbar'
" " syntax shecking

 Plug 'github/copilot.vim'
 Plug 'honza/vim-snippets'
 Plug 'mattn/emmet-vim'

 Plug 'https://github.com/ycm-core/YouCompleteMe'
" Plug 'davidhalter/jedi-vim'
" Mostly frontend stuff
 Plug 'othree/html5.vim'
 Plug 'plasticboy/vim-markdown'
 Plug 'elzr/vim-json'

 Plug 'pangloss/vim-javascript'
 Plug 'mxw/vim-jsx'

 Plug 'thosakwe/vim-flutter'
 Plug 'dart-lang/dart-vim-plugin'

 Plug 'evanleck/vim-svelte', {'branch': 'main'}
call plug#end()


set encoding=UTF-8
if (has("termguicolors"))
 set termguicolors
endif
syntax enable
colorscheme shades_of_purple

let g:copilot_assume_mapped = v:true
" imap <silent><script><expr> <C-Tab> copilot#Accept('\<CR>')
imap <silent><script><expr> <C-Space> copilot#Accept('\<CR>')
" autocmd VimEnter * NERDTree | wincmd p
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" nnoremap <C-i> :NERDTreeToggle<CR>
" nnoremap <C-i> :NERDTreeToggle<CR>
" let g:dashboard_default_executive ='clap'

let g:WebDevIconsNerdTreeBeforeGlyphPadding = ""
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
if !has('gui_running')
  set t_Co=256
endif

set background=dark
set backspace=indent,eol,start
let g:shades_of_purple_airline = 1
let g:airline_theme='shades_of_purple'
" the other day I brough fou
let g:webdevicons_conceal_nerdtree_brackets = 1

set nu
" syntax enable
set hlsearch
" set mouse=a

" set tab length to 4 spaces
set tabstop=4
set shiftwidth=4
set expandtab
"
" Disable Arrow keys in Normal mode
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
" Disable Arrow keys in Insert mode
" imap <up> <nop>
" imap <down> <nop>
" imap <left> <nop>
" imap <right> <nop>
"This unsets the "last search pattern" register by hitting return
" nnoremap <CR> :noh<CR><CR>
let $FZF_DEFAULT_COMMAND='find . \( -name node_modules -o -name .git \) -prune -o -print'
" Press Enter to insert a blank line below current, Shift + Enter to insert it above.
map <Enter> o<ESC>
map <S-Enter> O<ESC>

inoremap <CapsLock> <Esc>

hi Normal guibg=NONE ctermbg=NONE
