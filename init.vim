let mapleader = ","
set encoding=utf8

call plug#begin('~/.vim/plugged')


"
" easy toggle comments
"
Plug 'scrooloose/nerdcommenter'
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

"
" Git gutter
"
Plug 'airblade/vim-gitgutter'

"
" Open buffers across the top
"
"Plug 'fholgado/minibufexpl'
Plug 'git@github.com:fholgado/minibufexpl.vim.git'
map <Leader>bt :MBEToggle<cr>
map <Leader>bn :MBEbn<cr>
map <Leader>bp :MBEbp<cr>
" 3gb -> go to buf 3
let c = 1
while c <= 99
  execute "nnoremap " . c . "gb :" . c . "b\<CR>"
  let c += 1
endwhile

"
" Colour theme
"
Plug 'tomasr/molokai'

"
" Airline status bar
"
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_powerline_fonts = 1
"let g:airline_left_sep = '»'
"let g:airline_left_sep = '▶'
"let g:airline_right_sep = '«'
"let g:airline_right_sep = '◀'

"
" Fuzzy Finder
"
Plug 'ctrlpvim/ctrlp.vim'
map <leader>a :CtrlP<cr>
map <c-p> :CtrlP<cr>
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
" Hide the [] around the git status indicator for nerdtree git plugin
"autocmd FileType nerdtree syntax match hideBracketsInNerdTree "\]" contained conceal containedin=ALL
"autocmd FileType nerdtree syntax match hideBracketsInNerdTree ".\[" contained conceal containedin=ALL

"
" Erlang (loaded ondemand)
"
Plug 'vim-erlang/vim-erlang-runtime',      {'for': 'erlang'}
Plug 'vim-erlang/vim-erlang-compiler',     {'for': 'erlang'}
Plug 'vim-erlang/vim-erlang-omnicomplete', {'for': 'erlang'}
Plug 'vim-erlang/vim-erlang-tags',         {'for': 'erlang'}

"
" Use tab for clever omni complete
"
Plug 'ervandew/supertab'
set completeopt=longest,menuone
" change the behavior of the <Enter> key when the popup menu is visible:
" the Enter key will simply select the highlighted menu item, just as <C-Y> does
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" the first will make <C-N> work the way it normally does; however, when the
" menu appears, the <Down> key will be simulated. What this accomplishes is it
" keeps a menu item always highlighted. This way you can keep typing characters
" to narrow the matches, and the nearest match will be selected so that you can
" hit Enter at any time to insert it. In the above mappings, the second one is
" a little more exotic: it simulates <C-X><C-O> to bring up the omni completion
" menu, then it simulates <C-N><C-P> to remove the longest common text, and
" finally it simulates <Down> again to keep a match highlighted.
inoremap <expr> <C-n> pumvisible() ? '<C-n>' : '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

inoremap <expr> <M-,> pumvisible() ? '<C-n>' : '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'


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
" Plug 'tpope/vim-unimpaired'

"
" Easy Align
"
Plug 'junegunn/vim-easy-align'
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"
" Use patched fonts with extra glyphs in various plugins
"
Plug 'ryanoasis/vim-devicons'

"
" /end Plug stuff
"
call plug#end()

set tabstop=4
set expandtab
set shiftwidth=0 " default to tabstop amount

set cursorline

au FileType yaml setl tabstop=2 expandtab


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

" They see me scrolling..
map <C-j> j<C-e>
map <C-k> k<C-y>
map <C-h> 10<C-e>10j
map <C-l> 10<C-y>10k

" use the same symbols as TextMate for tabstops and EOLs
set list
set listchars=tab:▸\ ,eol:¬

" prettiness
set background=dark
colorscheme molokai
set colorcolumn=80

if has("gui_macvim")
	" Full screen on macvim should fully maxed out
	set guifont=Inconsolata\ For\ Powerline\ Nerd\ Font\ Complete:h16
	set fuopt=maxvert,maxhorz
end

if has('gui_running')
    set go-=T
    set go-=l
    set go-=L
    set go-=r
    set go-=R
endif

