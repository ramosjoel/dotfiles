" docs : https://github.com/vim-syntastic/syntastic
Plug 'vim-syntastic/syntastic'

" -- settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_typescript_checkers = ['eslint']
" let g:syntastic_javascript_checkers = ['eslint']
