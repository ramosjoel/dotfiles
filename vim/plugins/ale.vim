" docs : https://github.com/dense-analysis/ale

Plug 'dense-analysis/ale'

" -- settings
let b:ale_linters = ['eslint']
let g:ale_sign_error = '🤬'
let g:ale_sign_warning = '⚠️'

" Do not lint or fix minified files.
let g:ale_pattern_options = {
  \ '\.min\.js$': {'ale_linters': [], 'ale_fixers': []},
  \ '\.min\.css$': {'ale_linters': [], 'ale_fixers': []},
  \}
let g:ale_fixers = {
  \ 'javascript': ['prettier'],
  \ 'typescript': ['prettier'],
  \ 'markdown': ['prettier'],
  \ 'python': ['prettier'],
  \ 'json': ['prettier'],
  \ 'css': ['prettier'],
  \ 'yaml': ['prettier'],
  \}
let g:ale_fix_on_save = 1
