" SPDX-License-Identifier: CC0-1.0
" Loading Plugins
" Trusted plugins go in /usr/share/nvim/plugged
" This requires sudo nvim -u .config/nvim/init.vim for plugin update
" but prevents clutter in $HOME and allows for multi-user shared plugins
" Change plugin directory if this behavior is not desirable for you
call plug#begin('/usr/share/nvim/plugged')
" for automatic commenting and uncommenting of large code chunks
Plug 'preservim/nerdcommenter'
" for better indent with tab align with spaces support
Plug 'Joao-O-Santos/smarttab.vim', {'for': ['c', 'r']}
" default colorscheme
Plug 'reedes/vim-colors-pencil'
" alternative but similiar colorscheme
Plug 'equt/paper.vim'
" for better line wrapping support in markdown
Plug 'reedes/vim-pencil', {'for': ['text', 'markdown', 'rmd', 'latex']}
" for better focus and 'Word-like' screen layout
Plug 'junegunn/goyo.vim', {'for': ['text', 'markdown', 'rmd', 'latex', 'mail']}
"Finish loading plugins
call plug#end()

" NERDCommenter configuration
let g:NERDCreateDefaultMappings = 1
let g:NERDSpaceDelims = 1

" Vim-pencil configuration
let g:pencil#textwidth = 72

" General aesthetics options
set number
set ruler
set wrapscan
set scrolloff=1
set showmatch
set clipboard=unnamed
set colorcolumn=72,80
" Highlighs non-visible characters (taken from github.com/cfy/dotfiles)
set list listchars=tab:>\ ,trail:-,eol:¬
" Colorscheme
set termguicolors
set background=light
colorscheme pencil

" Dangerous defaults because I hate clutter
set nobackup
set noswapfile

" 'C'-style centric defaults
set autoindent " Only because smarttabs is on!
set noexpandtab
set tabstop=8
set softtabstop=8
set shiftwidth=8
set textwidth=79

" For languages and file formats
syntax on
filetype on
filetype plugin on
filetype indent off

" Trying to ensure formatoptions acts the way it should
set formatoptions=tqn21j
set formatoptions-=croql

" Enable folding with the spacebar
set foldmethod=syntax
set foldlevel=99
nnoremap <space> za

" Enabling thesaurus completion
set thesaurus=/usr/share/thesaurus/mthesaur.txt
set complete+=s

" Custom keys for recurrent functions
map <F2> <Esc>:setlocal spell spelllang=pt_pt<CR>
map <F3> <Esc>:setlocal spell spelllang=en_us<CR>
map <F4> <Esc>:setlocal nospell<CR>
map <F5> <Esc>:Goyo <bar> :Pencil <CR>
map <F6> <Esc>:setlocal background=dark <CR>
map <F7> <Esc>:setlocal background=light <CR>

" Uncomment if using PEP8
"autocmd FileType python set expandtab tabstop=4 softtabstop=4  shiftwidth=4
"                          \ textwidth=79

"For C an C++ (uncomment if you don't default to 8char tabs and tw=79)
autocmd FileType c,cpp,mk set nowrap "tabstop=8 softtabstop=8 shiftwidth=8
                         "\ textwidth=79

"For R
autocmd FileType r set foldmethod=indent " syntax folds seems broken

"For git commits
autocmd FileType gitcommit set textwidth=72 spell spelllang=en_us

"For mail (comment out or change spelllang for your most used language)
autocmd FileType mail set textwidth=0 spell spelllang=pt_pt | :Goyo <CR>

"For markdown and latex
autocmd FileType markdown set textwidth=72 spell spelllang=en_us encoding=utf-8
                                \ foldmethod=expr foldexpr=MarkdownFold()

" For rmarkdown (TODO: get proper folding working for rmarkdown files)
autocmd FileType rmd set textwidth=72 spell spelllang=en_us encoding=utf-8

"For .csv
autocmd BufRead,BufNewFile *.csv set textwidth=0 colorcolumn=0

"For qualtrics survey files (they are just jsons)
autocmd BufRead,BufNewFile *.qsf set textwidth=0 colorcolumn=0
