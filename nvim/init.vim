" SPDX-License-Identifier: CC0-1.0
" Loading Plugins
" Notes: Trusted plugins go in /usr/share/nvim/plugged
"        to update you must run `sudo nvim -u .config/nvim/init.vim`
"        Plugins become available to all users + avoids cluttering $HOME
"        Change directory in line below if this is not desirable to you
call plug#begin('/usr/share/nvim/plugged')
" for centered writing
Plug 'junegunn/goyo.vim'
" for automatic commenting and uncommenting of large code chunks
Plug 'preservim/nerdcommenter', {'for': ['markdown', 'rmd', 'pandoc', 'c', 'r']}
" for better indent with tab and align with spaces support
Plug 'Thyrum/vim-stabs'
" for better folding in markdown and RMarkdown
Plug 'vim-pandoc/vim-pandoc', {'for': ['markdown', 'rmd', 'pandoc']}
Plug 'vim-pandoc/vim-pandoc-syntax', {'for': 'markdown'}
"Finish loading plugins
call plug#end()

" Goyo configuration
let g:goyo_linenr=1
let g:goyo_height='100%'

" NERDCommenter configuration
let g:NERDCreateDefaultMappings = 1
let g:NERDSpaceDelims = 1

" vim-pandoc configuration
" Configure file formats for vim-pandoc to handle
let g:pandoc#filetypes#handled = ["pandoc", "markdown"]
" Let `#` be `#` no need to conceal or replace the character
let g:pandoc#syntax#conceal#blacklist = ["atx"]
" Use hard wraping
let g:pandoc#formatting#mode = 'h'
" Disabled foldcolumn (i.e., the fold level appearing on the left)
" I did this because the value sometimes got stuck to the line number 
let g:pandoc#folding#fdc = 0


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
" Colorscheme (neovim 0.10 changed the default and is similar to pencil)
set termguicolors
set background=light

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
map <F5> <Esc>:Goyo<CR>
map <F6> <Esc>:setlocal background=dark <CR>
map <F7> <Esc>:setlocal background=light <CR>


" For languages and file formats
syntax on
filetype on
filetype plugin on
" Indent is off since we have the smarttab plugin
filetype indent off

" For C an C++ (uncomment if you don't default to 8char tabs and tw=79)
autocmd FileType c,cpp,mk set nowrap "tabstop=8 softtabstop=8 shiftwidth=8
                            "\ textwidth=79

" For R
autocmd FileType r set foldmethod=indent " syntax folds seems broken

" For Python (uncomment if using PEP8)
"autocmd FileType python set expandtab tabstop=4 softtabstop=4 shiftwidth=4
"                          \ textwidth=79

" For markdown and RMarkdown
autocmd FileType markdown,rmd,pandoc set textwidth=72 encoding=utf-8
                                       \ spell spelllang=en_us

" For git commits
autocmd FileType gitcommit set textwidth=72 spell spelllang=en_us

" For YAML (which unfortunately requires spaces for identation)
autocmd FileType yaml set expandtab tabstop=4 softtabstop=4  shiftwidth=4
                        \ textwidth=79

" For mail (comment out or change spelllang for your most used language)
autocmd FileType mail set textwidth=0 spell spelllang=pt_pt

" For .csv
autocmd BufRead,BufNewFile *.csv set textwidth=0 colorcolumn=0

" For qualtrics survey files (they are just jsons)
autocmd BufRead,BufNewFile *.qsf set textwidth=0 colorcolumn=0
