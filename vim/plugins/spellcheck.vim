" Spell check
map <F7> :setlocal spell spelllang=en_us<CR>
map <F6> :setlocal nospell<CR>

let g:sp_langs = [ "nospell", "en_us" ]
if !exists( "b:sp_lang" )
  if &spell
    let b:sp_lang=index(g:sp_langs, &spelllang)
  else
    let b:sp_lang = 0
  endif
endif
function! ToggleSpellCheck()
  let b:sp_lang = b:sp_lang + 1
  if b:sp_lang >= 1 | let b:sp_lang = 0 | endif
  if b:sp_lang == 0 | setlocal nospell | endif
  if b:sp_lang == 1 | setlocal spell spelllang=en_us | endif
  echo "spell language:" g:sp_langs[b:sp_lang]
endf
map <F7> :call ToggleSpellCheck()<CR>
