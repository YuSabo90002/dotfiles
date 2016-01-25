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
