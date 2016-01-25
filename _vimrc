"""""""""""""""""""""
" 基本設定
"""""""""""""""""""""
" ウインドウのタイトルバーにファイルのパス情報等を表示する
set title
" 行番号を表示する
set number
" カーソルの行を目立つ
set cursorline
" ペア括弧やを表示する
set showmatch

"""""""""""""""""""""
" 配色
"""""""""""""""""""""
" 構文毎に文字色を変化させる
syntax on
" カラースキーマの指定
colorscheme molokai
set t_Co=256

" 行番号の色
highlight LineNr ctermfg=darkyellow

"""""""""""""""""""""
" 検索
"""""""""""""""""""""
" 検索ワードの最初の文字を入力した時点で検索を開始する
set incsearch
" 小文字のみで検索したときに大文字小文字を無視する
set smartcase
" 検索結果をハイライト表示する
set hlsearch

"""""""""""""""""""""
" タブ&インデント
"""""""""""""""""""""
" タブの代わりに空白文字を挿入する
set expandtab
" タブ文字の表示幅
set tabstop=8
" Vimが挿入するインデントの幅
set shiftwidth=8
" 行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする
set smarttab
" 改行時に前の行のインデントを継続する
set autoindent
" 改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set smartindent

"""""""""""""""""""""
" その他
"""""""""""""""""""""
" 他で書き換えられたら自動で読み直す
set autoread
" スワップファイルを生成しない
set noswapfile
" 入力中のコマンドを表示する
set showcmd
" コマンドモードでTabキーによるファイル名を補完する
set wildmenu
" カーソルを行頭、行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]
" 変更中のファイルでも、保存しないで他のファイルを表示
set hidden

"""""""""""""""""""""
" キーマッピング
"""""""""""""""""""""
" 括弧
imap { {}<LEFT>
imap [ []<LEFT>
imap ( ()<LEFT>
" ペストモード
nnoremap pt :set paste<CR>
nnoremap np :set nopaste<CR>

highlight Normal ctermbg=none

""""""""""""""""""""""""""""""
" プラグインのセットアップ
""""""""""""""""""""""""""""""
if has('vim_starting')
  set nocompatible               " Be iMproved

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" ファイルオープンを便利に
NeoBundle 'Shougo/unite.vim'
" Unite.vimで最近使ったファイルを表示できるようにする
NeoBundle 'Shougo/neomru.vim'
" http://blog.remora.cx/2010/12/vim-ref-with-unite.html
""""""""""""""""""""""""""""""
" Unit.vimの設定
""""""""""""""""""""""""""""""
" 入力モードで開始する
let g:unite_enable_start_insert=1
" バッファ一覧
noremap <C-P> :Unite buffer<CR>
" ファイル一覧
noremap <C-N> :Unite -buffer-name=file file<CR>
" 最近使ったファイルの一覧
noremap <C-Z> :Unite file_mru<CR>
" sourcesを「今開いているファイルのディレクトリ」とする
noremap :uff :<C-u>UniteWithBufferDir file -buffer-name=file<CR>
" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
""""""""""""""""""""""""""""""

" ファイルをtree表示してくれる
NeoBundle 'scrooloose/nerdtree'

" Gitを便利に使う
NeoBundle 'tpope/vim-fugitive'

" grep検索の実行後にQuickFix Listを表示する
autocmd QuickFixCmdPost *grep* cwindow

" ステータス行に現在のgitブランチを表示する
set statusline+=%{fugitive#statusline()}

" コメントON/OFFを手軽に実行
NeoBundle 'tomtom/tcomment_vim'

" インデントに色を付けて見やすくする
NeoBundle 'nathanaelkane/vim-indent-guides'

" vimを立ち上げたときに、自動的にvim-indent-guidesをオンにする
let g:indent_guides_enable_on_vim_startup = 1

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
""""""""""""""""""""""""""""""
