" __     ___           
" \ \   / (_)_ __ ___  
"  \ \ / /| | '_ ` _ \ 
"   \ V / | | | | | | |
"    \_/  |_|_| |_| |_|
"                    rc

" ----- PLUGINS -----
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'

" Automatically install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(data_dir . '/plugged')

source ~/.vim/plugins/airline.vim
source ~/.vim/plugins/ale.vim
source ~/.vim/plugins/coc.vim
source ~/.vim/plugins/commentary.vim
source ~/.vim/plugins/cucumber.vim
source ~/.vim/plugins/devicons.vim
source ~/.vim/plugins/easy-align.vim
source ~/.vim/plugins/fzf.vim
source ~/.vim/plugins/floaterm.vim
source ~/.vim/plugins/fugitive.vim
source ~/.vim/plugins/gitgutter.vim
source ~/.vim/plugins/javascript.vim
source ~/.vim/plugins/markdown.vim
source ~/.vim/plugins/nerdtree.vim
source ~/.vim/plugins/node-inspect.vim
source ~/.vim/plugins/orgmode.vim
source ~/.vim/plugins/snippets.vim
source ~/.vim/plugins/speeddating.vim
source ~/.vim/plugins/syntastic.vim
source ~/.vim/plugins/tabular.vim
source ~/.vim/plugins/typescript.vim
source ~/.vim/plugins/utl.vim
" custom
" source ~/.vim/plugins/spellcheck.vim

" -- Themes
" source ~/.vim/plugins/dracula.vim
" source ~/.vim/plugins/onehalf.vim
" source ~/.vim/plugins/gotham.vim
" source ~/.vim/plugins/nord.vim
" source ~/.vim/plugins/material.vim

" Initialize plugin system
call plug#end()
" doautocmd User PlugLoaded


" ----- Mappings -----
let mapleader = "\<space>"

nmap <leader>ve :edit ~/.vimrc<CR>
nmap <leader>vc :edit ~/.vim/coc-settings.json<CR>
nmap <leader>vr :source ~/.vimrc<CR>
nmap <leader>k :noh<CR>
vnoremap <leader>p "_dP  " Paste replace visual selection without copying it

map gf :tabnew  <cfile><cr>  " Allow gf to open non-existent files
map Y y$  " map Y to act like D and C, i.e., to yank until EOL, rather than act as yy, which is the default

" Reselect visual selection after indenting
vnoremap < <gv
vnoremap > >gv

" Easy insertion of trailing ; or , from insert mode
imap ;; <Esc>A;<Esc>
imap ,, <Esc>A,<Esc>


" ----- Language-specific Settings -----
autocmd FileType js setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType ts setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType py setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

set encoding=UTF-8
set hidden
set signcolumn=yes
set relativenumber
set number
set title
set noswapfile
set nowrap
set hlsearch
set splitbelow splitright  " set default position for split window
set updatetime=300  " reduce time for highlighting other references
set redrawtime=10000  " allow more time for loading syntax on large files
" Case-insensitive search, except when using capital letters
set ignorecase
set smartcase
set autoindent
" Indentation settings for using 4 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set shiftwidth=2
set softtabstop=2
set expandtab
set smarttab

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
if has('filetype')
  filetype indent plugin on
endif

" Enable syntax highlighting
if has('syntax')
  syntax on
endif

" Enable use of the mouse for all modes
if has('mouse')
  set mouse=a
endif

" -- Code Executors
"  Execute the current file based on filetype
augroup exe_code
  autocmd!

  " python
  autocmd FileType python nnoremap <buffer> <localleader>r
    \ :term python3 %<CR> :startinsert<CR>
  
  " javascript
  autocmd FileType javascript nnoremap <buffer> <localleader>r
    \ :sp<CR> :term nodejs %<CR> :startinsert<CR>

  " bash
  autocmd FileType bash,sh  nnoremap <buffer> <localleader>r
    \ :sp<CR> :term bash %<CR> :startinsert<CR>
augroup END
