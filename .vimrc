let $vim_home=expand('~/.vimfiles')

syntax on

set nocompatible
filetype off
let &runtimepath.=',~/.vim/bundle/neoterm'
filetype plugin on

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
" directory navigator
Plug 'scrooloose/nerdtree'
"" nerdtree git support
Plug 'Xuyuanp/nerdtree-git-plugin'
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
Plug 'janko-m/vim-test'
"" vue.js
Plug 'posva/vim-vue'
"" Git wrapper
Plug 'tpope/vim-fugitive'
"" neoterm
Plug 'kassio/neoterm'
"" autocomplete
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
"" bundler
Plug 'tpope/vim-bundler'
"" linter
Plug 'w0rp/ale'
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
nmap <leader>c :CtrlPClearAllCache<CR>
nmap <leader>ce :CtrlPClearAllCache<CR>:edit!<CR>
set wildignore+=*.swp " ignore swp files
set wildignore+=*.zip,*.jar,*.tar " ignore archive file types
set wildignore+=venv,venv3,__pycache__,*.pyc " ignore python virtual env and compiled
set wildignore+=node_modules " ignore npm
set wildignore+=*.class " ignore java classes
set wildignore+=tmp " ignore tmp folder
set wildignore+=vendor " ignore vendor folder
set wildignore+=public " ignore public assets folder
set wildignore+=log " ignorelog folder
" nmap :CtrlPClearCache
let g:ctrlp_switch_buffer=""

if executable('ag')
" Use Ag over Grep
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif
nnoremap <leader>p :CtrlP<CR>

"" autocomplete config
if has('nvim') != 0
    " :help deoplete-options
    let g:deoplete#enable_at_startup = 1
    call deoplete#custom#option('auto_complete_delay', 50)
    call deoplete#custom#option('max_list', 15)
	call deoplete#custom#option('smart_case', v:true)

    let g:python_host_prog=$vim_home."/venv2/bin/python"
    let g:python3_host_prog=$vim_home."/venv3/bin/python"
endif

let g:python_host_prog=$vim_home."/venv2/bin/python"
let g:python3_host_prog=$vim_home."/venv3/bin/python"

"" ack config
if executable('ag')
    let g:ackprg = 'ag --nogroup --nocolor --column'
endif

"" nerdtree config
nmap <leader>f :NERDTreeToggle<CR>
let g:NERDTreeWinPos="left"
let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

"" fugitive config
nmap <leader>gb :Gblame<CR>
nmap <leader>gdm :Gdiff master<CR>
nmap <leader>gd :Gdiff

"" rspec config
nmap <leader>t :RunSpec<CR>
nmap <leader>tf :TestFile -strategy=neovim<CR>

"" ctags config
nmap <leader>tgr :!ctags --exclude=node_modules --exclude=public --exclude=vendor -R . $(bundle list --paths) <CR>

"" misc config
nmap <leader>e :tabedit<CR>
nmap <leader>hs :split<CR>
nmap <leader>vs :vsplit<CR>
nmap <leader>pj :%!python -m json.tool<CR>

"" color scheme
colorscheme jellybeans
hi TODO ctermbg=9 ctermfg=0

"" set syntax highlight of thor
au BufRead *.thor :set syntax=ruby

"" set syntax highlight for vue
autocmd FileType vue syntax sync fromstart
autocmd BufRead,BufNewFile *.vue setlocal filetype=vue

"" set syntax highlight for env files
autocmd FileType sh syntax sync fromstart
autocmd BufRead,BufNewFile .env* setlocal filetype=sh
