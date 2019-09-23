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

set timeout ttimeoutlen=10 timeoutlen=300

set fileencodings=utf8,cp1251

" Fix for ubuntu
scriptencoding utf-8
set encoding=utf-8

" Spell check
" set spell
set spelllang=ru,en

" Make - part of word
" set iskeyword+=-
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
" set listchars=tab:·\ ,extends:,precedes:
set listchars=tab:·\ ,extends:,precedes:

" Open splits on the right side
set splitright

" Make Alt accessible
" let c='a'
" while c <= 'z'
"   exec "set <A-".c.">=\e".c
"   exec "imap \e".c." <A-".c.">"
"   let c = nr2char(1+char2nr(c))
" endw

" Resize splits when window is resized
au VimResized * exe "normal! \<c-w>="

" Include dirs for syntastic
let g:syntastic_cpp_include_dirs=['src/', 'lib/']
let g:syntastic_c_config_file='.syntastic_c_config'
let g:syntastic_cpp_config_file='.syntastic_cpp_config'
let g:syntastic_javasctip_config_file='.eslint.config.js'
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

" Tabularize ------{{{2
" Autotab (regex after / required)
" if exists(":Tabularize")
	vmap <leader>t :Tabularize/ /l0l0l0l0<CR>

	nmap <leader>t= :Tabularize/=<CR>
	vmap <leader>t= :Tabularize/=<CR>
	nmap <leader>t: :Tabularize/:\zs<CR>
	vmap <leader>t: :Tabularize/:\zs<CR>
	nmap <leader>t, :Tabularize/,\zs<CR>
	vmap <leader>t, :Tabularize/,\zs<CR>
" endif

inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction
"---}}}

set et ci pi sts=2 sw=2 ts=2

" au FileType php setlocal noeol binary
au BufRead,BufNewFile,BufEnter /Users/pin/rep/passport/* setlocal ts=4 sts=4 sw=4
au BufRead,BufNewFile,BufEnter /Users/pin/rep/passport/newlanding/* setlocal ts=2 sts=2 sw=2
au BufRead,BufNewFile,BufEnter /Users/pin/rep/passport/dashboard/* setlocal ts=2 sts=2 sw=2
au BufRead,BufNewFile,BufEnter /Users/pin/rep/passport/svg/* setlocal ts=2 sts=2 sw=2
au BufRead,BufNewFile,BufEnter /Users/pin/rep/thumbtack-resource-tool/* setlocal ts=4 sts=4 sw=4

" au BufRead,BufNewFile,BufEnter *.c setlocal noexpandtab ts=4 sw=4

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
" nmap <C-S-l> <C-w>L
" nmap <C-S-h> <C-w>H
" nmap <C-S-k> <C-w>K
" nmap <C-S-j> <C-w>J

" Tabs
map <leader>tl :tabn<CR>
map <leader>tL :tablast<CR>
map <leader>th :tabp<CR>
map <leader>tH :tabfirst<CR>
map <leader>tt :tabnew<CR>
map <leader>to :tabonly<CR>
map <leader>tq :q<CR>

" Page up and page down
map J <C-f>zz
map K <C-b>zz

" Beginning of line and end of line
nmap L $
vmap L $
nmap H ^
vmap H ^

" Center screen on next and prev functions
nmap [[ [[zz
nmap ]] ]]zz

" Navigate to header/source
" nmap <leader>gh :call NavigateToHeader()<CR>

" Smart navigate to file under cursor for Bitrix
nmap <leader>bg :call BitrixNavigateAuto()<CR>
nmap <leader>bs :call BitrixNavigateStyle()<CR>
nmap <leader>bj :call BitrixNavigateScript()<CR>
nmap <leader>br :call BitrixNavigateResultModifier()<CR>
nmap <leader>bt :call BitrixNavigateTemplate()<CR>
nmap <leader>bc :call BitrixNavigateComponentEpilog()<CR>

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

" Does not work
" imap <C-;> <C-x><C-l>

" Change ; to : and ;; to ;
nmap ; :
vmap ; :

" Reset highlight
augroup no_highlight
" autocmd TermResponse * nnoremap <esc> :noh<return><esc>
nnoremap <esc> :noh<return><esc>
augroup END

nmap <leader>n :call NERDTreeToggleInCurDir()<CR>
nmap <leader>v :Tagbar<CR>

" Copy to buffer
nmap Y "+yy
vmap Y "+y

" imap <C-b> <Plug>snipMateNextOrTrigger
imap <Tab> <Plug>snipMateNextOrTrigger
imap <S-Tab> <Plug>snipMateBack
imap <C-j> <Plug>snipMateNextOrTrigger
imap <C-k> <Plug>snipMateBack

map <leader>gs :Gstatus<CR>
map <leader>gd :Gvdiff<CR>
map <leader>gc :Gcommit<CR>
map <leader>gb :Gblame -w<CR>
map <leader>gl :Glog<CR>
map <leader>ge :Gedit<CR>
map <leader>gw :Gwrite<CR>
map <leader>gp :Gpush<CR>
map <leader>gg :GitGutterSignsToggle<CR>

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

" Ack
" nmap <leader>a :Ack ""<left>
nmap <leader>a :Ag<CR>
" Make Ag search only in file contents and not the file names
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)

nmap <leader>A :Ack <cword>

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

" " Paste without indentation (strange behaviour)
" nmap Yo :set paste<CR>o
" nmap YO :set paste<CR>O
" nmap Yi :set paste<CR>i
" nmap YI :set paste<CR>I
" nmap Ya :set paste<CR>a
" nmap YA :set paste<CR>A
" au InsertLeave * :set nopaste

" Edit settigs files
nmap <leader>sv :e ~/.vimrc<CR>
nmap <leader>st :e ~/.tmux.conf<CR>
nmap <leader>sb :e ~/.bashrc<CR>
nmap <leader>sz :e ~/.zshrc<CR>
nmap <leader>ss :e ~/.vim/after/snippets<CR>
nmap <leader>sc :e ~/.ctags<CR>
" nmap <leader>sa :e ~/.ackrc<CR>
nmap <leader>sa :e ~/.agignore<CR>
nmap <leader>si :e ~/.i3/config<CR>
nmap <leader>sx :e ~/.Xresources<CR>

" " Moving lines and indenting (CTRL-Shift-LKJH)
" " For this to work ,set xterm*metaSendsEscape: true
" " in ~/.Xresourses if using i3 window manager
" vmap <ESC><C-J> dp`[V`]
" vmap <ESC><C-K> dkP`[V`]
" vmap <ESC><C-L> >`[V`]
" vmap <ESC><C-H> <`[V`]
"
" nmap <ESC><C-J> ddp
" nmap <ESC><C-K> ddkP
" " Moving arguments (sideways.vim)
" nmap <ESC><C-H> :SidewaysLeft<CR>
" nmap <ESC><C-L> :SidewaysRight<CR>

" Gundo
nmap <leader>u :GundoToggle<CR>

" Run ctags in current directory
" nmap <leader>ct :!ctags -R<CR>
" nmap <leader>ct :!ctags -R -L .ctags_include<CR>
nmap <leader>ct :!ctags -R *<CR>

" Select by indent
nmap vii :call SelectIndent(0)<CR>
nmap vai :call SelectIndent(1)<CR>
nmap dii :call SelectIndent(0)<CR>d
nmap dai :call SelectIndent(1)<CR>d
nmap cii :call SelectIndent(0)<CR>c
nmap cai :call SelectIndent(1)<CR>c

" C-w replacement
nmap <leader>w <C-w>
" Open current split in new tab
nmap <leader>wt <C-w>T

" Search selection
vmap * y/<C-R>"<CR>

" Paste from current register/buffer in insert mode
" imap ppp <C-R>"
" imap bbb <C-R>*

" " Remove all trailing whitespaces
" nmap <leader>W :%s/\s\+$//<CR>

" Make headers
nmap <leader>h1 :s/\v<([A-Za-zА-Яа-я])(S*)/\u\1\L\2/g<CR>VypVr=:noh<CR>
nmap <leader>h2 :s/\v<([A-Za-zА-Яа-я])(S*)/\u\1\L\2/g<CR>VypVr-:noh<CR>

" Multiple cursors
nmap <leader>m :MultipleCursorsFind<space>
vmap m y:MultipleCursorsFind<space><C-R>"<CR>
nmap <leader>M y:MultipleCursorsFind<space><C-R>/<CR>

" Misc
" Thrustmaster TARGET run
nmap <leader>tm :call TARGETRun()<CR>

" Jump to adjacent files --------------------------------------------------{{{1

" General
nmap <leader>ip :e %:r.pug<CR>
nmap <leader>is :e %:r.sass<CR>
nmap <leader>it :e %:r.ts<CR>
nmap <leader>ih :e %:r.html<CR>

" Angular
nmap <leader>iac :e %:r.ts<CR>
nmap <leader>iat :e %:r.ts<CR>
nmap <leader>iap :e %:r.pug<CR>
nmap <leader>ias :e %:r.sass<CR>

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
filetype off				  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
" Plugin 'edkolev/tmuxline.vim'
Plugin 'bling/vim-airline'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tomtom/tcomment_vim'
" Plugin 'scrooloose/nerdcommenter'
Plugin 'majutsushi/tagbar'
:source $VIMRUNTIME/macros/matchit.vim
" Plugin 'tpope/vim-obsession'
Plugin 'godlygeek/tabular'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'lokaltog/vim-easymotion'
Plugin 'mileszs/ack.vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'sjl/gundo.vim'
" Plugin 'christoomey/vim-tmux-navigator'
Plugin 'tpope/vim-surround'
Plugin 'airblade/vim-gitgutter'
Plugin 'danro/rename.vim'
Plugin 'gregsexton/gitv'
" Plugin 'scrooloose/syntastic'
Plugin 'w0rp/ale'
" Plugin 'benmills/vimux'
Plugin 'jeetsukumaran/vim-buffergator'
" Plugin 'mtscout6/vim-tagbar-css'
Plugin 'AndrewRadev/sideways.vim'
" Plugin 'kaneshin/ctrlp-git-log'
Plugin 'terryma/vim-multiple-cursors'
" Plugin 'itchyny/calendar.vim'
Plugin 'stefandtw/quickfix-reflector.vim' " Make changes directly from quickfix list
" Plugin 'wincent/terminus'
" Plugin 'junegunn/vim-easy-align'
" Plugin 'tpope/vim-projectionist' " Edit .h/.c file. Can do more than C.
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim'

" javascript
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'

" HTML
Plugin 'mattn/emmet-vim'
au FileType html,css,scss,sass,php,htmldjango EmmetInstall

" Python
" Plugin 'klen/python-mode'
" Plugin 'JarrodCTaylor/vim-python-test-runner'

" Ruby
Plugin 'tpope/vim-rails'
Plugin 'ngmy/vim-rubocop'

" Misc syntax
Plugin 'Shougo/vinarise.vim' " HEX viewer
" Plugin 'tpope/vim-markdown' " takes 161ms of startup time
" Plugin 'nelstrom/vim-markdown-folding'
Plugin 'avakhov/vim-yaml'
Plugin 'digitaltoad/vim-jade'
Plugin 'vim-scripts/vim-coffee-script'
Plugin 'ap/vim-css-color'
Plugin 'leafgarland/typescript-vim'

" PHP
" Plugin 'vim-php/phpctags'
" Plugin 'pm5/drupal-vimrc'
" Plugin 'joonty/vim-phpqa'
" Plugin 'tobyS/vmustache' " Needed for tobyS/pdv
" Plugin 'tobyS/pdv' " PHPDoc generator
" Plugin 'vim-scripts/PDV--phpDocumentor-for-Vim'
" Plugin 'joonty/vdebug.git' " disabled because takes 437ms of startup time
" Plugin 'captbaritone/better-indent-support-for-php-with-html'

" Snipmate
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'

call vundle#end()			 " required
filetype plugin indent on	 " required

" Plugins settings -----------------------------------------{{{1
" Ack ----------------{{{2
let g:ack_apply_qmappings = 0

" Ag (fzf) ----------------{{{2
let g:fzf_history_dir = '~/.local/share/fzf-history'

nmap <leader>g :BCommits<CR>

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'Normal'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Airline ----------------{{{2
set laststatus=2
let g:airline_powerline_fonts=1
let g:Powerline_symbols='fancy'
" set guifont=Ubuntu\ Mono\ for\ Powerline\ 14
" set guifont=Ubuntu\ Mono\ derivative\ Powerline\ 14
" set guifont=Ubuntu\ Mono\ for\ VimPowerline\ 16
set guifont=Ubuntu_Mono_derivative_Powerline:h16
let g:airline_section_x=airline#section#create(['tagbar'])
let g:airline_section_y=airline#section#create(['filetype'])
let g:airline_section_z=airline#section#create(['ffenc'])

" ALE ---------------{{{2
let g:airline#extensions#ale#enabled = 1
let g:ale_c_parse_makefile = 1
" let g:ale_set_loclist = 0
" let g:ale_set_quickfix = 1

" Buffergator ---------------{{{2
nmap gn :BuffergatorMruCycleNext<CR>

let g:buffergator_suppress_keymaps = 1
let g:buffergator_viewport_split_policy = 'B'

nmap <leader>b :BuffergatorToggle<CR>
nmap gb :BuffergatorMruCyclePrev<CR>

" CtrlP ---------------{{{2
let g:ctrlp_custom_ignore = '\v[\/]\.(o|sim|out|jpeg|jpg|pyc)$'
let g:ctrlp_follow_symlinks = 1
set wildignore+=.git,.idea,*.DS_Store,*.o
set wildignore+=*.swp
set wildignore+=bower_components,node_modules,dist
set wildignore+=public/js,public/css
set wildignore+=tmp
let g:ctrlp_show_hidden = 1

nmap <leader>f :CtrlP<CR>
nmap <leader>t :CtrlPTag<CR>
" nmap <leader>g :CtrlPGitLog<CR>
nmap <leader>s :CtrlPLine<CR>

let g:ctrlp_prompt_mappings = {
  \ 'ToggleType(1)': ['<c-t>'],
  \ 'MarkToOpen()':   ['<c-k>'],
  \ 'PrtCurLeft()':   [],
  \ 'PrtCurRight()':  [],
  \}

let g:ctrlp_working_path_mode = 0
let g:ctrlp_extensions = ['tag', 'quickfix', 'changes', 'gitlog']

" Calendar --------------{{{2
nmap <leader>c :Calendar<CR>
autocmd FileType calendar nmap <buffer> ]ghtii <Plug>(calendar_up)
let g:calendar_google_calendar = 1
let g:calendar_google_task = 1
let g:calendar_first_day = 'monday'

" Gitgutter --------------{{{2
nmap <leader>gr :GitGutterRevertHunk<CR>
set updatetime=100

" Tagbar --------------{{{2
:let g:tagbar_autoclose=1
let g:tagbar_type_coffee = {
    \ 'ctagstype' : 'coffee',
    \ 'kinds'     : [
        \ 'c:classes',
        \ 'm:methods',
        \ 'f:functions',
        \ 'v:variables',
    \ ]
\ }

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

" xmap s <Plug>(easymotion-s)
vmap <Leader>h <Plug>(easymotion-b)
vmap <Leader>j <Plug>(easymotion-j)
vmap <Leader>k <Plug>(easymotion-k)
vmap <Leader>l <Plug>(easymotion-w)

" NERDTree -----------------------------{{{2
let NERDTreeIgnore = ['^lang$', '__pycache__', '^tags$', 'ctags', '.*\.iml', '\.idea', '^vendor$', '^node_modules$', '^bower_components$', '^dist$', 'pyc$', 'yarn-error.log', 'yarn.lock']
" TODO wtf with mac?
" let g:NERDTreeDirArrowExpandable = ''
" let g:NERDTreeDirArrowCollapsible = ''
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''
let g:NERDTreeAutoCenter = 1
let g:NERDTreeWinSize = 40

au FileType nerdtree nmap <buffer> l o
au FileType nerdtree nmap <buffer> h x

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

" Vinarise ------------------------------{{{2
let g:vinarise_enable_auto_detect=1
" let g:vinarise_detect_large_file_size=30000

" Tagbar ----------------------------{{{2
" let g:tagbar_iconchars = ['+', '-']
let g:tagbar_iconchars = ['', '']

au FileType tagbar nmap <buffer> h p
au FileType tagbar nmap <buffer> H x
au FileType tagbar nmap <buffer> l <Enter>
au FileType tagbar nmap <space>v :Tagbar<CR>

" Tmuxline ----------------------------{{{2
let g:tmuxline_preset = {
	\'a'	: '#S',
	\'win'	: ['#I', '#W'],
	\'cwin'	: ['#I', '#W'],
	\'y'	: ['%a', '%d-%m-%Y'],
	\'z'	: '%H:%M'}
" :Tmuxline airline powerline

" Terminus ----------------------------{{{2
let g:TerminusCursorShape=0
" Markdown ------------------------------{{{2
au BufNewFile,BufReadPost *.md set filetype=markdown spell

" PDV ------------------------------{{{2
let g:pdv_template_dir = $HOME ."/.vim/bundle/pdv/templates_snip"
" nnoremap <buffer> <leader>pd :call pdv#DocumentWithSnip()<CR>
nnoremap <leader>pd :call pdv#DocumentWithSnip()<CR>

" phpqa ------------------------------{{{2
" let g:phpqa_codesniffer_args = '--standard=Drupal'
" let g:phpqa_codecoverage_file = '~/rep/penton/app/sites/all/modules/contrib/coder/coder_sniffer/ruleset.xml'
let g:phpqa_messdetector_autorun = 0
let g:phpqa_codesniffer_autorun = 0

" Powerline ------------------------------{{{2
" Powerline config (only when lightline plugin installed)
let g:lightline = {
\	'colortheme': 'wombat',
\	'active': {
\		'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], ['ctrlpmark'] ],
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

" Projectionist ------------------------------{{{2
" Angular --{{{3
let g:projectionist_heuristics = {
      \ "app/common/components/schedule/*.service.ts": {
      \   "app/common/components/schedule/{}.component.ts": {"type": "component"},
      \   "*.service.ts": {"type": "service"},
      \   "*.module.ts": {"type": "module"},
      \   "*.jade": {"type": "template"},
      \ }}

" PythonMode ------------------------------{{{2
let g:pymode_options = 0 " No 80 char bar
let g:pymode_folding = 0
let g:pymode_doc_bind = '<leader>pd'
let g:pymode_rope_rename_bind = '<leader>pr'
let g:pymode_run = 0
let g:pymode_breakpoint = 0

nmap <leader>pu :PymodeRopeUndo<CR>
nmap <leader>pr :PymodeRopeRedo<CR>

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

" Supertab ------------------------------{{{2
let g:SuperTabDefaultCompletionType  = 'context'
let g:SuperTabCrMapping = 1

" TComment -------------------------------{{{2
let g:tcomment_mapleader2 = '<leader>c'
nmap <leader>cc <leader>c_
vmap <leader>cc <leader>c_

" vdebug -------------------------------{{{2
if !exists('g:vdebug_options')
	let g:vdebug_options = {}
endif
if !exists('g:vdebug_options.path_maps')
	let g:vdebug_options.path_maps = {}
endif

let g:vdebug_options = {
	\'debug_file': '/tmp/vdebug.log',
	\'marker_closed_tree': '',
	\'marker_open_tree': '',
	\'marker_default': '-',
	\'on_close': 'detach',
	\'break_on_open': 0,
	\'ide_key': '',
	\'path_maps': {},
	\'debug_window_level': 0,
	\'debug_file_level': 0,
	\'watch_window_style': 'compact',
	\'timeout': 15
	\ }
"expanded

let g:vdebug_options['path_maps']['/var/www/penton'] = $HOME.'/rep/penton/pentonWEB/app'
let g:vdebug_options['path_maps']['/penton'] = $HOME.'/rep/penton/pentonWEB'

" let g:vdebug_options['path_maps']['/var/www/penton'] = $HOME.'/rep/penton/app'
" let g:vdebug_options['path_maps']['/penton'] = $HOME.'/rep/penton'

" au FileType DebuggerWatch map <C-l> :python debugger.handle_return_keypress()

" vim-easy-align -----------------------------{{{2
vmap <leader>a <Plug>(EasyAlign)
" Functions ------------------------------------------------{{{1
" command! Lint execute ESLint()
" function! ESLint()
"   exe ":cexpr system('./node_modules/.bin/eslint ' . expand('%:p') . ' --format unix')"
" endfunction

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

function! SelectIndent (include_surround)
	let temp_var=indent(line("."))
	while indent(line(".")-1) >= temp_var
		exe "normal k"
	endwhile
	if a:include_surround == 1
		exe "normal k"
	endif
	exe "normal V"
	while indent(line(".")+1) >= temp_var
		exe "normal j"
	endwhile
	if a:include_surround == 1
		exe "normal j"
	endif
endfun

" Overrides path!!!
" set path=inc,src
" function! NavigateToHeader()
" 	if match(expand("%"),'\.c') > 0
" 		let s:flipname = substitute(expand("%:t"),'\.c\(.*\)','.h\1',"")
" 		exe ":find " s:flipname
" 	elseif match(expand("%"),"\.h") > 0
" 		let s:flipname = substitute(expand("%:t"),'\.h\(.*\)','.c\1',"")
" 		exe ":find " s:flipname
" 	endif
" endfun

function! BitrixNavigateAuto()
	" "bitrix:news.list","brand-list"
	" "bitrix:news.list",""
	" <?$APPLICATION->IncludeComponent("bitrix:news.list", "slider-main-page", Array(
	let component_namespace	= matchstr(getline('.'), '\v.*"\zs.*\ze:')
	let component_name		= matchstr(getline('.'), '\v:\zs[^"]*\ze"')
	let template_name		= matchstr(getline('.'), '\v:[^"]*"[^"]*"\zs[^"]*')
	let current_selection	= matchstr(expand('<cWORD>'), '\v"\zs[^"]*\ze')
	let current_selection_d	= expand('<cword>')
	echo current_selection == (component_namespace.':'.component_name) && current_selection_d != 'APPLICATION'

	" Browsing component
	if (component_namespace!='' && component_name!='')
		if (template_name != '' && template_name != '.default' || component_namespace != 'bitrix')
			if (current_selection == (component_namespace.':'.component_name) && current_selection_d != 'APPLICATION')
				execute 'silent vsp local/components/'.component_namespace.'/'.component_name.'/component.php'
			else
				if (component_namespace == 'bitrix')
					execute 'silent vsp local/templates/*/components/'.component_namespace.'/'.component_name.'/'.template_name.'/template.php'
				else
					execute 'silent vsp local/components/'.component_namespace.'/'.component_name.'/templates/.default/template.php'
				endif
			endif
		else
			execute 'silent vsp bitrix/components/'.component_namespace.'/'.component_name.'/templates/.default/template.php'
		endif
	endif
endfun

function! BitrixNavigateStyle()
	execute 'silent vsp %:h/style.css'
endfun

function! BitrixNavigateScript()
	execute 'silent vsp %:h/script.js'
endfun

function! BitrixNavigateResultModifier()
	execute 'silent vsp %:h/result_modifier.php'
endfun

function! BitrixNavigateTemplate()
	execute 'silent vsp %:h/template.php'
endfun

function! BitrixNavigateComponentEpilog()
	execute 'silent vsp %:h/component_epilog.php'
endfun

command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()
function! QuickfixFilenames()
	" Building a hash ensures we get each buffer only once
	let buffer_numbers = {}
	for quickfix_item in getqflist()
		let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
	endfor
	return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction

function! TARGETRun()
	" let command = 'belowright split | new | r !/cygdrive/c/Program\ Files\ \(x86\)/Thrustmaster/TARGET/x64/TARGETGUI.exe -r "'
	" let command = 'start /min /cygdrive/c/Program\ Files\ \(x86\)/Thrustmaster/TARGET/x64/TARGETGUI.exe -r "'
	let command = '"C:\Program Files (x86)\Thrustmaster\TARGET\x64\TARGETGUI.exe" -r "'
	let path = expand("%:p:")
	let path = substitute(path, '/cygdrive/c', 'C:', '')
	let path = substitute(path, '/', '\', 'g')
	let command .= path
	let command .='"'
	call VimuxRunCommand(command)
	" exec command
endfun

" Useful commands ------------------------------------------------{{{1
" ga - show symbol hex code
au FileType php imap ;; $
au FileType php,javascript,typescript imap ;; <space>=><space>
au FileType c,cpp imap ;; ->
" imap <M-u> (
" imap <M-i> )
" imap <M-j> {
" imap <M-k> }

au FileType php imap ,, <space>-><space>
" imap lll _

" Specific stuff ------------------------------------------------{{{1
au FileType c syn match comment "KC_NO"
au FileType c syn match comment "KC_TRNS"
