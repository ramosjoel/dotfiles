" docs : https://github.com/tpope/vim-fugitive

Plug 'tpope/vim-fugitive'

" -- settings
nmap <leader>gj :diffget //3<CR> " grab from right side (merge branch)
nmap <leader>gf :diffget //2<CR> " grab from left side (target/destination branch)
nmap <leader>gs :G<CR>           " git status

