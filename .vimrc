set fenc=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set fileformats=unix,dos,mac
set noswapfile
set autoread
set autoindent
set list listchars=tab:¦_
set noexpandtab
set shiftwidth=2
set softtabstop=0
filetype plugin indent on
setlocal omnifunc=syntaxcomplete#Complete
set completeopt=menuone,noinsert
set laststatus=2
""set mouse=a
"set ttymouse=xterm2

" 補完表示時のEnterで改行をしない
inoremap <expr><CR>  pumvisible() ? "<C-y>" : "<CR>"

packadd termdebug
let g:termdebug_wide = 163

function! SetUp(ftype)
	let g:system=a:ftype
endfunction

autocmd FileType * :call SetUp(expand('<amatch>'))

"ステータスラインのデザイン設定
function! SetStatusLine()
if mode() =~ 'i'
	let id = 1
	let mode_name = 'Insert'
elseif mode() =~ 'n'
	let id = 2
	let mode_name = 'Normal'
elseif mode() =~ 'R'
	let id = 3
	let mode_name = 'Replace'
else
	let id = 4
	let mode_name = 'Visual'
endif
return '%' . id . '*[' . mode_name . ']%*%5*%<%F%=[%{&ff}] %M %R %18([%{&ft}][%l/%L]%)%*'
endfunction

hi User1 ctermfg=16 ctermbg=196
hi User2 ctermfg=16 ctermbg=46
hi User3 ctermfg=16 ctermbg=51
hi User4 ctermfg=16 ctermbg=63
hi User5 ctermfg=15 ctermbg=8

set statusline=%!SetStatusLine()

set number

let g:tabcheck=0

let g:netrw_liststyle=3
let g:netrw_banner=0
let g:netrw_winsize=15
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_alto=1

let g:NetrwIsOpen=0

"ファイル一覧の表示切り替え
function! ToggleNetrw()
if g:NetrwIsOpen
	let i = bufnr("$")
	while (i >= 1)
		if (getbufvar(i, "&filetype") == "netrw")
			silent exe "bwipeout " . i
		endif
		let i-=1
	endwhile
	let g:NetrwIsOpen=0
else
	let g:NetrwIsOpen=1
	silent Vex
endif
endfunction

"新しいタブが開かれたときのファイル一覧の起動
function! NetrwNewTab()
let g:NetrwIsOpen=1
if g:tabcheck == 0
	let g:tabcheck=1
	silent Vex
endif
endfunction

"ファイル一覧のクローズ
function! NetrwClose()
if g:NetrwIsOpen
	let i = bufnr("$")
	while (i >= 1)
		if (getbufvar(i,"&filetype") == "netrw")
			silent exe "bwipeout " . i
		endif
		let i-=1
	endwhile
	let g:NetrwIsOpen=0
endif
endfunction

"行番号、タブ可視化の解除
function! ManualCopy()
	set nonu
	set nolist
endfunction

"ターミナルをファイル一覧がある状態でもきれいに表示可能にする
command! Term :rightbelow term
"クリップボードに直接貼り付けできないので行番号、タブ可視化の解除
command! Cp :call ManualCopy()
"ファイル一覧の自動展開等の操作
autocmd TabEnter * :let g:tabcheck=0
autocmd BufReadPost * :call NetrwNewTab()
autocmd QuitPre,TabLeave * :call NetrwClose()
autocmd TabClosed * :let g:NetrwIsOpen=0
autocmd VimEnter * :wincmd l

set tabstop=2
set history=5000
set virtualedit=onemore
set wildmode=list:longest

set hlsearch
set wrapscan
set ignorecase
set smartcase
set incsearch

noremap <silent>== :call ToggleNetrw()<CR>
noremap ^ ggVG=

tnoremap <silent><C-e> <C-\><C-n>:q!<CR>
"自動補完
inoremap {<CR> {}<Left><CR><ESC><S-o>
inoremap [<CR> []<Left><CR><ESC><S-o>
inoremap (<CR> ()<Left><CR><ESC><S-o>
inoremap < <><Left>
inoremap ( ()<Left>
inoremap { {}<Left>
inoremap [ []<Left>
inoremap " ""<Left>
"補完検索中の操作
inoremap <expr><C-n> pumvisible() ? "<Down>" : "<C-n>"
inoremap <expr><C-p> pumvisible() ? "<Up>" : "<C-p>"
