" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
" Avoid side effects when it was already reset.
if &compatible
  set nocompatible
endif

" When the +eval feature is missing, the set command above will be skipped.
" Use a trick to reset compatible only when the +eval feature is missing.
silent! while 0
  set nocompatible
silent! endwhile

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""                                                    DEFAULT (tweaked)                                           """"""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start

set history=1000   " keep 1000 lines of command line history
set ruler          " show the cursor position all the time
set showcmd        " display incomplete commands
set wildmenu       " display completion matches in a status line

set ttimeout        " time out for key codes
set ttimeoutlen=100 " wait up to 100ms after Esc for special key

" Show @@@ in the last line if it is truncated.
set display=truncate

" Show a few lines of context around the cursor.  Note that this makes the
" text scroll if you mouse-click near the start or end of the window.
"set scrolloff=5

" Do incremental searching when it's possible to timeout.
if has('reltime')
  set incsearch
endif

" Do not recognize octal numbers for Ctrl-A and Ctrl-X, most users find it
" confusing.
set nrformats-=octal

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries.
if has('win32')
  set guioptions-=t
endif

" Don't use Ex mode, use Q for formatting.
" Revert with ":unmap Q".
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
" Revert with ":iunmap <C-U>".
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine.  By enabling it you
" can position the cursor, Visually select and scroll with the mouse.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on when the terminal has colors or when using the
" GUI (which always has colors).
if &t_Co > 2 || has("gui_running")
  " Revert with ":syntax off".
  syntax on

  " I like highlighting strings inside C comments.
  " Revert with ":unlet c_comment_strings".
  let c_comment_strings=1
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  " Revert with ":filetype off".
  filetype plugin indent on

  " Put these in an autocmd group, so that you can revert them with:
  " ":augroup vimStartup | au! | augroup END"
  augroup vimStartup
    au!

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid, when inside an event handler
    " (happens when dropping a file on gvim) and for a commit message (it's
    " likely a different one than last time).
    autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ |   exe "normal! g`\""
      \ | endif

  augroup END

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
" Revert with: ":delcommand DiffOrig".
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If set (default), this may break plugins (but it's backward
  " compatible).
  set nolangremap
endif

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""                                                     CUSTOM                                                     """"""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let mapleader = " " 

" show tabs and trailing spaces
map <leader>t :set list!<CR>
set lcs=tab:»\ ,trail:▫

" swap 'jump to line' and 'jump to line and column'
noremap ' `
noremap ` '

" reselect lines that were just pasted
nnoremap <leader>p `[v`]

" reselect lines that were just pasted
nnoremap <leader>v gv

" logical up/down movement on wrapped lines
noremap j gj
noremap k gk

" (half) page up/page down and cursor to middle of screen
noremap <leader>j <C-D>M
noremap <leader>k <C-U>M
noremap <leader>J <C-F>M
noremap <leader>K <C-B>M

" beginning and end of line
noremap <leader>h ^
noremap <leader>l $

" search results to middle of screen
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" hard tabs, 3-space width
set shiftwidth=3
set tabstop=3

" Ignore case in search patterns.  
" For shorthand, use :set ic and :set noic
set ignorecase
 
" Override the 'ignorecase' option if the search pattern
" contains upper case characters.
set smartcase
 
" show line numbers
set number

" Show line numbers relative to current
set relativenumber

set backupdir=~/.vim/backups
set undodir=~/.vim/.undos

" set to auto-read when a file is changed from outside
set autoread

" map 'U' to redo ('U' is "undo line", ctrl-r is redo)
map <s-u> <C-r>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""                                                    PLUGINS                                                     """"""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif


"""""""""""" Nerd Tree """"""""""""
" https://github.com/scrooloose/nerdtree.git

" map NERD Tree toggle to 'Z' (I use :wq)
map <s-z> :NERDTreeToggle<CR>


"""""""""""" Solarized """"""""""""
" https://github.com/altercation/vim-colors-solarized.git

set t_Co=256		" tell vim that the terminal can handle 256 colors
syntax enable
set background=dark
colorscheme solarized


"""""""""""" tcomment """"""""""""
" https://github.com/tomtom/tcomment_vim.git

" insert comment at beginning of line ignoring tab level
let g:tcomment#options = {'col': 1}

" stop adding that extra space
autocmd VimEnter * call tcomment#type#Define('javascript', '//%s')
autocmd VimEnter * call tcomment#type#Define('elixir', '#%s')

" map comment toggle to 'Q'
map <s-q> gc


"""""""""""""" JSX """""""""""""
" https://github.com/mxw/vim-jsx.git


"""""""""""" Elixir """"""""""""
" https://github.com/elixir-editors/vim-elixir


""""""""""" Fugitive """""""""""
" https://github.com/tpope/vim-fugitive.git


""""""""""" Surround """""""""""
" https://tpope.io/vim/surround.git


""""""""""" Lightline """"""""""
" https://github.com/itchyny/lightline.vim

set laststatus=2

