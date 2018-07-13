let $vim_home=expand('~/.vimfiles')

syntax on

set softtabstop=4
set tabstop=4
set shiftwidth=4
set expandtab

set number
set cursorline

set foldmethod=manual

filetype plugin indent on

vnoremap < <gv
vnoremap > >gv

call plug#begin("~/.vimfiles/installed_plugins")
"" directory navigator
Plug 'scrooloose/nerdtree'
"" file search
Plug 'ctrlpvim/ctrlp.vim'
"" content search
Plug 'mileszs/ack.vim'
"" coffee script syntax
Plug 'kchmck/vim-coffee-script'
"" color scheme
Plug 'nanotech/jellybeans.vim'
"" elixir syntax
Plug 'elixir-lang/vim-elixir'
"" typescript syntax
Plug 'leafgarland/typescript-vim'
"" ejs syntax
Plug 'briancollins/vim-jst'
"" execute code inline
Plug 'hlissner/vim-forrestgump'
"" execute rspec inline
Plug 'skwp/vim-rspec'
"" vue.js
Plug 'posva/vim-vue'
"" Git wrapper
Plug 'tpope/vim-fugitive'
"" autocomplete
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
call plug#end()

"" generic config
nmap <leader>qa :qa!<CR>
nmap <leader>w :w<CR>

"" ctrlp config
let g:ctrlp_show_hidden=1
let g:ctrlp_max_height=35
if executable('ag')
" Use Ag over Grep
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

"" autocomplete config
let g:deoplete#enable_at_startup = 1
let g:deoplete#num_processes = 1
let g:python_host_prog=$vim_home."/venv2/bin/python"
let g:python3_host_prog=$vim_home."/venv3/bin/python"

"" ack config
if executable('ag')
    let g:ackprg = 'ag --nogroup --nocolor --column'
endif

"" nerdtree config
nmap <leader>f :NERDTreeToggle<CR>
let g:NERDTreeWinPos="left"

"" fugitive config
nmap <leader>gb :Gblame<CR>
nmap <leader>gdm :Gdiff master<CR>
nmap <leader>gd :Gdiff

"" CtrlP config
nmap <leader>c :CtrlPClearAllCache<CR>
nmap <leader>ce :CtrlPClearAllCache<CR>:edit!<CR>

"" rspec config
nmap <leader>t :RunSpec<CR>

"" color scheme
colorscheme jellybeans
hi TODO ctermbg=9 ctermfg=0

"" set syntax highlight of thor
au BufRead *.thor :set syntax=ruby

"" set syntax highlight for vue
autocmd FileType vue syntax sync fromstart
autocmd BufRead,BufNewFile *.vue setlocal filetype=vue
