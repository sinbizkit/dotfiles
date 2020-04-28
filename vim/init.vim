""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" General options.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible          " Be iMproved (nvim is always nocompatible).
set mouse:a               " Enable the use of the mouse.
set noerrorbells          " No beeps.
set exrc                  " Allow loading local executing local rc files.

" Disable data-loss-safety stuff. In any case an vcs will help.
set noswapfile            " Don't use a swapfile for the buffer.
set nowritebackup         " Do not make a backup file.
set nobackup

set autoread " Automatically reread without asking me anything.
let mapleader=";" " Change <Leader> key to a more convenient.

if (has('nvim'))
  let g:loaded_ruby_provider = 0          " Disable ruby support
  let g:loaded_node_provider = 0          " Disable node support
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Plugins.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on  " Enable loading the plugin and indent files for specific file types.

call plug#begin('~/.config/nvim/plugged')

Plug 'morhetz/gruvbox'            "A dark theme.
Plug 'tpope/vim-fugitive'         "Git wrapper.
Plug 'mhinz/vim-signify'          "Show a diff using Vim its sign column.
Plug 'ryanoasis/vim-devicons'     "Adds file type icons to Vim plugins.
Plug 'tpope/vim-surround'         "Quoting/parenthesizing made simple

Plug 'vim-airline/vim-airline'            "Lean & mean status/tabline for
Plug 'vim-airline/vim-airline-themes'     "vim that's light as air.
let g:airline#extensions#tabline#enabled              = 1
let g:airline#extensions#coc#enabled                  = 1
let g:airline_powerline_fonts                         = 1
let g:airline#extensions#whitespace#mixed_indent_algo = 1

Plug 'vim-scripts/a.vim' " Alternate Files quickly (.c --> .h etc).
let g:alternateExtensions_h = "cpp,c,cxx,cc,CC"

Plug 'scrooloose/nerdcommenter' " Plugin for intensely orgasmic commenting.
let g:NERDSpaceDelims            = 1
let g:NERDTrimTrailingWhitespace = 1

Plug 'majutsushi/tagbar' " Display tags in a window, ordered by scope.
let g:tagbar_autofocus        = 1
let g:tagbar_left             = 1
let g:tagbar_sort             = 0
let g:tagbar_compact          = 1
let g:tagbar_show_linenumbers = 2
let g:tagbar_width            = 60
nnoremap <F7> :TagbarToggle<CR>

" A tree explorer plugin.
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind']}
let g:NERDTreeDirArrows       = 0
let g:NERDTreeShowBookmarks   = 1
let g:NERDChristmasTree       = 1
let g:NERDTreeShowLineNumbers = 1
let g:NERDTreeShowHidden      = 1
let g:NERDTreeWinSize         = 50
nnoremap <F6> :NERDTreeToggle<CR>
nnoremap <Leader><F6> :NERDTreeFind<CR>

" Provides a much simpler way to use some motions in vim
Plug 'Lokaltog/vim-easymotion'
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

" Vim script for text filtering and alignment.
Plug 'godlygeek/tabular'
nnoremap <Leader>aa :Tabularize / /l0<CR>
nnoremap <Leader>a= :Tabularize /=/l1<CR>
vnoremap <Leader>a= :Tabularize /=/l1<CR>
nnoremap <Leader>a: :Tabularize /:/l1<CR>
vnoremap <Leader>a: :Tabularize /:/l1<CR>
nnoremap <Leader>a, :Tabularize /,/l1<CR>
vnoremap <Leader>a, :Tabularize /,/l1<CR>
nnoremap <Leader>a( :Tabularize /(/l0<CR>
vnoremap <Leader>a( :Tabularize /(/l0<CR>
nnoremap <Leader>a{ :Tabularize /{/l0<CR>
vnoremap <Leader>a{ :Tabularize /{/l0<CR>
nnoremap <Leader>a* :Tabularize /*/l1l0<CR>
vnoremap <Leader>a* :Tabularize /*/l1l0<CR>

" Enchanced c++ syntax.
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': 'cpp' }
let g:cpp_class_scope_highlight     = 1
let g:cpp_class_decl_highlight      = 1
let g:cpp_member_variable_highlight = 1

" QML syntax highlighting.
Plug 'peterhoeg/vim-qml', { 'for': 'qml' }

" Display the indention levels with thin vertical lines.
Plug 'Yggdroot/indentLine'

" Asynchronous Lint Engine.
Plug 'dense-analysis/ale'
let g:ale_completion_enabled   = 0
let g:ale_sign_error           = '>>'
let g:ale_sign_warning         = '--'
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter        = 0
let g:ale_lint_on_save         = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_maximum_file_size    = 100 * 1024 " 100 kbytes max
let g:ale_echo_msg_format      = '[%linter%] %s [%severity%]'
let g:airline#extensions#ale#enabled = 1
nnoremap <silent> <Leader>ll :ALELint<CR>
nnoremap <silent> <Leader>lj :ALENext<CR>
nnoremap <silent> <Leader>lk :ALEPrevious<CR>
nnoremap <silent> <Leader>lf :ALEFix<CR>

" The ultimate snippet solution for Vim.
Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger       = "<c-j>"
let g:UltiSnipsJumpForwardTrigger  = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
let g:UltiSnipsEditSplit           = "vertical"

" fzf is a general-purpose command-line fuzzy find.
" PlugInstall and PlugUpdate will clone fzf in ~/.fzf and run the install script
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
let g:fzf_action = {
  \ 'ctrl-t': 'tab split'
  \ , 'ctrl-o': 'split'
  \ , 'ctrl-e': 'vsplit'
  \ }
" Reverse the layout to make the FZF list top-down
let $FZF_DEFAULT_OPTS='--layout=reverse'

autocmd FileType fzf set nonumber norelativenumber
let g:fzf_buffers_jump = 1 " Jump to the existing window if possible
nnoremap <silent> <Leader>t :Files<CR>
nnoremap <silent> <Leader>r :Tags<CR>
nnoremap <silent> <Leader>b :Buffers<CR>

" Intellisense engine for vim8 & neovim, full language server protocol support as VSCode.
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = [
  \ 'coc-highlight'
  \ , 'coc-ultisnips'
  \ , 'coc-rls'
  \ , 'coc-python'
  \ ]

" Enable highlight on CursorHold.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Trigger autocompletion.
imap <silent><expr> <c-space> coc#refresh()
" Go to definition.
nmap <silent> <Leader>gd <Plug>(coc-definition)
" Go to declaration.
nmap <silent> <Leader>ge <Plug>(coc-declaration)
" Go to implementation.
nmap <silent> <Leader>gi <Plug>(coc-implementation)
" Go to references.
nmap <silent> <Leader>gr <Plug>(coc-references)
" Go to next diagnostic error position.
nmap <silent> <Leader>gn <Plug>(coc-diagnostic-next-error)
" Go to prev diagnostic error position.
nmap <silent> <Leader>gp <Plug>(coc-diagnostic-prev-error)

" Show hover (documentation of the current word).
nmap <silent> <Leader>sh :call CocActionAsync('doHover')<CR>
" Show diagnostic.
nmap <silent> <Leader>sd :CocList diagnostics<CR>
" Show outline (Symbols in the current document).
nmap <silent> <Leader>so :CocList outline<CR>
" Show all symbols.
nmap <silent> <Leader>ss :CocList symbols<CR>

" Do rename symbol.
nmap <silent> <Leader>dr <Plug>(coc-rename)
" Do refactor.
nmap <silent> <Leader>de <Plug>(coc-refactor)

" Do format
nmap <silent> <Leader>df <Plug>(coc-format)
vmap <silent> <Leader>df <Plug>(coc-format-selected)

call plug#end()


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Appearance.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colorify line-width restriction marker.
let &colorcolumn=join(range(105, 999),",")
highlight SignColumn guibg=#333233
highlight ColorColumn ctermbg=234

" Colorize ExtraWhiteSpace
highlight default ExtraWhitespace ctermbg=darkred guibg=darkred
autocmd ColorScheme * highlight default ExtraWhitespace ctermbg=darkred guibg=darkred
autocmd BufRead,BufNew * match ExtraWhitespace /\\\@<![\u3000[:space:]]\+$/
" The above flashes annoyingly while typing, be calmer in insert mode
autocmd InsertLeave *  match ExtraWhitespace /\\\@<![\u3000[:space:]]\+$/
autocmd InsertEnter * match ExtraWhitespace /\\\@<![\u3000[:space:]]\+\%#\@<!$/
autocmd TermOpen * setlocal nonumber norelativenumber

" Neovim >= 0.1.5
if (has("termguicolors"))
  set termguicolors
endif

set list lcs=tab:▸\ ,space:·    " Tab symbol.
set cursorline                  " Highlighting that moves with the cursor.
set noshowmode                  " Turn off the native mode indicator.
set encoding=utf-8              " Default encoding.
set foldmethod:syntax           " Syntax highlighting items specify folds.
set foldlevel=3                 " Close folds with the higher level.
set number                      " Print the linenumber in front of each line.
set relativenumber              " Show the line number relative to the line.
set showtabline=2               " Always show the line with tab page labels.
set shortmess=atI               " Remove all useless messages.
set splitbelow                  " Splitting will put the new window below the current one.
set pumheight=15                " Maximum number of items showed in a popup menu.
set signcolumn=yes              " Always show the sign column.

" This will show the popup menu even if there's only one match (menuone),
" prevent automatic selection (noselect) and prevent automatic text injection
" into the current line (noinsert).
set completeopt=noinsert,menuone,noselect
" supress the annoying 'match x of y', 'The only match' and 'Pattern not
" found' messages
set shortmess+=c
set laststatus=2 " The last window will always have a status line.

" Theme.
let g:gruvbox_contrast_dark='hard'
silent! colorscheme gruvbox

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Global mappings.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Split current window vertically.
nnoremap ne :vsplit<CR>
" Split current window horizontally.
nnoremap no :split<CR>
" Open new tab.
nnoremap nt :tabnew<CR>
" Remove trailing whitespaces
nnoremap <Leader>ww :%s/\s\+$//<CR>
" Panes navigation.
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" Tags.
nnoremap <Leader>]n :tnext<CR>
nnoremap <Leader>]p :tprevious<CR>
" Change the behavior of the <Enter> key when the popup menu is visible. In that
" case the Enter key will simply select the highlighted menu item, just as <C-Y> does.
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Use <TAB> to select the popup menu:
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

