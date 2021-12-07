" docs : https://github.com/neoclide/coc.nvim
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" -- settings
let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ ]
  " \ 'coc-eslint'
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gr <Plug>(coc-references)
nnoremap <C-p> :GFiles<CR>

