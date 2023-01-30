set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-ragtag'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-abolish'
Plugin 'vim-ruby/vim-ruby'
Plugin 'mattn/emmet-vim'

Plugin 'rbgrouleff/bclose.vim'
Plugin 'bling/vim-airline'
Plugin 'jiangmiao/auto-pairs'
Plugin 'Lokaltog/vim-easymotion'

Plugin 'SirVer/ultisnips'
Plugin 'janko-m/vim-test'

Plugin 'kchmck/vim-coffee-script'
Plugin 'pangloss/vim-javascript'
Plugin 'mustache/vim-mustache-handlebars'

Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tomtom/tcomment_vim'
Plugin 'machakann/vim-textobj-delimited'
Plugin 'rizzatti/dash.vim'
Plugin 'gorkunov/smartpairs.vim'
Plugin 'nikvdp/ejs-syntax'

" Test Run
Plugin 'terryma/vim-expand-region'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'mxw/vim-jsx'
Plugin 'kana/vim-textobj-user'
Plugin 'nelstrom/vim-textobj-rubyblock'
Plugin 'ervandew/supertab'
Plugin 'tpope/vim-vinegar'

" Colour Themes
Plugin 'NLKNguyen/papercolor-theme'
Plugin 'joshdick/onedark.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'gosukiwi/vim-atom-dark'
Plugin 'GertjanReynaert/cobalt2-vim-theme'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'https://github.com/gorodinskiy/vim-coloresque.git'

Plugin 'wincent/command-t'
Plugin 'Valloric/YouCompleteMe'

call vundle#end()            " required
filetype plugin indent on    " required

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set backspace=2 " Backspace when on insert
set ignorecase
set autoindent
set smartindent
set cindent
set wrapmargin=0
set incsearch " jumps to search word while typing

syntax on

set nu " Show line number

"======================================
"= Pathogen
"======================================

execute pathogen#infect()

"======================================
"= NERD-TREE
"======================================

map \q :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

