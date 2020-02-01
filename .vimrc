" Load up pathogen.vim for managing plugins
execute pathogen#infect()

filetype plugin indent on " Enable filetype plugins for lang-specific scripts
syntax on                 " Enable syntax highlighting

set nocompatible   " Disable vi compatability
set expandtab      " Spaces to tabs
set tabstop=2      " Number of spaces per tab
set shiftwidth=2   " Number of spaces for indentation
set number         " Enable line numbers
set ruler          " Show row and column at bottom right
set incsearch      " Incremental searches
set ignorecase     " Ignore cases in searches
set smartcase      " Case sensitive only if pattern includes uppercase letter
set autoindent     " Auto-indent new lines
set smartindent    " Auto-indent at beginning of lines
set smarttab       " Get backspaces to work with tab-spaces
set backspace=indent,eol,start
set mouse=a           " Enable mouse mode by default
set foldmethod=indent " Define folds based on code indentation
set nofoldenable      " Don't fold by default
set foldlevel=1

" Make vim use old regex engine to fix lag
" https://github.com/xolox/vim-easytags/issues/88#issuecomment-69474765
set regexpengine=1

" Fix mouse after 233 columns
if has('mouse_sgr')
  set ttymouse=sgr
endif

" Map leader to ,
let mapleader = ","
let g:mapleader = ","

" Leader key timeout
set tm=2000

" Allow the normal use of , by pressing it twice
noremap ,, ,

" Disable bells
set visualbell
set t_vb=

" Disable line wrap by default
set nowrap

" Kill the damned Ex mode.
nnoremap Q <nop>

" Map Leader-f to enable folds, Leader-nf to disable
nnoremap <Leader>f :set foldenable<CR>
nnoremap <Leader>nf :set nofoldenable<CR>

" Strip trailing whitespace on save
function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" Dark grey line numbers
highlight LineNr ctermfg=darkgrey ctermbg=NONE

set wildignore+=*tmp/*,*gradle/*,*.pyc*,*.a*,*.hi*,*.o*,*target/*,*build/*,*artifacts/*,*lein/*

" Typo fixes
map :W <Esc>:w
map :X <Esc>:x
map K <Esc>k

" jk in insert mode as shortcut for Escape
inoremap jk <Esc>

" :nw as a shortcut for disabling line wrap
map :nw <Esc>:set nowrap<CR>

" Show the status line at the bottom
:set laststatus=2

" ctrl-l - next tab
" ctrl-h - previous tab
map <C-l> :tabn<CR>
map <C-h> :tabp<CR>

" coloc/nocoloc to toggle color column
map :coloc :set colorcolumn=80<CR>
map :nocoloc :set colorcolumn=<CR>

" mks to save session file
map :mks :mksession! s.vim<CR>

" pa/nopa to toggle paste
map :pa :set paste<CR>
map :nopa :set nopaste<CR>

" :t as an abbreviation for :tabnew
ca t tabnew

" Open symbol in a new tab with ctrl-\
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

" :tb as a shortcut for :tab ball (Opens all buffers in tabs)
map :tb :tab ball<CR>

" :bo as a shortcut cfor closing all buffers but this one
map :bo <Esc>:BufOnly<CR>

" Shift-Tab to de-indent current line (insert mode)
imap <S-Tab> <C-o><<

" d2s to convert double quotes to single quotes on current line
map :d2s :s/"/'/g<CR>

" s2d to convert single quotes to double quotes on current line
map :s2d :s/'/"/g<CR>

" :mouseon and :mouseoff and enabling mouse support
map :mouseon :set mouse=a<CR>
map :mouseoff :set mouse=<CR>

" Open new split panes to right and bottom
set splitbelow
set splitright

" Enable indentation with tab and shift-tab in visual mode
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

"
" Plugin configuation
"

" CtrlP
let g:ctrlp_map = '<c-p>'         " Start with ctrl-p
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 0 " Use CtrlP within current directory
let g:ctrlp_max_height = 30       " Show more results
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" NERDTree
let NERDTreeShowHidden=1        " Show dotfiles
let NERDTreeIgnore=['\.swp$']
map :nt <Esc>:NERDTree<CR>      " :nt to open
map :nf <Esc>:NERDTreeFind<CR>  " :nf to jump to current file
map :nc <Esc>:NERDTreeClose<CR> " :nc to close

" Ack
" :ack as an alias for :Ack! -Q
" (Avoids opening first match in buffer, and escapes literal strings)
cnoreabbrev ack Ack! -Q
cnoreabbrev Ack Ack! -Q

" nerdcommenter
map :cc <Leader>cb " :cc to comment
map :cu <Leader>cu " :cu to uncomment

" vim-rspec
nnoremap <Leader>s :call RunNearestSpec()<CR>
nnoremap <Leader>t :call RunCurrentSpecFile()<CR>
nnoremap <Leader>l :call RunLastSpec()<CR>"

" vim-indent-guides
" ig/noig to toggle indent guides
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
map :ig :IndentGuidesEnable<CR>
map :noig :IndentGuidesDisable<CR>
