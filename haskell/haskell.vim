" Haskell utilities and bindings

let $PATH = $PATH . ':' . expand('/Users/andrew/Library/Haskell/bin')

" Enable some tabular presets for Haskell
let g:haskell_tabular = 1

" Show types in completion suggestions
let g:necoghc_enable_detailed_browse = 1

" Show type of expression under cursor
nmap <silent> <leader>ht :GhcModType<CR>

" Insert type of expression under cursor
nmap <silent> <leader>hT :GhcModTypeInsert<CR>

" Hoogle the word under the cursor
nnoremap <silent> <leader>hh :Hoogle<CR>

" Hoogle and prompt for input
nnoremap <leader>hH :Hoogle

" Hoogle for detailed documentation for expression under cursor
nnoremap <silent> <leader>hi :HoogleInfo<CR>

" Hoogle, close the Hoogle window
nnoremap <silent> <leader>hz :HoogleClose<CR>
