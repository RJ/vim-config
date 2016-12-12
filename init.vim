let mapleader = ","

call plug#begin('~/.vim/plugged')

"
" Git gutter
"
Plug 'airblade/vim-gitgutter'

"
" Colour theme
"
Plug 'tomasr/molokai'

"
" Airline status bar
"
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'

"
" Fuzzy Finder
"
Plug 'ctrlpvim/ctrlp.vim'
map <leader>a :CtrlP<cr>
let g:ctrlp_dotfiles = 0
let g:ctrlp_custom_ignore = {
  \ 'file': '\v\.(beam|app|o|so|pyc)$',
  \ 'dir': '\v/\.(node_modules|DS_Store|_build|git|kitchen)$',
  \ }
" search by filename not full path by default. (<c-d> in prompt to toggle)
let g:ctrlp_by_filename = 1
" include current file in match entries, in case i forget what file i'm
" editing and try to select it only to be confused why it's not found.
let g:ctrlp_match_current_file = 1

"
" NERDTree
"
" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on':  'NERDTreeToggle' }
" shortcut
map <F2> :NERDTreeToggle<cr>
let NERDTreeIgnore=['^ebin$', '\.beam$', '\.dump$', '\.pyc', '\~$', '^\.', '^_rel', '^_build', '\.gz$', '\.tar$', '\.bz2$', '\.zip$']
" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Can I have different highlighting for different file extensions?
" See here: https://github.com/scrooloose/nerdtree/issues/433#issuecomment-92590696

"
" Erlang (loaded ondemand)
"
Plug 'vim-erlang/vim-erlang-runtime',      {'for': 'erlang'}
Plug 'vim-erlang/vim-erlang-compiler',     {'for': 'erlang'}
Plug 'vim-erlang/vim-erlang-omnicomplete', {'for': 'erlang'}
Plug 'vim-erlang/vim-erlang-tags',         {'for': 'erlang'}

"
" Syntax Highlighting
"
Plug 'vim-syntastic/syntastic'
" Python stuff
let python_highlight_all=1
let g:syntastic_python_flake8_args='--max-complexity=10 --max-line-length=110 --ignore=W191'
let g:syntastic_python_checkers=['flake8']
let g:syntastic_check_on_open=1
"let g:syntastic_enable_signs=0
" eslint best for es6 js
let g:syntastic_javascript_checkers = ['eslint']

"
" Jump between notable markers etc
"
Plug 'tpope/vim-unimpaired'

"
" Easy Align
"
Plug 'junegunn/vim-easy-align'
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"
" /end Plug stuff
"
call plug#end()


" ,vimrc to open, and auto-source on save
map <leader>vimrc :tabe $MYVIMRC<cr>
autocmd bufwritepost .vimrc source $MYVIMRC

" delete line, yanking to blackhole register instead of clipboard
map xd "_dd

" keep blocks selected when indenting
vnoremap < <gv
vnoremap > >gv

set relativenumber
set number

" ,<space> clears search result highlights etc
map <leader><space> :let @/=''<cr>

" add beams etc to useless file list
set wildignore+=*.beam,*.dump,*~,*.o,.git,*.png,*.jpg,*.gif,_rel*

" triple escape closes buffer
map <esc><esc><esc> :bd<cr>
imap <esc><esc><esc> :bd<cr>

" fuck you, help key.
inoremap <F1> <ESC>:set invfullscreen<CR>a
nnoremap <F1> :set invfullscreen<CR>
vnoremap <F1> :set invfullscreen<CR>

" easier buffer navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" use the same symbols as TextMate for tabstops and EOLs
set list
set listchars=tab:▸\ ,eol:¬

" prettiness
set background=dark
colorscheme molokai
set colorcolumn=80

if has('gui_running')
    set guifont=Menlo:h14
    set go-=T
    set go-=l
    set go-=L
    set go-=r
    set go-=R
    if has("gui_macvim")
        " Full screen on macvim should fully maxed out
        set fuopt=maxvert,maxhorz
    else
        set guifont=DejaVu\ Sans\ Mono\ 13
    end
endif

