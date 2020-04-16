" vim: foldmethod=marker
" Options --------------------------------------------------{{{1
" Font used is Ubuntu Mono Plus Nerd File Types Mono Plus Octicons
" It has correct triangles and font spacing. Icons is just bonus
" https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/UbuntuMono
set noswapfile
set nobackup
set nocompatible			  " be iMproved, required
set showcmd
syntax on
colorscheme pickrelated
set nofixendofline

set undodir=~/.vim/undo-dir
set undofile

set mouse=a

set wildignore+=.git,.idea,*.DS_Store,*.o
set wildignore+=*.swp
set wildignore+=bower_components,node_modules,dist,build
set wildignore+=public/js,public/css
set wildignore+=tmp

set timeout ttimeoutlen=10 timeoutlen=300

set fileencodings=utf8,cp1251

" Fix for ubuntu
scriptencoding utf-8
set encoding=utf-8

" Spell check
set spelllang=ru,en

" Make - part of word
set iskeyword+=-
set iskeyword+=$

" Switch to russian letters in insert mode but stay in ENG in other modes (Ctrl+^)
" set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
highlight lCursor guifg=NONE guibg=Cyan

set nowrap

set number " show line numbers
set numberwidth=3

set so=7 " Lines from top and bottom when scrolling

set wildmenu

" Show tabs as ➝
set list
set listchars=tab:·\ ,extends:,precedes:

" Open splits on the right side
set splitright

" Resize splits when window is resized
au VimResized * exe "normal! \<c-w>="

" Include dirs for syntastic
let g:syntastic_cpp_include_dirs=['src/', 'lib/']
let g:syntastic_c_config_file='.syntastic_c_config'
let g:syntastic_cpp_config_file='.syntastic_cpp_config'
" let g:syntastic_javasctipt_config_file='.eslintrc.json'
" STM32 gcc StdPeriph Library problem
let g:syntastic_cpp_gcc_quiet_messages = { "regex": 'Please select first' }

set foldmethod=marker
if has("folding")
  set foldtext=MyFoldText()
  function! MyFoldText()
    let prefix = ''

    let i = v:foldlevel - 1
    while i>0
      let prefix .= '--------'
      let i -= 1
    endwhile

    let prefix .= ' [ '
    let foldcaption = substitute(foldtext(), '.*: \(.*\) -*', '\1', '')
    let cnt = (v:foldend-v:foldstart+1)
    let postfix = ' ]'

    let text = prefix . foldcaption . '  (' . cnt . ')' . postfix
    return text
  endfun
endif

" Filetypes ------------------------------------------------{{{1
au BufRead,BufNewFile *.jade       set ft=jade
au BufRead,BufNewFile *.js         set ft=javascript    syntax=javascript
au BufRead,BufNewFile *.tmc        set ft=c             syntax=c
au BufRead,BufNewFile *.ttm        set ft=c             syntax=c
au BufRead,BufNewFile *.mjml       set ft=html          syntax=html
au BufRead,BufNewFile *.handlebars set ft=html          syntax=html

au BufRead,BufNewFile *.jst.ejs  set ft=html          syntax=html
au BufRead,BufNewFile *.rabl     set ft=ruby          syntax=ruby

au BufRead,BufNewFile *.lock     setlocal noeol binary


au BufRead,BufNewFile *.styl     set ft=css syntax=css

au BufRead,BufNewFile *.cpp     setlocal path=.,inc
au BufRead,BufNewFile *.hpp     setlocal path=.,inc

" Drupal ---------------------------------------------------{{{2
au BufRead,BufNewFile *.install  set ft=php           syntax=php
au BufRead,BufNewFile *.info     set ft=php           syntax=php
au BufRead,BufNewFile *.module   set ft=php           syntax=php

" PhpMyDirectory -------------------------------------------{{{2
au BufRead,BufNewFile *.tpl      set ft=php           syntax=php

" Spelling -----------------------------------------------------{{{1
au FileType gitcommit setlocal spell
au FileType jade setlocal spell

" Indents ---------------------------------------------------{{{1
set autoindent
set smartindent

set et ci pi sts=2 sw=2 ts=2

" Search ---------------------------------------------------{{{1
set hlsearch " highlight search and * and #
set incsearch " show search match while typing
set ignorecase " ignore case when searching
set smartcase " do not ignore case when capital letters present

" Faster search/replace
nmap S :%s/\V
vmap s :s/\V
nmap / :/\V
vmap / :/\V

" Navigation/buffer ----------------------------------------{{{1
nmap <leader>ww :w<CR>
nmap <leader>q :q<CR>
nmap <leader>Q :qa<CR>

" Windows
nmap <C-l> <C-w>l
nmap <C-h> <C-w>h
nmap <C-k> <C-w>k
nmap <C-j> <C-w>j

" Page up and page down
map J <C-f>zz
map K <C-b>zz

" Beginning of line and end of line
nmap L $
vmap L $
nmap H ^
vmap H ^

" Ruby on Rails navigation (vim-rails)
let g:vimrubocop_keymap = 0
nmap <leader>rmm :Emodel<space>
nmap <leader>rcc :Econtroller<space>
nmap <leader>rvv :Eview<space>
nmap <leader>rhh :Ehelper<space>
nmap <leader>ree :Eenvironment<space>
nmap <leader>rff :Efunctionaltest<space>
nmap <leader>rii :Einitializer<space>
nmap <leader>rjj :Ejavascript<space>
nmap <leader>rss :Eserializer<space>
nmap <leader>ruu :Eunittest<space>
nmap <leader>rll :Elayout<space>

nmap <leader>rm :Emodel<CR>
nmap <leader>rc :Econtroller<CR>
nmap <leader>rv :Eview<space>
nmap <leader>rh :Ehelper<CR>
nmap <leader>re :Eenvironment<CR>
nmap <leader>rf :Efunctionaltest<CR>
nmap <leader>ri :Einitializer<CR>
nmap <leader>rj :Ejavascript<CR>
nmap <leader>rs :Eserializer<CR>
nmap <leader>ru :Eunittest<CR>
nmap <leader>rl :Elayout<CR>
nmap <leader>rr :e config/routes.rb<CR>

nmap <leader>rti :Eintegrationtest<CR>
nmap <leader>rtf :Efixtures<CR>

nmap <leader>rg :e Gemfile<CR>
" Test current scope only
nmap <leader>rt :Espec<CR>
nmap <leader>rtt :Rake spec<CR>
nmap <leader>rb :RuboCop<CR>
nmap <leader>ra :RuboCop .<CR>

" Hotkeys --------------------------------------------------{{{1
nmap <leader>so :so ~/.vimrc<CR>
nmap <leader>pi :PluginInstall<CR>

nmap <Space> <leader>
vmap <Space> <leader>

" Change ; to : and ;; to ;
nmap ; :
vmap ; :

nmap <leader>t :!ctags -R .<CR><CR>
nmap <C-\> :Tagss<CR>
command! -bang Tagss
  \ call fzf#vim#tags('^' . expand('<cword>'), {
  \     'down': '40%',
  \     'options': '--with-nth 1,2
  \                 --reverse
  \                 --prompt "> "
  \                 --preview-window="50%"
  \                 --exact
  \                 --select-1
  \                 --exit-0
  \                 +i
  \                 --preview "
  \                     tail -n +\$(echo {3} | tr -d \";\\\"\") {2} |
  \                     head -n 16"'
  \ })
nmap <C-]> :BTagss<CR>
command! -bang BTagss
  \ call fzf#vim#buffer_tags('^' . expand('<cword>'), {
  \     'down': '40%',
  \     'options': '--with-nth 1,2
  \                 --reverse
  \                 --prompt "> "
  \                 --preview-window="50%"
  \                 --exact
  \                 --select-1
  \                 --exit-0
  \                 +i
  \                 --preview "
  \                     tail -n +\$(echo {3} | tr -d \";\\\"\") {2} |
  \                     head -n 16"'
  \ })

" Reset highlight
augroup no_highlight
nnoremap <esc> :noh<return><esc>
augroup END

nmap <leader>n :call NERDTreeToggleInCurDir()<CR>

" Copy to buffer
nmap Y "+yy
vmap Y "+y

nmap <leader>gs :G<CR>
nmap <leader>gd :Gvdiff<CR>
nmap <leader>gb :Gblame -w<CR>
nmap <leader>ge :Gedit<CR>
nmap <leader>gw :Gwrite<CR>
nmap <leader>gp :Gpush<CR>
nmap <leader>gg :GitGutterSignsToggle<CR>
nmap <leader>gl :BCommits<CR>
nmap <leader>gh :0Glog<CR>
nmap <leader>gc :GFiles?<CR>

nmap <leader>cv :!open % -a Google\ Chrome<CR><CR>

" Surround with console.log();
nmap <leader>cl :.s/\v[ \t]+\zs([^;]*);*/console.log\(\1\)\;/<CR>:noh<CR>

" Fold/unfold block
nmap zl za
nmap zh zc
" Fold all blocks
nmap zH zM
" Fold all blocks except for current one
nmap zL zR

" Diff current two windows
nmap <leader>d :windo diffthis<CR>
nmap <leader>D :diffoff!<CR>
nmap <leader>du :diffupdate<CR>

nmap <leader>A :Ack <cword>
nmap <leader>a :Ag<CR>

" Quickfix list
nmap ]q :cnext<CR>
nmap [q :cprev<CR>
nmap ]Q :clast<CR>
nmap [Q :cfirst<CR>

" Location list
nmap ]w :lnext<CR>
nmap [w :lprev<CR>
nmap ]W :llast<CR>
nmap [W :lfirst<CR>

" Edit settigs files
nmap <leader>sv :e ~/.vimrc<CR>
nmap <leader>st :e ~/.tmux.conf<CR>
nmap <leader>sb :e ~/.bashrc<CR>
nmap <leader>sz :e ~/.zshrc<CR>
nmap <leader>ss :e ~/.vim/after/snippets<CR>
nmap <leader>sc :e ~/.ctags<CR>
nmap <leader>sa :e ~/.agignore<CR>
nmap <leader>si :e ~/.i3/config<CR>
nmap <leader>sx :e ~/.Xresources<CR>

" C-w replacement
nmap <leader>w <C-w>

" Search selection
vmap * y/<C-R>"<CR>

" Paste from current register/buffer in insert mode
imap <C-v> <C-R>*

" Multiple cursors
nmap <leader>m :MultipleCursorsFind<space>

imap <C-j> <Plug>snipMateNextOrTrigger

" Quick surround
nmap ' ysiw'
nmap " ysiw"
nmap ` ysiw`
nmap ) ysiw)
nmap ( ysiw(
nmap ] ysiw]
nmap [ ysiw[
nmap } ysiw}
nmap { ysiw{

vmap ' S'
" vmap " S"
vmap ` S`
vmap ) S)
vmap ( S(
vmap ] S]
vmap [ S[
vmap } S}
vmap { S{

" Jump to adjacent files --------------------------------------------------{{{1

" General
nmap <leader>ip :e %:r.pug<CR>
nmap <leader>is :e %:r.sass<CR>
nmap <leader>it :e %:r.ts<CR>
nmap <leader>ih :e %:r.html<CR>

" C++
au BufRead,BufNewFile,BufEnter *.c nmap <leader>ih :e %:h/../inc/%:t:r.h<CR>
au BufRead,BufNewFile,BufEnter *.c nmap <leader>ic :e %:h/../src/%:t:r.c<CR>
au BufRead,BufNewFile,BufEnter *.c nmap <leader>gh :e %:h/../inc/%:t:r.h<CR>
au BufRead,BufNewFile,BufEnter *.h nmap <leader>gh :e %:h/../src/%:t:r.c<CR>
au BufRead,BufNewFile,BufEnter *.c nmap <leader>ii :e %:h/../inc/%:t:r.h<CR>
au BufRead,BufNewFile,BufEnter *.h nmap <leader>ii :e %:h/../src/%:t:r.c<CR>

au BufRead,BufNewFile,BufEnter *.cpp nmap <leader>ih :e %:h/../inc/%:t:r.hpp<CR>
au BufRead,BufNewFile,BufEnter *.cpp nmap <leader>ic :e %:h/../src/%:t:r.cpp<CR>
au BufRead,BufNewFile,BufEnter *.cpp nmap <leader>gh :e %:h/../inc/%:t:r.hpp<CR>
au BufRead,BufNewFile,BufEnter *.hpp nmap <leader>gh :e %:h/../src/%:t:r.cpp<CR>
au BufRead,BufNewFile,BufEnter *.cpp nmap <leader>ii :e %:h/../inc/%:t:r.hpp<CR>
au BufRead,BufNewFile,BufEnter *.hpp nmap <leader>ii :e %:h/../src/%:t:r.cpp<CR>


" Plugins --------------------------------------------------{{{1
filetype off " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tomtom/tcomment_vim'
:source $VIMRUNTIME/macros/matchit.vim
" Plugin 'godlygeek/tabular'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'lokaltog/vim-easymotion'
Plugin 'mileszs/ack.vim'
Plugin 'jiangmiao/auto-pairs'
" Plugin 'sjl/gundo.vim'
Plugin 'tpope/vim-surround'
Plugin 'airblade/vim-gitgutter'
Plugin 'danro/rename.vim'
Plugin 'gregsexton/gitv'
Plugin 'w0rp/ale'
Plugin 'jeetsukumaran/vim-buffergator'
Plugin 'AndrewRadev/sideways.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'stefandtw/quickfix-reflector.vim' " Make changes directly from quickfix list
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim'
Plugin 'terryma/vim-expand-region'
Plugin 'AndrewRadev/splitjoin.vim'
" Plugin 'rhysd/clever-f.vim'
Plugin 'prettier/vim-prettier'

" javascript
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
" Plugin 'moll/vim-node'

" HTML
Plugin 'mattn/emmet-vim'
au FileType html,css,scss,sass,php,htmldjango,stylus EmmetInstall

" Ruby
Plugin 'tpope/vim-rails'
" Plugin 'ngmy/vim-rubocop'

" Misc syntax
" Plugin 'avakhov/vim-yaml'
" Plugin 'digitaltoad/vim-jade'
" Plugin 'ap/vim-css-color'
" Plugin 'iloginow/vim-stylus'
" Plugin 'leafgarland/typescript-vim'

" Snipmate
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'

call vundle#end()			 " required
filetype plugin indent on	 " required

" Plugins settings -----------------------------------------{{{1
" Ag (fzf) ----------------{{{2
let g:fzf_history_dir = '~/.local/share/fzf-history'

let g:fzf_colors =
\ { 'fg':      ['fg', 'Comment'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Tag'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Directory'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'Normal'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Make Ag search only in file contents and not the file names
command! -bang -nargs=* Ag call fzf#vim#ag('', fzf#vim#with_preview({'options' : '--delimiter : --nth 4.. --color hl:3,hl+:226 --preview "highlight"'}, 'right:30%'), 0)

command! -bang -nargs=* Files call fzf#vim#files('', fzf#vim#with_preview({'options' : '--tiebreak "length,end" --preview "highlight"'}, 'right:30%'), 0)

nmap <leader>b :Buffers<CR>
nmap <leader>f :Files<CR>
nmap <leader>s :BLines<CR>

" Airline ----------------{{{2
set laststatus=2
let g:airline_powerline_fonts=1
let g:Powerline_symbols='fancy'
set guifont=Ubuntu_Mono_derivative_Powerline:h16
let g:airline_section_a=''
let g:airline_section_b=''
let g:airline_section_x=''
let g:airline_section_y=''
let g:airline_section_z=''
" let g:airline_section_x=airline#section#create([''])
" let g:airline_section_y=airline#section#create(['filetype'])
" let g:airline_section_z=airline#section#create(['ffenc'])

" ALE ---------------{{{2
let g:airline#extensions#ale#enabled = 1
let g:ale_c_parse_makefile = 1
let g:ale_cpp_gcc_options = '-std=c++11 -I./inc -I./lib/STM32F10x_StdPeriph_Driver/inc -include stdint.h -include stdio.h -include stm32f10x_rcc.h'
let g:ale_linters = {
  \ 'cpp': ['gcc'],
\ }
" let g:ale_set_loclist = 0
" let g:ale_set_quickfix = 1
nmap ]a :ALENext<CR>
nmap [a :ALEPrevious<CR>

" Buffergator ---------------{{{2
nmap gn :BuffergatorMruCycleNext<CR>

let g:buffergator_suppress_keymaps = 1
let g:buffergator_viewport_split_policy = 'B'

nmap gb :BuffergatorMruCyclePrev<CR>

" Gitgutter --------------{{{2
nmap <leader>gr :GitGutterRevertHunk<CR>
nmap <leader>hu :GitGutterUndoHunk<CR>
nmap <leader>hs :GitGutterStageHunk<CR>
nmap <leader>hp :GitGutterPreviewHunk<CR>
set updatetime=100

" Emmet -----------{{{2
let g:user_emmet_install_global=0
let g:user_emmet_expandabbr_key = '<C-e>'

" Easy motion ---------------------------{{{2
let g:EasyMotion_smartcase=1

nmap s <Plug>(easymotion-s)
nmap <Leader>h <Plug>(easymotion-b)
nmap <Leader>j <Plug>(easymotion-j)
nmap <Leader>k <Plug>(easymotion-k)
nmap <Leader>l <Plug>(easymotion-w)

vmap <Leader>h <Plug>(easymotion-b)
vmap <Leader>j <Plug>(easymotion-j)
vmap <Leader>k <Plug>(easymotion-k)
vmap <Leader>l <Plug>(easymotion-w)

" NERDTree -----------------------------{{{2
let NERDTreeIgnore = ['^lang$', '__pycache__', '^tags$', 'ctags', '.*\.iml', '\.idea', '^vendor$', '^node_modules$', '^bower_components$', '^dist$', 'pyc$', 'yarn-error.log', 'yarn.lock', 'tmp', 'log', 'coverage', 'bin', 'www', 'platforms']
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''
let g:NERDTreeAutoCenter = 1
let g:NERDTreeWinSize = 40

au FileType nerdtree nmap <buffer> l o
au FileType nerdtree nmap <buffer> h x

function! NERDTreeToggleInCurDir()
  " If NERDTree is open in the current buffer
  if (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
    exe ":NERDTreeClose"
  else
    if (expand("%:t") != '')
      exe ":NERDTreeFind"
    else
      exe ":NERDTreeToggle"
    endif
  endif
endfunction

" NERDTree Git Plugin -----------------------------{{{2
let g:NERDTreeIndicatorMapCustom = {
	\ "Modified"  : "",
	\ "Staged"    : "",
	\ "Untracked" : "",
	\ "Renamed"   : "",
	\ "Unmerged"  : "",
	\ "Deleted"   : "",
	\ "Dirty"     : "",
	\ "Clean"     : "✔︎",
	\ "Unknown"   : "?"
\ }

let g:NERDTreeIndicatorMapCustom = {
	\ "Modified"  : "~",
	\ "Staged"    : "V",
	\ "Untracked" : "+",
	\ "Renamed"   : "_",
	\ "Unmerged"  : "=",
	\ "Deleted"   : "X",
	\ "Dirty"     : "~",
	\ "Clean"     : "✔︎",
	\ "Unknown"   : "?"
\ }

" Markdown ------------------------------{{{2
au BufNewFile,BufReadPost *.md set filetype=markdown spell

" Powerline ------------------------------{{{2
" Powerline config (only when lightline plugin installed)
let g:lightline = {
\	'colortheme': 'wombat',
\	'active': {
\		'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ],
\		'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
\	},
\	'component': {
\		'readonly': '%{&readonly?"":""}',
\	},
\	'separator': { 'left': '', 'right': '' },
\	'subseparator': { 'left': '', 'right': '' }
\}
" To insert, press <C-v> then type 'u' then type HEX code
" 

" Sideways ------------------------------{{{2
" Adds support of dia, caa etc
omap aa <Plug>SidewaysArgumentTextobjA
xmap aa <Plug>SidewaysArgumentTextobjA
omap ia <Plug>SidewaysArgumentTextobjI
xmap ia <Plug>SidewaysArgumentTextobjI

nmap gh :SidewaysJumpLeft<CR>
nmap gl :SidewaysJumpRight<CR>

nmap gL <Plug>SidewaysRight
nmap gH <Plug>SidewaysLeft

" Syntastic ----------------------------{{{2
let g:syntastic_enable_signs=1

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"

" let g:syntastic_php_checkers=['php', 'phpcs', 'phpmd']
let g:syntastic_php_checkers=[]

let g:syntastic_scss_checkers = ['sass']
let g:syntastic_sass_checkers = ['sass']
let g:syntastic_haml_checkers = ['haml_lint']
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_ruby_checkers = []
let g:syntastic_eruby_checkers = []

nmap <leader>st :SyntasticCheck<CR>

" Do not shout if included file is absent
let g:syntastic_c_remove_include_errors = 1

" Angular
let g:syntastic_html_checkers=[]

" Useful commands ------------------------------------------------{{{1
nmap m <Plug>(expand_region_expand)
vmap m <Plug>(expand_region_expand)
vmap M <Plug>(expand_region_shrink)

" ga - show symbol hex code
au FileType php imap ;; $
au FileType php,javascript,typescript imap ;; <space>=><space>
au FileType c,cpp imap ;; ->

au FileType php imap ,, <space>-><space>
