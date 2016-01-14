" General
set nocompatible
" For some reason, gnome-terminal says xterm-color even though it supports
" xterm-256color.
let $TERM = "xterm-256color"
set t_Co=256
set clipboard+=unnamedplus "Transforme le clipboard vim pour utiliser le clipboard système"
set noswapfile
set nobackup
set autoindent
set smartindent
set lazyredraw " do not redraw while running macros
set linespace=10 " don't insert any extra pixel lines betweens rows
set number
set numberwidth=5 " We are good up to 99999 lines
set foldenable
set foldmethod=manual
set expandtab
set shiftwidth=2
set softtabstop=2
set foldlevel=30
if !exists("*SimpleFoldText")
  function SimpleFoldText()
    return getline(v:foldstart).' '
  endfunction
endif
set foldtext=SimpleFoldText() " Custom fold text function (cleaner than default)
"set ttymouse=xterm2 " makes it work in everything

function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    !cargo build --release
    UpdateRemotePlugins
  endif
endfunction

call plug#begin('~/.vim/bundle')
Plug 'https://github.com/Valloric/YouCompleteMe', {'do': './install.py'}
Plug 'https://github.com/chrisbra/Colorizer'
Plug 'https://github.com/Raimondi/delimitMate'
Plug 'https://github.com/vim-scripts/mru.vim'
Plug 'https://github.com/scrooloose/nerdcommenter.git'
Plug 'https://github.com/scrooloose/nerdtree.git', {'on': 'NERDTreeToggle'}
Plug 'https://github.com/wting/rust.vim.git', { 'for': 'rust' }
Plug 'https://github.com/scrooloose/syntastic'
Plug 'https://github.com/majutsushi/tagbar'
Plug 'http://github.com/SirVer/ultisnips'
Plug 'https://github.com/bling/vim-airline'
Plug 'https://github.com/Ilphrin/vim-cargo.git', { 'for': 'rust' }
Plug 'https://github.com/elzr/vim-json.git'
Plug 'https://github.com/euclio/vim-markdown-composer.git'
Plug 'critiqjo/lldb.nvim'
Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer'), 'for': 'markdown' }
Plug 'jelera/vim-javascript-syntax', { 'for': ['js', 'json'] }
Plug 'Shutnik/jshint2.vim', { 'for': ['js', 'json'] }
Plug 'gilgigilgil/anderson.vim'
Plug 'blueyed/vim-diminactive'
Plug 'tpope/vim-surround'
call plug#end()

let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
let g:ycm_min_num_of_chars_for_completion = 2
let g:ycm_filetype_blacklist = {}

"Garde un dossier pour enregistrer les undo"

set undodir=~/.vim/undodir
set undofile
set undolevels=500
set undoreload=20000

nnoremap <Up> <Nop>
nnoremap <Down> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>

"Meme comportement que Sublime Text
inoremap <C-x> <Esc>ddi

"Pour pouvoir sauvegarder rapidement
inoremap <C-s> <Esc>:w<CR>a

"Permet de naviguer entre les onglets"
nnoremap <Right> gt
nnoremap <Left> gT
"Sert pour les Tags dans le code"
nmap <F8> :TagbarToggle<CR>
"Plus rapide quand on est en qwerty
nnoremap ; :
"Use to speed up NERDComment
nnoremap <F3> \cs
"Used to remap F4 for gundo"
map <F4> :GundoToggle<CR>
let g:undo_width = 70
let g:undo_preview_height = 40
"Replace Tab by Spaces
map <F2> :retab<CR>
augroup config
  autocmd! BufWritePost vimrc source %
augroup END

"DelimitMate configuration
let g:delimitMate_expand_cr = 2
let g:delimitMate_jump_expansion = 1

"MRU configuration
let MRU_Window_Height = 15
let MRU_Max_Menu_Entries = 15

"Syntastic configuration"
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_loc_list_height = 3
let g:syntastic_stl_format = '[%E{Err: %e => %fe}%B{, }%W{Warn: %e => %fw}]'
let g:syntastic_c_remove_include_errors = 1
let g:ycm_show_diagnostics_ui = 0 "Pour ne pas faire entrer en collision les checker, on prend
"que celui de syntastic"
highlight SyntasticErrorSign guifg=white guibg=red
highlight SyntasticWarningLine guifg=white guibg=orange
highlight SyntasticErrorLine guibg=black
highlight SyntasticWarningLine guibg=orange

let g:UltiSnipsExpandTrigger="<c-l>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsEditSplit = "vertical"

"Vim-airline configuration
set laststatus=2 "Permet d'afficher le statusbar meme lorsqu'on a pas split Vim
let g:airline_powerline_fonts = 1
let g:airline_theme="papercolor"
let g:airline_section_x='%{strftime("%H:%M")}'
let g:airline_section_y='%{char2nr(getline(".")[col(".")-1])}'
let g:airline_section_z='Line:%l Col:%c'

"Colorizer
let g:colorizer_auto_filetype='css,html'
let g:colorizer_skip_comments = 1

"Gundo configuration
let g:gundo_close_on_revert = 1
let g:gundo_auto_preview = 1

" markdown-composer for neovim
let g:markdown_composer_browser = "/home/pellet_k/Téléchargements/firefox/firefox"

if !exists("*StripExtension")
  function StripExtension(file)
    return join(split(a:file, '\.')[0:-2], '\.')
  endfunction
endif

"Beginning of code for managing LaTeX files
"This command is used to create files with pdflatex, move the files in the
"same directory as the working file's, and run evince on the new pdf created
if !exists(":TexPDFShow")
  command TexPDFShow execute "!pdflatex ".bufname('')." && mv -b ".StripExtension(expand("%:t")).".* ".expand("%:p:h")." && evince ".StripExtension(bufname('')).".pdf"
endif
"End

function! s:insert_gates()
  let gatename = substitute(toupper(expand("%:t")), "\\.", "_", "g")
  execute "normal! i#ifndef " . gatename
  execute "normal! o# define " . gatename
  execute "normal! o"
  execute "normal! Go#endif /* " . gatename . " */"
  normal! kk
endfunction
autocmd BufNewFile *.{h,hpp,hh} call <SID>insert_gates()

" Colors and highlighting
colorscheme mustang_vim_colorscheme_by_hcalves

hi ColorColumn ctermbg=0
