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
set number
syntax on
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

"ターミナルを下に開く
command! Term :rightbelow term

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
