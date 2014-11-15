"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Vimrc_file: 
"
" Version: 
"       1.0 - 13/09/14 15:43:36
"
" Influenced_by: 
"       http://amix.dk/blog/post/19691#The-ultimate-Vim-configuration-on-Github
"
" Copied_things_from:
"           https://github.com/amix/vimrc
"
" Syntax_highlighted:
"       http://amix.dk/vim/vimrc.html
"
" Sections:
"    -> General
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Moving around, tabs and buffers
"    -> Status line
"    -> Editing mappings
"    -> vimgrep searching and cope displaying
"    -> Spell checking
"    -> Misc
"    -> Plugins
"    -> Helper functions
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"install all plugins from the bundle dir
 execute pathogen#infect()


" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

"Looks like timeoutlen has no effect on <leader>
set timeoutlen=8000 

if has("autocmd")
      autocmd bufwritepost .vimrc source $MYVIMRC

      " line comments
      autocmd bufnewfile,bufread,bufenter .vimrc noremap <F7> :s/^"//<CR>
      autocmd bufnewfile,bufread,bufenter .vimrc noremap <F6> :s/^/"/<CR>
      autocmd bufnewfile,bufread,bufenter *.cpp,*.h,*.hpp,*.c noremap <F7> :s/^\/\///<CR>
      autocmd bufnewfile,bufread,bufenter *.cpp,*.h,*.hpp,*.c noremap <F6> :s/^/\/\//<CR>

" Return to last edit position when opening files (You want this!)

    autocmd BufReadPost * 
         \ if line("'\"") > 0 && line("'\"") <= line("$") |
         \   exe "normal! g`\"" |
         \ endif
    autocmd BufWrite *.py :call DeleteTrailingWS()
    autocmd BufWrite *.coffee :call DeleteTrailingWS()
    endif

nnoremap <silent> <leader>v :call EditConfig()<cr>

inoremap jk <Esc>
inoremap kj <Esc>
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=700

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread


" Fast saving
" I personally prefer the <C-s> over <leader>w
"nmap <leader>w :w!<cr>

"If the current buffer has never been saved it will have no name, 
"call the file browser to save it, otherwise just save it.

command! -nargs=0 -bar Update if &modified
                          \|    if empty(bufname('%'))
                          \|       browse confirm write
                          \|    else
                          \|       confirm write
                          \|    endif
                          \|    endif


nnoremap <silent> <C-s> :<C-u>Update<CR>
"#this should disable the Ctrl-S for your vim in terminal
"# zsh
"alias vim="stty stop '' -ixoff ; vim"
"# `Frozing' tty, so after any command terminal settings will be restored
"ttyctl -f
""
"# bash
"# No ttyctl, so we need to save and then restore terminal settings
"vim()
"{
"    # osx users, use stty -g
"    local STTYOPTS="$(stty --save)"
"    stty stop '' -ixoff
"    command vim "$@"
"    stty "$STTYOPTS"
""}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 3 lines to the cursor - when moving vertically using j/k
set so=3

"hightlight the current cursor line
"set cursorline

" Turn on the Wild menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc


set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500
if has("win32") && !has("gui_running")
else
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

if has("win32") && !has("gui_running")
else
" Color Settings
"color wombat256
"color xterm16
"color railscasts
"color molokai
"color skittles_dark
color skittles_berry
"colorscheme desert
endif

set background=dark

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
set list
""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Treat long lines as break lines (useful when moving around in them)
" But not useful in macros!!!!
"noremap j gj
"noremap k gk
          
" Map <Space> to <C-d> scroll down 
noremap <space> <C-d>

 if has("gui_running")
    " " C-Space seems to work under gVim on both Linux and win32
 noremap <C-Space> <C-d>
 else " no gui
    " if has("unix")
    " Set your terminal to send <Nul> in case of Ctrl-Space or Shift-Space
        noremap <Nul> <C-b>
    " else
        " " I have no idea of the name of Ctrl-Space elsewhere
    " endif
 endif

" Disable highlight when <leader><cr> is pressed
"map <silent> <leader><cr> :noh<cr>
map <silent> <leader><cr> :<C-u>noh<CR>2<C-g>
" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>


" Close all the buffers
map <leader>ba :1,1000 bd!<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry


" Remember info about open buffers on close
set viminfo^=%


" Unmap the arrow keys
no <down> ddp
no <left> <Nop>
no <right> <Nop>
no <up> ddkP
ino <down> <Nop>
ino <left> <Nop>
ino <right> <Nop>
ino <up> <Nop>
vno <down> <Nop>
vno <left> <Nop>
vno <right> <Nop>
vno <up> <Nop>

" Mouse support

set mouse=a
map <MouseWheelUp> <C-Y>
map <MouseWheelDown> <C-E>
""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
"map 0 ^

" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc

noremap <F2> :e $HOME/todo/todo.txt<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vimgrep searching and cope displaying
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSelection('gv')<CR>

" Open vimgrep and put the cursor in the right position
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>

" Vimgreps in the current file
map <leader><space> :vimgrep // <C-R>%<C-A><right><right><right><right><right><right><right><right><right>

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>

" Do :help cope if you are unsure what cope is. It's super useful!
"
" When you search with vimgrep, display your results in cope by doing:
"   <leader>cc
"
" To go to the next search result do:
"   <leader>cn
"
" To go to the previous search results do:
"   <leader>cp
"
map <leader>cc :botright cope<cr>
map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
map <leader>cn :cn<cr>
map <leader>cp :cp<cr>

" ctags specific settings
" having only one tags file in top level - the semicolon will make vim climb up directories until it finds the tags file.
set tags=tags;

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scripbble
map <leader>q :e ~/buffer<cr>

" Toggle paste mode on and off
" map <leader>pp :setlocal paste!<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" vim

"YankRing
nnoremap <silent> <F11> :YRShow<Cr>
let g:yankring_replace_n_pkey = '<leader>p'


"let g:yankring_replace_n_pkey = '<leader>['



"EasyMotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings-easymotion
nmap <Leader>w <Plug>(easymotion-w)
nmap <Leader>b <Plug>(easymotion-b)
nmap <Leader>e <Plug>(easymotion-e)
nmap <Leader>f <Plug>(easymotion-f)
nmap <Leader>F <Plug>(easymotion-F)

nmap <Leader>k <Plug>(easymotion-k)
nmap <Leader>j <Plug>(easymotion-j)

nmap <Leader><Space> <Plug>(easymotion-s2)

"Powerline
if has("win32") && !has("gui_running")
call add (g:pathogen_disabled, 'vim-powerline')
else
let g:Powerline_symbols = "fancy"
set t_Co=256
endif
"dragvisual
"#########################################################################
"##                                                                     ##
"##  Add the following (uncommented) to your .vimrc...                  ##
"##                                                                     ##
"##     runtime plugin/dragvisuals.vim                                  ##
"##                                                                     ##
      vmap <expr>  <LEFT>   DVB_Drag('left')
      vmap <expr>  <RIGHT>  DVB_Drag('right')
      vmap <expr>  <DOWN>   DVB_Drag('down')
      vmap <expr>  <UP>     DVB_Drag('up')
      vmap <expr>  D        DVB_Duplicate()
"##                                                                     ##
"##     " Remove any introduced trailing whitespace after moving...     ##
"##     let g:DVB_TrimWS = 1                                            ##
"##                                                                     ##
"##  Or, if you use the arrow keys for normal motions, choose           ##
"##  four other keys for block dragging. For example:                   ##
"##                                                                     ##
"##     vmap  <expr>  h        DVB_Drag('left')                         ##
"##     vmap  <expr>  l        DVB_Drag('right')                        ##
"##     vmap  <expr>  j        DVB_Drag('down')                         ##
"##     vmap  <expr>  k        DVB_Drag('up')                           ##
"##                                                                     ##
"##  Or:                                                                ##
"##                                                                     ##
"##     vmap  <expr>  <S-LEFT>   DVB_Drag('left')                       ##
"##     vmap  <expr>  <S-RIGHT>  DVB_Drag('right')                      ##
"##     vmap  <expr>  <S-DOWN>   DVB_Drag('down')                       ##
"##     vmap  <expr>  <S-UP>     DVB_Drag('up')                         ##
"##                                                                     ##
"##  Or even:                                                           ##
"##                                                                     ##
"##     vmap  <expr>   <LEFT><LEFT>   DVB_Drag('left')                  ##
"##     vmap  <expr>  <RIGHT><RIGHT>  DVB_Drag('right')                 ##
"##     vmap  <expr>   <DOWN><DOWN>   DVB_Drag('down')                  ##
"##     vmap  <expr>     <UP><UP>     DVB_Drag('up')                    ##
"##                                                                     ##
"#########################################################################

"CTRL-P

if !has('python')
    echo 'pymatcher plugins needs python'
else
    "    pymatcher does not work yet: always gets NO ENTRIES current workaround: don't clear cache on exit 
"    let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
"   let g:ctrlp_match_func = { 'match': ''}
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_lazy_update = 100
"    let g:ctrlp_max_files = 0
"    let g:ctrlp_custom_ignore = 'tmp$\|\.git$\|\.hg$\|'
"    let g:ctrlp_user_command = 'find %s -type f'
endif

"TagList

nnoremap <silent> <F8> :TlistToggle<CR>

"Ack.vim
" sudo apt-get install ack-grep

let g:ack_default_options = " -H --nocolor --nogroup --column"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

function! EditConfig()
    for config in ['$MYGVIMRC', '$MYVIMRC']
        if exists(config)
            execute 'edit '.config
        endif
    endfor
endfunction





