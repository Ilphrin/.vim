" ========== PLUGINS
  function! DoRemote(arg)
    UpdateRemotePlugins
  endfunction
  call plug#begin("~/.vim/bundle")
    Plug 'scrooloose/nerdcommenter'
    Plug 'SirVer/ultisnips'
    Plug 'bling/vim-airline'
    Plug 'tpope/vim-surround'
    Plug 'sjl/gundo.vim'
    Plug 'fflorent/macrobug.vim', { 'on' : 'Macrobug', 'do': function('DoRemote')}
    Plug 'Shougo/deoplete.nvim', { 'do' : function('DoRemote')}
    Plug 'bling/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'smancill/conky-syntax.vim'
    Plug 'Yggdroot/indentline'
    Plug 'scrooloose/nerdtree'
    Plug 'jistr/vim-nerdtree-tabs'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'benekastah/neomake'
    Plug 'wting/rust.vim', { 'for': 'rust' }
    Plug 'gko/vim-coloresque'
    Plug 'osyo-manga/vim-over'
    Plug 'jiangmiao/auto-pairs'
    Plug 'glts/vim-cottidie'
    Plug 'cespare/vim-toml'
    Plug 'racer-rust/vim-racer'
    Plug 'alvan/vim-closetag'
    Plug 'leafgarland/typescript-vim'
    Plug 'digitaltoad/vim-pug'
    Plug 'mhartington/oceanic-next'
    Plug 'vim-flake8', { 'for': 'python' }
    Plug 'hecal3/vim-leader-guide'
    Plug 'yegappan/mru'
    " We need to install exuberant-ctags for tagbar to work!
    Plug 'majutsushi/tagbar'
    Plug 'harish2704/MatchTag', { 'for': 'html' }
    Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern', 'for': 'javascript' }
    Plug 'ternjs/tern_for_vim', { 'for': 'javascript' }
  call plug#end()

" ========== PLUGINS CONFIGURATION
  " == vim-airline
    let g:airline_powerline_fonts = 1
    let g:airline_theme="badwolf"
    let g:airline_section_y='%{char2nr(getline(".")[col(".")-1])}'

  " == nerdcommenter
    let g:NERDSpaceDelims = 1
    let g:NERDCommentEmptyLines = 1
    let g:NERDTrimTrailingWhitespace = 1

  " == Ultisnips
    let g:UltiSnipsEditSplit = "vertical"
    let g:UltiSnipsExpandTrigger="<c-l>"
    let g:UltiSnipsJumpForwardTrigger="<c-j>"
    let g:UltiSnipsJumpBackwardTrigger="<c-k>"

  " == Deoplete
    let g:deoplete#enable_at_startup = 1

  " == IndentLine
    let g:indentLine_color_gui = '#556688'
    let g:indentLine_color_term = 51
    let g:indentLine_char = '│'
    let g:indentLine_enabled = 1

  " == NERDTreeTabs/NERDTree
    let g:nerdtree_tabs_open_on_console_startup = 1
    let g:nerdtree_tabs_autofind = 1
    let NERDTreeShowBookmarks=1
    let NERDTreeWinSize=35
    let g:nerdtree_tabs_smart_startup_focus = 2

  " == Neomake
    let g:neomake_rust_cargo_maker = {
        \ 'args': ['build'],
        \ 'errorformat':
            \   '%-Z%f:%l,' .
            \   '%+C %s,' .
            \   '%A%f:%l:%c: %*\d:%*\d\ %t%*[^:]: %m,',
        \ }
    let g:neomake_rust_enabled_makers = ['cargo']
    let g:neomake_html_enabled_makers = ['htmlhint']
    let g:neomake_python_enabled_makers = ['pep8']
    let g:neomake_verbose = 0

  " == Tagbar
  let g:tagbar_width = 30
  let g:tagbar_sort = 0
  let g:tagbar_indent = 0
  let g:tagbar_show_linenumbers = 1
  let g:tagbar_singleclick = 1
  let g:tagbar_autoshowtag = 1

  " Use tern_for_vim.
  set completeopt-=preview
  let g:tern#command = ["tern"]
  let g:tern#arguments = ["--persistent"]
  let g:tern#show_arguments_list = "on_move"

" ========== GENERAL PARAMETERS
  set t_Co=256
  if (has("termguicolors"))
    set termguicolors
  endif

  set clipboard+=unnamedplus
  set noswapfile
  set nobackup
  set number
  set numberwidth=4
  set expandtab " For indentation with spaces
  set shiftwidth=2 " Two spaces
  set softtabstop=2 " Two spaces
  set colorcolumn=80
  set cmdheight=3
  set scrolloff=6
  set foldmethod=indent
  set inccommand=split

  " Keep a permanent folder for undos
  set undodir=~/.vim/undodir
  set undofile
  set undolevels=500
  set undoreload=20000

  " To search gf in a path
  let &path="src/,include/,../src/,../include/,../,./"

" ========== MAPPING
  " == Global mapping
  map \ <Leader>
  " == Normal Mapping
    nnoremap <Left> <Nop>
    nnoremap <Right> <Nop>
    nnoremap <Down> <Nop>
    nnoremap <Up> <Nop>
    " Navigation between tabs
      nnoremap <Right> gt
      nnoremap <Left> gT
    " Activation of Tagbars
      nnoremap <F8> :TagbarToggle<CR>
    nnoremap ; :
    nnoremap <F4> :GundoToggle<Cr>
    " Extends vim objects
    let pairs = { ":" : ":",
          \"." : ".",
          \"/" : "/",
          \"\\" : "\\",
          \"," : ",",
          \"=" : "="}
    for [key, value] in items(pairs)
      exe "nnoremap ci".key." T".key."ct".value
      exe "nnoremap ca".key." T".key."cf".value
      exe "nnoremap vi".key." T".key."vt".value
      exe "nnoremap va".key." T".key."vf".value
      exe "nnoremap di".key." T".key."dt".value
      exe "nnoremap da".key." T".key."df".value
      exe "nnoremap yi".key." T".key."yt".value
      exe "nnoremap ya".key." T".key."yf".value
    endfor
    " To always use vim-over
    nnoremap / :OverCommandLine<CR>/
    nnoremap <BS> hx
    nnoremap Q :echo "Tu m'auras pas fuckin' ex mode!"<CR>
    nnoremap <C-F> :TernRename<CR>
  " == Terminal Mapping
    tnoremap <Esc> <C-\><C-n>
    tnoremap <C-]> <C-\><C-n>
  " == Visual Mapping
  vnoremap <BS> x
  vnoremap < <gv
  vnoremap > >gv
  " == Insertion Mapping
    inoremap <C-h> <Esc>bi
    inoremap <C-l> <Esc>ei
    inoremap <C-\> <Esc>o
    inoremap <C-p> <Esc>lo
    inoremap <C-F> <Esc>:TernRename<CR>
  " == Command Mapping
  cmap tabe tabe \| TagbarToggle

" ========== COLORS AND HIGHLIGHTING
  highlight TermCursor guifg=cyan ctermfg=cyan
  highlight PMenu ctermbg=4 ctermfg=7
  highlight LineNr ctermbg=NONE ctermfg=58
  highlight VertSplit cterm=bold ctermbg=NONE ctermfg=178
  highlight ColorColumn ctermbg=52
  highlight SignColumn ctermbg=NONE
  highlight TabLine ctermfg=8 ctermbg=black
  highlight TabLineFill ctermbg=white
  highlight NeomakeErrorSign cterm=bold ctermbg=124
  highlight NeomakeWarningSign ctermbg=3 cterm=bold ctermfg=black
  " colorscheme mustang
  colorscheme OceanicNext

" ========== FUNCTION
  function! s:insert_gates()
    let gatename = substitute(toupper(expand("%:t")), "\\.", "_", "g")
    execute "normal! i#ifndef " . gatename
    execute "normal! o#define " . gatename . " "
    execute "normal! Go#endif /* " . gatename . " */"
    normal! kk
  endfunction

  function! Meow()
    split
    exe "normal \<C-w>J"
    resize 15
    terminal
    exe "terminal cargo run && exit"
  endfunction
  command! Meow call Meow()

  let g:lmap = {}
  function! s:Lmap (keys, rhs, desc)
    execute "map <silent> <Leader>".a:keys ":".a:rhs."<CR>"
    let a:k = split(a:keys, '\zs')
    if len(a:keys) == 1
      let g:lmap[a:keys] = [a:rhs, a:desc]
    endif
    if len(a:keys) == 2
      let g:lmap[a:k[0]][a:k[1]] = [a:rhs, a:desc]
    endif
    if len(a:keys) == 3
      let g:lmap[a:k[0]][a:k[1].a:k[2]] = [a:rhs, a:desc]
    endif
  endfunction

" ========== AUTOCMDS AUGOUPS
  augroup header_c
    autocmd BufRead,BufNewFile *.{h,hpp,hh} set filetype=c.cpp
    autocmd! BufNewFile *.{h,hpp,hh} call <SID>insert_gates()
  augroup END
  augroup config_vim
    autocmd! BufWritePost vimrc source %
  augroup END
  autocmd! BufWritePost,BufRead * silent! Neomake!
  autocmd! BufWritePost,BufRead *.rs silent! Neomake! cargo
  autocmd! BufWritePost *.html Neomake htmlhint
  autocmd BufRead * normal zM
  autocmd! VimEnter * CottidieTip
  autocmd! VimEnter * TagbarToggle
  " Tagbar
  " autocmd FileType tagbar map zc
  " autocmd FileType tagbar map zo

" ========== CALLS TO LMAP
  " free remaining letters for leader
  " ABCDEFGHIJKLMNOPQRSTUVWXYZ
  " abcdefghijklmnopqrstuvwxyz

  " b buffers
  let g:lmap.b = { 'name': '+buffers' }
  " example: call s:Lmap('a', 'b#', 'alt buf')
  "
  " f find - with fzf
  let g:lmap.f = { 'name': '+find' }
  " example: call s:Lmap('f`', 'exe "Marks"', 'marks')

  " g git - with fugitive
  let g:lmap.g = { 'name': '+git' }
  " example: call s:Lmap('gd', 'exe "Gdiff"', 'diff')

  " i indents space and tabs - T2 by default
  let g:lmap.i = { 'name': '+indent' }
  " example: call s:Lmap('is2', 'set expandtab ts=2 sts=2 sw=2', 'space 2')

  " p paste++
  let g:lmap.p = { 'name': '+paste' }
  " example: map <Leader>pp "0p

  " NERDCommenter
  let g:lmap.c = { 'name': '+NERDCommenter' }

  let g:lmap.m = { 'name': "+Other Plugins" }
  call s:Lmap('mr', ':MRU', 'MRU')

  " register display ( Thanks to Delapouite :3 )
  call leaderGuide#register_prefix_descriptions("\\", "g:lmap")
  nnoremap <silent> <leader> :<c-u>LeaderGuide '\'<CR>
  vnoremap <silent> <leader> :<c-u>LeaderGuideVisual '\'<CR>
