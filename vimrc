set paste
set number
set splitbelow
set splitright
set hlsearch
set incsearch
set smartcase
set smartindent
set smarttab 
set ruler
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
set shiftwidth=4
set tags+=./tags;/
set autoindent
set cindent
inoremap { {<CR>}<up><end><CR>
imap <C-Return> <CR><CR><C-o>k<Tab>

call plug#begin('~/.vim/plugged')
Plug 'valloric/youcompleteme'
Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'kien/ctrlp.vim'
call plug#end()

set ts=4
