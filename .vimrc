filetype plugin indent on
set ff=unix
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set encoding=utf-8
set rtp+=/usr/bin/fzf
set autoindent expandtab tabstop=4 shiftwidth=4
let Tlist_Auto_Open = 0 
let Tlist_Ctags_Cmd = '/usr/bin/ctags'
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1
map <C-n> :NERDTreeToggle<CR>
" PLUGIN: FZF
let g:fzf_layout = { 'down':  '40%'}
inoremap jj <Esc>
nnoremap <silent> <C-l> :Files<CR>
nnoremap <silent> <Leader>f :Rg<CR>
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>/ :BLines<CR>
nnoremap <silent> <Leader>' :Marks<CR>
nnoremap <silent> <Leader>g :Commits<CR>
nnoremap <silent> <Leader>H :Helptags<CR>
nnoremap <silent> <Leader>hh :History<CR>
nnoremap <silent> <Leader>h: :History:<CR>
nnoremap <silent> <Leader>h/ :History/<CR> 
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
set grepprg=rg\ --vimgrep\ --smart-case\ --follow
set dictionary+=/usr/share/dict/words
call plug#begin()
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'preservim/nerdtree'
Plug 'rust-lang/rust.vim'
Plug 'mileszs/ack.vim'
call plug#end()
