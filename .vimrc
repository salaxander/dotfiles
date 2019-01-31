"*****************************************************************************
"" Vim-PLug
"*****************************************************************************
call plug#begin(expand('~/.vim/plugged'))

Plug 'scrooloose/nerdtree'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'itchyny/lightline.vim'

call plug#end()

"*****************************************************************************
"" Basic Setup
"*****************************************************************************"
"" Map leader to ,
let mapleader=','

"" Disable arrows
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

"" Map NERDTree
nnoremap <leader>nt :NERDTreeToggle<CR> 

"" Set configs
set number
set autoindent smartindent
set smarttab
set laststatus=2
set noshowmode
