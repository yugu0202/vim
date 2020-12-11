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
set clipboard&
set clipboard^=unnamedplus
setlocal omnifunc=syntaxcomplete#Complete
filetype on
set laststatus=2
"set mouse=a
"set ttymouse=xterm2

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

function! NetrwNewTab()
	let g:NetrwIsOpen=1
	if g:tabcheck == 0
		let g:tabcheck=1
		silent Vex
	endif
endfunction

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

function! Run()
	let l:line=getline(0,line("$"))
	let l:buffText=join(l:line,"")
	let l:buffText=substitute(l:buffText,[" ","	"],["",""])
	let l:buffText=l:buffText . "\n"
	call term_sendkeys(g:scmterm,l:buffText)
endfunction

let g:scmterm=0
function! ScmTermRun()
	if g:scmterm == 0
		rightbelow term gosh
		let g:scmterm=term_list()[0]
	endif
endfunction

function! ScmCloseChk()
	if match(term_list(),g:scmterm)
		let g:scmterm=0
	endif
endfunction

command! Term :rightbelow term
command! UnsetNum :set nonu
command! SetNum :set number
"goshのパス通しをしていることが条件
autocmd FileType scheme command! Run :call Run()
autocmd FileType scheme command! RunScheme :call ScmTermRun()
"ファイル一覧の自動展開等の操作
autocmd TabEnter * :let g:tabcheck=0
autocmd BufReadPost * :call NetrwNewTab()
autocmd QuitPre,TabLeave * :call NetrwClose()
autocmd TabClosed * :let g:NetrwIsOpen=0
autocmd VimEnter * :wincmd l
"スペースからタブへの自動置換(起動時)
autocmd VimEnter * :retab!

autocmd WinEnter * :call ScmCloseChk()

set tabstop=2
set history=5000
set virtualedit=onemore
set wildmode=list:longest

set hlsearch
set smartcase
set incsearch

noremap <silent>== :call ToggleNetrw()<CR>
noremap ^ ggVG=

tnoremap <C-e> <C-\><C-n>:q!<CR>
tnoremap <C-n><C-n> <C-\><C-n>

inoremap <C-^> <ESC>ggVG=
inoremap {<CR> {}<Left><CR><ESC><S-o>
inoremap [<CR> []<Left><CR><ESC><S-o>
inoremap (<CR> ()<Left><CR><ESC><S-o>
inoremap < <><Left>
inoremap ( ()<Left>
inoremap { {}<Left>
inoremap [ []<Left>
inoremap " ""<Left>
inoremap ' ''<Left>
