" docs  : https://github.com/tpope/vim-cucumber
Plug 'tpope/vim-cucumber'

" -- settings
augroup filetypedetect
  au! BufReadPre,BufReadPost,BufRead,BufNewFile *.feature setfiletype cucumber
augroup END
let b:cucumber_root = expand('%:p:h:s?.*[\/]\%(features\|stories\)\zs[\/].*??')
let b:cucumber_steps_glob = b:cucumber_root.'/**/*.steps.ts'

