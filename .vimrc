" vimrc
" In stone
set nocompatible
set nonumber
set norelativenumber
set showmode
set textwidth=72
set icon
set showmatch
set hidden
set background=dark
set mouse=
set ttyfast
let mapleader=","
filetype plugin on
syntax on

" disable RCE lol
set nomodeline

" ruler format
set ruler
set laststatus=0
set noshowcmd
set ruf=%30(%=%#LineNr#%.50F\ [%{strlen(&ft)?&ft:'none'}]\ %l:%c\ %p%%%)

" Tablature
set autoindent
set expandtab
set tabstop=8
set softtabstop=8
set shiftwidth=8
set smartindent
set smarttab
set wrapscan
set nowrap

" case
set ignorecase
set smartcase
set spc=

" editing options
set wildmenu
set autowrite
set foldmethod=manual
set nofoldenable
set nofixendofline
" better ascii friendly listchars
set listchars=space:*,trail:*,nbsp:*,extends:>,precedes:<,tab:\|>
" mark trailing spaces as errors
match IncSearch '\s\+$'
set nobackup
set noswapfile
set nowritebackup
set omnifunc=syntaxcomplete#Complete
set cinoptions+=:0

" highlight search hits
set hlsearch
set incsearch
set linebreak

" set persistent undo
if has('persistent_undo')
  set undofile
  set undodir=/tmp/undodir
endif

" avoid most of the 'Hit Enter ...' messages
set shortmess=aoOtTI

" prevents truncated yanks, deletes, etc.
set viminfo='20,<1000,s1000

" force some files to be specific file type
au bufnewfile,bufRead *.txt set spell
" start at last place you were editing
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" maps
map Y y$
nnoremap <C-L> :nohl<CR><C-L>
map <F1> :set number!<CR> :set relativenumber!<CR>
set pastetoggle=<F2>
map <F4> :set list!<CR>
map <F5> :set cursorline!<CR>
map <F6> :set spell!<CR>
" Better page down and page up
noremap <C-n> <C-d>
noremap <C-p> <C-b>

set fo+=cqjlMm1
set fo-=trowan2vBb

" base default color changes (gruvbox dark friendly)
hi StatusLine ctermfg=black ctermbg=NONE
hi StatusLineNC ctermfg=black ctermbg=NONE
hi Normal ctermbg=NONE
hi Special ctermfg=cyan
hi LineNr ctermfg=black ctermbg=NONE
hi SpecialKey ctermfg=black ctermbg=NONE
hi ModeMsg ctermfg=black cterm=NONE ctermbg=NONE
hi MoreMsg ctermfg=black ctermbg=NONE
hi NonText ctermfg=black ctermbg=NONE
hi vimGlobal ctermfg=black ctermbg=NONE
hi ErrorMsg ctermbg=234 ctermfg=darkred cterm=NONE
hi Error ctermbg=234 ctermfg=darkred cterm=NONE
hi SpellBad ctermbg=234 ctermfg=darkred cterm=NONE
hi SpellRare ctermbg=234 ctermfg=darkred cterm=NONE
hi Search ctermbg=236 ctermfg=darkred
hi vimTodo ctermbg=236 ctermfg=darkred
hi Todo ctermbg=236 ctermfg=darkred
hi IncSearch ctermbg=236 cterm=NONE ctermfg=darkred
hi MatchParen ctermbg=236 ctermfg=darkred
hi SignColumn ctermbg=NONE

" color overrides
au FileType * hi StatusLine ctermfg=black ctermbg=NONE
au FileType * hi StatusLineNC ctermfg=black ctermbg=NONE
au FileType * hi Normal ctermbg=NONE
au FileType * hi Special ctermfg=cyan
au FileType * hi LineNr ctermfg=black ctermbg=NONE
au FileType * hi SpecialKey ctermfg=black ctermbg=NONE
au FileType * hi ModeMsg ctermfg=black cterm=NONE ctermbg=NONE
au FileType * hi MoreMsg ctermfg=black ctermbg=NONE
au FileType * hi NonText ctermfg=black ctermbg=NONE
au FileType * hi vimGlobal ctermfg=black ctermbg=NONE
au FileType * hi goComment ctermfg=black ctermbg=NONE
au FileType * hi ErrorMsg ctermbg=234 ctermfg=darkred cterm=NONE
au FileType * hi Error ctermbg=234 ctermfg=darkred cterm=NONE
au FileType * hi SpellBad ctermbg=234 ctermfg=darkred cterm=NONE
au FileType * hi SpellRare ctermbg=234 ctermfg=darkred cterm=NONE
au FileType * hi Search ctermbg=236 ctermfg=darkred
au FileType * hi vimTodo ctermbg=236 ctermfg=darkred
au FileType * hi Todo ctermbg=236 ctermfg=darkred
au FileType * hi IncSearch ctermbg=236 cterm=NONE ctermfg=darkred
au FileType * hi MatchParen ctermbg=236 ctermfg=darkred

" specific file configuration
au FileType markdown hi Title ctermfg=yellow ctermbg=NONE
au FileType markdown hi Operator ctermfg=yellow ctermbg=NONE
au FileType markdown,text set tw=0 wrap
au FileType python set sw=4
au FileType markdown,text noremap j gj
au FileType markdown,text noremap k gk
au FileType yaml hi yamlBlockMappingKey ctermfg=NONE
au FileType yaml set sw=2
au FileType bash,sh set sw=2
au FileType bash,sh set noet
au FileType c set sw=8
