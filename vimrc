" General
set nocompatible
set t_Co=256
set clipboard=unnamedplus "Transforme le clipboard vim pour utiliser le clipboard système"
set noswapfile
set nobackup
set autoindent
set smartindent
set lazyredraw " do not redraw while running macros
set linespace=0 " don't insert any extra pixel lines betweens rows
set numberwidth=5 " We are good up to 99999 lines
set foldenable
set foldmethod=indent
set foldlevel=100
if !exists("*SimpleFoldText")
  function SimpleFoldText()
    return getline(v:foldstart).' '
  endfunction
endif
set foldtext=SimpleFoldText() " Custom fold text function (cleaner than default)
set ttymouse=xterm2 " makes it work in everything

call pathogen#infect()
call pathogen#helptags()
runtime! config/**/*.vim
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
let g:ycm_min_num_of_chars_for_completion = 2

"Garde un dossier pour enregistrer les undo"
set undodir=~/.vim/undodir
set undofile
set undolevels=1000
set undoreload=30000

nnoremap <Up> <Nop>
nnoremap <Down> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>

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
highlight SyntasticErrorLine guibg=red
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

"indentLine
"let g:indentLine_color_term = 0
"let g:indentLine_char = '¦'

"Gundo configuration
let g:gundo_close_on_revert = 1
let g:gundo_auto_preview = 1

"Beginning of the code managing automatic opening of MRU
if bufname('') == ''
  autocmd VimEnter * MRU
endif
"End of the code managing automatic opening of MRU

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

colorscheme mustang_vim_colorscheme_by_hcalves
