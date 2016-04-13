" General {{{
set nocompatible " Vi IMproved other than Vi (set nocp)
let g:is_posix=1 " vim's default is bourne shell, bring it up to the 90s
scriptencoding utf-8
set encoding=utf-8

set colorcolumn=80 " 80 characters line for coding

" :set nu/nonu ==> set/unset line numbers
"set {option}& ==> restore the option to the default value
"set hlsearch? ==> check the value of the option hlsearch
"set ignorecase

set smartcase " be case sensitive when input has a capital letter
set incsearch

set pastetoggle=<F10> " :set paste/nopaste for safer pasting

let mapleader="," " define prefix for key bindings

" hex editing
" vim -b xxx.bin --> :%!xxd --> :%!xxd -r --> :w
" vimdiff <(xxd bin_file_1) <(xxd bin_file_2)
"
" When you are creating a new binary file, you most probably want to set some
" flags before saving:
" :set noeol
" :set binary
"
" Otherwise vim will append a newline (0x0a) at the end of the file.
" This is only an issue when creating a new binary file. When you open an
" existing binary file vim automatically sets these flags for you.

" :help dib
" :norm Vg? ==> ROT13 encryption of current line
" A ==> append at end of line
" }}}

" Formatting {{{
set tabstop=4 " ts: size of a hard tab
set shiftwidth=4 " sw: size of a indent
set softtabstop=4 " sts: size of columns when hit Tab in insert mode
set noexpandtab " just use tab other than space

set autoindent
set cindent " strict rules for C programs

set backspace=indent,eol,start
" }}}

" Key mappings {{{
nmap <leader>rs :source ~/.vimrc<CR> " $MYVIMRC
" map <leader>EE :Vexplore!<CR><C-W>s

"map <silent><leader>w :w<cr>
"map <silent><leader>qa :qa<cr>
"map <silent><leader>qq :q!<cr>
"map <silent><leader>wq :wq<cr>
"map <silent><leader>q :q<cr>

" }}}

" Vundle {{{
filetype off " required for Vundle
" Set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()
" https://github.com/VundleVim/Vundle.vim
Plugin 'VundleVim/Vundle.vim' " let Vundle manages Vundle

" Plugins on GitHub
"Plugin 'gmarik/ingretu' " colorscheme
"Plugin 'tpope/vim-vividchalk' " colorscheme

Plugin 'triplekiller/vim-linux-coding-style'
let g:linuxsty_patterns = [ "/.*linux-.*/" ]
" :LinuxCodingStyle ==> command to format

Plugin 'triplekiller/taglist.vim'
let Tlist_Ctags_Cmd = '/usr/bin/ctags'
let Tlist_File_Fold_Auto_CLose = 1
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_Left_Window = 1
map <silent><leader>tl :TlistToggle<cr>
nmap tl :TlistToogle<cr>

Plugin 'triplekiller/cscope_maps.vim'
" :cw --> enter into QuickFix when using cscope
" :vert scs find s <func_name> --> display results in a new window
" ARCH=arm make cscope/tags --> build cscope index when build Linux kernel

"Plugin 'tpope/vim-git'
"Plugin 'tpope/vim-fugitive' " git wrapper
"nnoremap <leader>W :Gwrite<CR>
"nnoremap <leader>C :Gcommit -v<CR>
"nnoremap <leader>S :Gstatus \| 7<CR>
"inoremap <leader>W <Esc><leader>W
"inoremap <leader>C <Esc><leader>C
"inoremap <leader>S <Esc><leader>S

"Plugin 'majutsushi/tagbar'
"let g:tagbar_autoclose=1
"let g:tagbar_show_linenumbers=-1
"map <F9> :TagbarToggle<CR>

"Plugin 'klen/python-mode'

"Plugin 'scrooloose/syntastic'
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 0
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"let g:syntastic_c_checkers = []

" Plugins from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
"Plugin 'FuzzyFinder'

" Plugin repos not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" Plugin repos on your local machine
"Plugin 'file:///home/san/path/to/plugin'

" All of the plugins must be added before the following line
call vundle#end()
filetype plugin indent on
" :help vundle
" }}}

" Cursor sniper {{{
set updatetime=2000

function! MySetCursor()
	set cursorline
	set cursorcolumn
endfunction

function! MyUnSetCursor()
	set nocursorline
	set nocursorcolumn
endfunction

au! CursorHold * call MyUnSetCursor()
au! CursorMoved * call MySetCursor()
au! CursorMovedI * call MyUnSetCursor()
" }}}

" color/font
" /usr/share/vim/vim74/colors
" :colo desert256 --> change color scheme in vim
set t_Co=256
"set background=dark
"colorscheme solarized
"colorscheme desert256
colorscheme desert

" Highlight trailing whitespaces {{{
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
" }}}
