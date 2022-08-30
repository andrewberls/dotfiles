" Load up pathogen.vim for managing plugins
execute pathogen#infect()

filetype plugin indent on " Enable filetype plugins for lang-specific scripts
syntax on                 " Enable syntax highlighting

set nocompatible      " Disable vi compatability
set expandtab         " Spaces to tabs
set tabstop=2         " Number of spaces per tab
set shiftwidth=2      " Number of spaces for indentation
set number            " Enable line numbers
set ruler             " Show row and column at bottom right
set incsearch         " Incremental searches
set ignorecase        " Ignore cases in searches
set smartcase         " Case sensitive only if pattern includes uppercase letter
set autoindent        " Auto-indent new lines
set smartindent       " Auto-indent at beginning of lines
set smarttab          " Get backspaces to work with tab-spaces
set mouse=a           " Enable mouse mode by default
set foldmethod=indent " Define folds based on code indentation
set nofoldenable      " Don't fold by default
set foldlevel=1
set backspace=indent,eol,start

" Make vim use old regex engine to fix lag
" https://github.com/xolox/vim-easytags/issues/88#issuecomment-69474765
set regexpengine=1

" Fix mouse after 233 columns
if has('mouse_sgr')
  set ttymouse=sgr
endif

" Disable Ex mode
nnoremap Q <nop>

" Disable bells
set visualbell
set t_vb=

" Show the status line at the bottom
:set laststatus=2

" Open new split panes to right and bottom
set splitbelow
set splitright

" Map leader to ,
let mapleader = ","
let g:mapleader = ","

" Leader key timeout
set tm=2000

" Disable line wrap by default
" :nw as an additional shortcut for disabling line wrap
set nowrap
map :nw <Esc>:set nowrap<CR>

" Strip trailing whitespace on save
function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" Tabs
"   :t as an abbreviation for :tabnew
"   ctrl-l - next tab
"   ctrl-h - previous tab
"   :tb as a shortcut for :tab ball (Opens all buffers in tabs)
ca t tabnew
map <C-l> :tabn<CR>
map <C-h> :tabp<CR>
map :tb :tab ball<CR>

" Leader-f to enable folds, Leader-nf to disable
nnoremap <Leader>f :set foldenable<CR>
nnoremap <Leader>nf :set nofoldenable<CR>

" jk in insert mode as shortcut for Escape
inoremap jk <Esc>

" Typo fixes
map :W <Esc>:w
map :X <Esc>:x
map K <Esc>k

" coloc/nocoloc to toggle color column
map :coloc :set colorcolumn=80<CR>
map :nocoloc :set colorcolumn=<CR>

" mks to save session file
map :mks :mksession! s.vim<CR>

" pa/nopa to toggle paste
map :pa :set paste<CR>
map :nopa :set nopaste<CR>

" Tags
"   :ct to open tag in new tab
"   :cv to open tag in vertical split
"   :cg to jump into tag, or show listing if multiple
"   <C-t> to jump backwards in tag stack, <C-y> forwards
"   :cb an alias for backwards
map :ct :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map :cv :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
map :cg g<C-]>
map <C-y> :tag<CR>
map :cb <C-t>

" :bo as a shortcut cfor closing all buffers but this one
map :bo <Esc>:BufOnly<CR>

" Shift-Tab to de-indent current line (insert mode)
imap <S-Tab> <C-o><<

" Enable indentation with tab and shift-tab in visual mode
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" d2s to convert double quotes to single quotes on current line
" s2d to convert single quotes to double quotes on current line
map :d2s :s/"/'/g<CR>
map :s2d :s/'/"/g<CR>

" :mouseon and :mouseoff to toggle mouse support
map :mouseon :set mouse=a<CR>
map :mouseoff :set mouse=<CR>

" :sy and :su to yank into system clipboard
map :sy "+y
map :su "+y

"
" Plugin configuation
"

" CtrlP
let g:ctrlp_map = '<c-p>'         " Start with ctrl-p
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 0 " Use CtrlP within current directory
let g:ctrlp_max_height = 30       " Show more results
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
set wildignore+=*tmp/*,*gradle/*,*.pyc*,*.a*,*.hi*,*.o*,*target/*,*build/*,*artifacts/*,*lein/*

" NERDTree
"   :nt to open
"   :nf to jump to current file
"   :nc to close
let NERDTreeShowHidden=1        " Show dotfiles
let NERDTreeIgnore=['\.swp$']
map :nt <Esc>:NERDTree<CR>
map :nf <Esc>:NERDTreeFind<CR>
map :nc <Esc>:NERDTreeClose<CR>

" Ack
"   :ack as an alias for :Ack! -Q
"   (Avoids opening first match in buffer, and escapes literal strings)
cnoreabbrev ack Ack! -Q
cnoreabbrev Ack Ack! -Q

" NERDCommenter
"   :cc to comment, :cu to uncomment
map :cc <Leader>cb
map :cu <Leader>cu
let g:NERDSpaceDelims = 1 " Add spaces after comment delimiters by default

" vim-rspec
"   Leader-s to run nearest spec, Leader-t to run whole file
nnoremap <Leader>s :call RunNearestSpec()<CR>
nnoremap <Leader>t :call RunCurrentSpecFile()<CR>

" vim-indent-guides
"   :ig / :noig to toggle indent guides
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
map :ig :IndentGuidesEnable<CR>
map :noig :IndentGuidesDisable<CR>
