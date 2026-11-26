" Portable Vim configuration (Vim 9.0+)
" Arch Linux / Debian 12 / macOS MacVim
" Install as ~/.vimrc
scriptencoding utf-8
set nocompatible

" 1. UTF-8 and file-type support
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,gb18030,latin1
filetype plugin indent on
syntax enable

" 2. Dark theme (built-in, no plugins)
set background=dark
if has('termguicolors') && (has('gui_running') || $COLORTERM =~? 'truecolor\|24bit')
  set termguicolors
endif
if !empty(globpath(&runtimepath, 'colors/habamax.vim'))
  colorscheme habamax
else
  colorscheme desert
endif

" 3. Display and navigation
set number
set numberwidth=4
set cursorline
set cursorcolumn
highlight CursorLine cterm=NONE gui=NONE ctermbg=236 guibg=#303030
highlight CursorColumn cterm=NONE gui=NONE ctermbg=235 guibg=#262626
set scrolloff=5
set sidescrolloff=5
" Visual wrapping only: preserve the original file lines
set wrap
set linebreak
set breakindent
let &showbreak = '> '
set showmatch
set matchtime=2
set showcmd
set showmode

" 4. Informative status line
set laststatus=2
let &statusline = '%<%f %h%m%r'
      \ . '%='
      \ . '[%{toupper(empty(&fileencoding) ? &encoding : &fileencoding)}]'
      \ . ' [%{toupper(&fileformat)}]'
      \ . ' [%Y]'
      \ . ' Ln %l/%L Col %c'
      \ . ' %p%%'

" 5. Search and command-line completion
set incsearch
set hlsearch
set ignorecase
set smartcase
set wildmenu
set wildmode=longest:full,full
set history=1000

" 6. Editing and splits
set hidden
set confirm
set autoread
set backspace=indent,eol,start
set autoindent
" Disable automatic hard wrapping by default (filetype plugins may override)
set textwidth=0
set wrapmargin=0
set formatoptions-=t
set expandtab
set tabstop=8
set shiftwidth=4
set softtabstop=-1
set splitbelow
set splitright

" 7. Disable swap, retain safe writes, and keep undo in one directory
set noswapfile
set nobackup
set writebackup
if has('persistent_undo')
  let s:undo_dir = expand('~/.vim/undo')
  if !isdirectory(s:undo_dir)
    call mkdir(s:undo_dir, 'p', 0700)
  endif
  if isdirectory(s:undo_dir)
    let &undodir = s:undo_dir
    set undofile
  endif
endif

" 8. Security and whitespace inspection
set nomodeline
set listchars=tab:>-,trail:.,nbsp:+
" Work around emoji-width issues in WSL terminals without changing MacVim
if exists('+emoji') && exists('$WSL_DISTRO_NAME')
  set noemoji
endif

" 9. Filetype-specific indentation and wrapping
augroup PortableVimFiletypes
  autocmd!
  autocmd FileType make,go setlocal noexpandtab tabstop=8 shiftwidth=8 softtabstop=0
  autocmd FileType json,yaml,css,html,javascript,typescript setlocal expandtab shiftwidth=2 softtabstop=2
  autocmd FileType markdown,text,gitcommit setlocal wrap linebreak breakindent
augroup END

" 10. Optional toggles: backslash is the default <Leader>
nnoremap <silent> <Leader>c :setlocal cursorcolumn!<CR>
nnoremap <silent> <Leader>r :setlocal relativenumber!<CR>
nnoremap <silent> <Leader>l :setlocal list!<CR>
nnoremap <silent> <Leader>h :nohlsearch<CR>
nnoremap <silent> <Leader>w :setlocal wrap!<CR>
