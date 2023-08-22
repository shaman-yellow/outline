let SessionLoad = 1
if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
imap <Nul> <C-Space>
inoremap <expr> <Up> pumvisible() ? "\" : "\<Up>"
inoremap <expr> <S-Tab> pumvisible() ? "\" : "\<S-Tab>"
inoremap <expr> <Down> pumvisible() ? "\" : "\<Down>"
inoremap <C-L> f)x;
inoremap <C-C> 
inoremap <silent> <Plug>(ale_complete) :ALEComplete
inoremap <silent> <Plug>NERDCommenterInsert :call nerdcommenter#Comment('i', "Insert")
inoremap <silent> <SNR>55_AutoPairsReturn =AutoPairsReturn()
cnoremap <C-J> <Down>
cnoremap <C-K> <Up>
inoremap <C-Space> :call g:ZFVimIME_keymap_toggle_i()
noremap  :s/\v,([ ])@!/, /g
noremap  :s/\v( )@<!\=([ ])@!/ = /g
tnoremap 	 	
nnoremap 	[ ?functionf{i 
nnoremap 		 df,"_dwf,a p
nnoremap 	i :Tc
nnoremap 	j :Ti
nnoremap <NL> :call Tab_switch()
tnoremap <NL> w:execute "res " . g:winheight
nnoremap  diw%x``x
nnoremap  :call Insert_line()i
nnoremap  "+p
tnoremap  N?^>n
vnoremap  "+y
nnoremap  f :call Pretty_function()f a?<-f(%%a``i
nnoremap  j {/{wyt,`mp
nnoremap  gi :NERDTreeFindgi
nnoremap  i :NERDTreeFind
nnoremap  o :NERDTreeFocus
nnoremap  w 
nnoremap    :set undoreload=0 | edit
nnoremap  l mm:LeaderfLine
nnoremap  h mm:LeaderfLineAll@article
nnoremap  m |:execute "res " . g:winheight
nnoremap  n T
nnoremap ,d :YcmShowDetailedDiagnostic
nnoremap <silent> ,f :LeaderfFile
nmap ,ca <Plug>NERDCommenterAltDelims
xmap ,cu <Plug>NERDCommenterUncomment
nmap ,cu <Plug>NERDCommenterUncomment
xmap ,cb <Plug>NERDCommenterAlignBoth
nmap ,cb <Plug>NERDCommenterAlignBoth
xmap ,cl <Plug>NERDCommenterAlignLeft
nmap ,cl <Plug>NERDCommenterAlignLeft
nmap ,cA <Plug>NERDCommenterAppend
xmap ,cy <Plug>NERDCommenterYank
nmap ,cy <Plug>NERDCommenterYank
xmap ,cs <Plug>NERDCommenterSexy
nmap ,cs <Plug>NERDCommenterSexy
xmap ,ci <Plug>NERDCommenterInvert
nmap ,ci <Plug>NERDCommenterInvert
nmap ,c$ <Plug>NERDCommenterToEOL
xmap ,cn <Plug>NERDCommenterNested
nmap ,cn <Plug>NERDCommenterNested
xmap ,cm <Plug>NERDCommenterMinimal
nmap ,cm <Plug>NERDCommenterMinimal
xmap ,c  <Plug>NERDCommenterToggle
nmap ,c  <Plug>NERDCommenterToggle
xmap ,cc <Plug>NERDCommenterComment
nmap ,cc <Plug>NERDCommenterComment
map ,w <Plug>(easymotion-w)
map ,b <Plug>(easymotion-b)
map , <Plug>(easymotion-prefix)
noremap - ;
nnoremap ;epdf :!R CMD Rd2pdf --title="exMCnebula2" -o ../reference.pdf ..
nnoremap ;pdf :!R CMD Rd2pdf --title="MCnebula2" -o ../reference.pdf ..
vnoremap ;cc :s/^/#\' /g
vnoremap ;cu :s/#\'[^a-z]\{0,1\}//g
nnoremap ;r :Rinsert 
xnoremap <silent> <expr> ;. ZFVimIME_keymap_remove_v()
nnoremap <silent> <expr> ;. ZFVimIME_keymap_remove_n()
xnoremap <silent> <expr> ;, ZFVimIME_keymap_add_v()
nnoremap <silent> <expr> ;, ZFVimIME_keymap_add_n()
vnoremap <silent> <expr> ;: ZFVimIME_keymap_next_v()
nnoremap <silent> <expr> ;: ZFVimIME_keymap_next_n()
vnoremap <silent> <expr> ;; ZFVimIME_keymap_toggle_v()
nnoremap <silent> <expr> ;; ZFVimIME_keymap_toggle_n()
nnoremap ;b :RSend custom_render("index.Rmd")
nnoremap ;e :tabnew:Startify
nnoremap ;f :tabe ~/.vim/after/ftplugin/
nnoremap ;n :nohlsearch
nnoremap ;q :q
nnoremap ;s :source ~/.vimrc
nnoremap ;sf :source ~/.vim/after/ftplugin/
nnoremap ;v :tabe ~/.vim/after/ftplugin/.vimrc
nnoremap ;w :w
nmap <p <Plug>(unimpaired-put-below-leftward)
nmap <P <Plug>(unimpaired-put-above-leftward)
nmap <s <Plug>(unimpaired-enable)
nmap =p <Plug>(unimpaired-put-below-reformat)
nmap =P <Plug>(unimpaired-put-above-reformat)
nmap =s <Plug>(unimpaired-toggle)
nmap >p <Plug>(unimpaired-put-below-rightward)
nmap >P <Plug>(unimpaired-put-above-rightward)
nmap >s <Plug>(unimpaired-disable)
nmap [xx <Plug>(unimpaired-xml-encode-line)
xmap [x <Plug>(unimpaired-xml-encode)
nmap [x <Plug>(unimpaired-xml-encode)
nmap [uu <Plug>(unimpaired-url-encode-line)
xmap [u <Plug>(unimpaired-url-encode)
nmap [u <Plug>(unimpaired-url-encode)
nmap [CC <Plug>(unimpaired-string-encode-line)
xmap [C <Plug>(unimpaired-string-encode)
nmap [C <Plug>(unimpaired-string-encode)
nmap [yy <Plug>(unimpaired-string-encode-line)
xmap [y <Plug>(unimpaired-string-encode)
nmap [y <Plug>(unimpaired-string-encode)
nmap [P <Plug>(unimpaired-put-above)
nmap [p <Plug>(unimpaired-put-above)
nmap [o <Plug>(unimpaired-enable)
xmap [e <Plug>(unimpaired-move-selection-up)
nmap [e <Plug>(unimpaired-move-up)
nmap [  <Plug>(unimpaired-blank-up)
omap [n <Plug>(unimpaired-context-previous)
xmap [n <Plug>(unimpaired-context-previous)
nmap [n <Plug>(unimpaired-context-previous)
nmap [f <Plug>(unimpaired-directory-previous)
nmap [<C-T> <Plug>(unimpaired-ptprevious)
nmap [ <Plug>(unimpaired-ptprevious)
nmap [T <Plug>(unimpaired-tfirst)
nmap [t <Plug>(unimpaired-tprevious)
nmap [<C-Q> <Plug>(unimpaired-cpfile)
nmap [ <Plug>(unimpaired-cpfile)
nmap [Q <Plug>(unimpaired-cfirst)
nmap [q <Plug>(unimpaired-cprevious)
nmap [<C-L> <Plug>(unimpaired-lpfile)
nmap [ <Plug>(unimpaired-lpfile)
nmap [L <Plug>(unimpaired-lfirst)
nmap [l <Plug>(unimpaired-lprevious)
nmap [B <Plug>(unimpaired-bfirst)
nmap [b <Plug>(unimpaired-bprevious)
nmap [A <Plug>(unimpaired-first)
nmap [a <Plug>(unimpaired-previous)
nnoremap \pd {V}:FloatermSend}w
nnoremap \pp {V}:FloatermSendw
noremap \l :FloatermSend
nnoremap \rq :FloatermKill
nnoremap \rf :FloatermToggle
nmap ]xx <Plug>(unimpaired-xml-decode-line)
xmap ]x <Plug>(unimpaired-xml-decode)
nmap ]x <Plug>(unimpaired-xml-decode)
nmap ]uu <Plug>(unimpaired-url-decode-line)
xmap ]u <Plug>(unimpaired-url-decode)
nmap ]u <Plug>(unimpaired-url-decode)
nmap ]CC <Plug>(unimpaired-string-decode-line)
xmap ]C <Plug>(unimpaired-string-decode)
nmap ]C <Plug>(unimpaired-string-decode)
nmap ]yy <Plug>(unimpaired-string-decode-line)
xmap ]y <Plug>(unimpaired-string-decode)
nmap ]y <Plug>(unimpaired-string-decode)
nmap ]P <Plug>(unimpaired-put-below)
nmap ]p <Plug>(unimpaired-put-below)
nmap ]o <Plug>(unimpaired-disable)
xmap ]e <Plug>(unimpaired-move-selection-down)
nmap ]e <Plug>(unimpaired-move-down)
nmap ]  <Plug>(unimpaired-blank-down)
omap ]n <Plug>(unimpaired-context-next)
xmap ]n <Plug>(unimpaired-context-next)
nmap ]n <Plug>(unimpaired-context-next)
nmap ]f <Plug>(unimpaired-directory-next)
nmap ]<C-T> <Plug>(unimpaired-ptnext)
nmap ] <Plug>(unimpaired-ptnext)
nmap ]T <Plug>(unimpaired-tlast)
nmap ]t <Plug>(unimpaired-tnext)
nmap ]<C-Q> <Plug>(unimpaired-cnfile)
nmap ] <Plug>(unimpaired-cnfile)
nmap ]Q <Plug>(unimpaired-clast)
nmap ]q <Plug>(unimpaired-cnext)
nmap ]<C-L> <Plug>(unimpaired-lnfile)
nmap ] <Plug>(unimpaired-lnfile)
nmap ]L <Plug>(unimpaired-llast)
nmap ]l <Plug>(unimpaired-lnext)
nmap ]B <Plug>(unimpaired-blast)
nmap ]b <Plug>(unimpaired-bnext)
nmap ]A <Plug>(unimpaired-last)
nmap ]a <Plug>(unimpaired-next)
xmap gx <Plug>NetrwBrowseXVis
nmap gx <Plug>NetrwBrowseX
nnoremap j gj
nnoremap k gk
nnoremap tg gT
nmap yo <Plug>(unimpaired-toggle)
nnoremap <Down>n :tabe | read ~/utils.tool/inst/extdata/job_templ/workflow.R
nnoremap <SNR>168_: :=v:count ? v:count : ''
nnoremap <silent> <Plug>(YCMFindSymbolInDocument) :call youcompleteme#finder#FindSymbol( 'document' )
nnoremap <silent> <Plug>(YCMFindSymbolInWorkspace) :call youcompleteme#finder#FindSymbol( 'workspace' )
noremap <C-F> :s/\v( )@<!\=([ ])@!/ = /g
nnoremap <Left><Left> :RSend source("~/.vim/after/ftplugin/reloadPackage.R")
nnoremap <Down><Down> :RSend source("~/.vim/after/ftplugin/removeOldClassReLoad.R")
nnoremap <Right> :RSend source("~/.vim/after/ftplugin/r/initialize.R")
nnoremap <Left>t :RSend source("~/.vim/after/ftplugin/r/initialize2.R")
nnoremap <Left>m :RSend devtools::load_all("~/MCnebula2")
nnoremap <Left>e :RSend devtools::load_all("~/exMCnebula2")
nnoremap <Left>r :RSend roxygen2::roxygenize("..")
nnoremap <C-K> diw%x``x
xnoremap <silent> <Plug>NetrwBrowseXVis :call netrw#BrowseXVis()
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#BrowseX(netrw#GX(),netrw#CheckIfRemote(netrw#GX()))
map <silent> <Plug>(easymotion-prefix)N <Plug>(easymotion-N)
map <silent> <Plug>(easymotion-prefix)n <Plug>(easymotion-n)
map <silent> <Plug>(easymotion-prefix)k <Plug>(easymotion-k)
map <silent> <Plug>(easymotion-prefix)j <Plug>(easymotion-j)
map <silent> <Plug>(easymotion-prefix)gE <Plug>(easymotion-gE)
map <silent> <Plug>(easymotion-prefix)ge <Plug>(easymotion-ge)
map <silent> <Plug>(easymotion-prefix)E <Plug>(easymotion-E)
map <silent> <Plug>(easymotion-prefix)e <Plug>(easymotion-e)
map <silent> <Plug>(easymotion-prefix)B <Plug>(easymotion-B)
map <silent> <Plug>(easymotion-prefix)W <Plug>(easymotion-W)
map <silent> <Plug>(easymotion-prefix)T <Plug>(easymotion-T)
map <silent> <Plug>(easymotion-prefix)t <Plug>(easymotion-t)
map <silent> <Plug>(easymotion-prefix)s <Plug>(easymotion-s)
map <silent> <Plug>(easymotion-prefix)F <Plug>(easymotion-F)
map <silent> <Plug>(easymotion-prefix)f <Plug>(easymotion-f)
xnoremap <silent> <Plug>(easymotion-activate) :call EasyMotion#activate(1)
nnoremap <silent> <Plug>(easymotion-activate) :call EasyMotion#activate(0)
snoremap <silent> <Plug>(easymotion-activate) :call EasyMotion#activate(0)
onoremap <silent> <Plug>(easymotion-activate) :call EasyMotion#activate(0)
noremap <silent> <Plug>(easymotion-dotrepeat) :call EasyMotion#DotRepeat()
xnoremap <silent> <Plug>(easymotion-repeat) :call EasyMotion#Repeat(1)
nnoremap <silent> <Plug>(easymotion-repeat) :call EasyMotion#Repeat(0)
snoremap <silent> <Plug>(easymotion-repeat) :call EasyMotion#Repeat(0)
onoremap <silent> <Plug>(easymotion-repeat) :call EasyMotion#Repeat(0)
xnoremap <silent> <Plug>(easymotion-prev) :call EasyMotion#NextPrevious(1,1)
nnoremap <silent> <Plug>(easymotion-prev) :call EasyMotion#NextPrevious(0,1)
snoremap <silent> <Plug>(easymotion-prev) :call EasyMotion#NextPrevious(0,1)
onoremap <silent> <Plug>(easymotion-prev) :call EasyMotion#NextPrevious(0,1)
xnoremap <silent> <Plug>(easymotion-next) :call EasyMotion#NextPrevious(1,0)
nnoremap <silent> <Plug>(easymotion-next) :call EasyMotion#NextPrevious(0,0)
snoremap <silent> <Plug>(easymotion-next) :call EasyMotion#NextPrevious(0,0)
onoremap <silent> <Plug>(easymotion-next) :call EasyMotion#NextPrevious(0,0)
xnoremap <silent> <Plug>(easymotion-wl) :call EasyMotion#WBL(1,0)
nnoremap <silent> <Plug>(easymotion-wl) :call EasyMotion#WBL(0,0)
snoremap <silent> <Plug>(easymotion-wl) :call EasyMotion#WBL(0,0)
onoremap <silent> <Plug>(easymotion-wl) :call EasyMotion#WBL(0,0)
xnoremap <silent> <Plug>(easymotion-lineforward) :call EasyMotion#LineAnywhere(1,0)
nnoremap <silent> <Plug>(easymotion-lineforward) :call EasyMotion#LineAnywhere(0,0)
snoremap <silent> <Plug>(easymotion-lineforward) :call EasyMotion#LineAnywhere(0,0)
onoremap <silent> <Plug>(easymotion-lineforward) :call EasyMotion#LineAnywhere(0,0)
xnoremap <silent> <Plug>(easymotion-lineanywhere) :call EasyMotion#LineAnywhere(1,2)
nnoremap <silent> <Plug>(easymotion-lineanywhere) :call EasyMotion#LineAnywhere(0,2)
snoremap <silent> <Plug>(easymotion-lineanywhere) :call EasyMotion#LineAnywhere(0,2)
onoremap <silent> <Plug>(easymotion-lineanywhere) :call EasyMotion#LineAnywhere(0,2)
xnoremap <silent> <Plug>(easymotion-bd-wl) :call EasyMotion#WBL(1,2)
nnoremap <silent> <Plug>(easymotion-bd-wl) :call EasyMotion#WBL(0,2)
snoremap <silent> <Plug>(easymotion-bd-wl) :call EasyMotion#WBL(0,2)
onoremap <silent> <Plug>(easymotion-bd-wl) :call EasyMotion#WBL(0,2)
xnoremap <silent> <Plug>(easymotion-linebackward) :call EasyMotion#LineAnywhere(1,1)
nnoremap <silent> <Plug>(easymotion-linebackward) :call EasyMotion#LineAnywhere(0,1)
snoremap <silent> <Plug>(easymotion-linebackward) :call EasyMotion#LineAnywhere(0,1)
onoremap <silent> <Plug>(easymotion-linebackward) :call EasyMotion#LineAnywhere(0,1)
xnoremap <silent> <Plug>(easymotion-bl) :call EasyMotion#WBL(1,1)
nnoremap <silent> <Plug>(easymotion-bl) :call EasyMotion#WBL(0,1)
snoremap <silent> <Plug>(easymotion-bl) :call EasyMotion#WBL(0,1)
onoremap <silent> <Plug>(easymotion-bl) :call EasyMotion#WBL(0,1)
xnoremap <silent> <Plug>(easymotion-el) :call EasyMotion#EL(1,0)
nnoremap <silent> <Plug>(easymotion-el) :call EasyMotion#EL(0,0)
snoremap <silent> <Plug>(easymotion-el) :call EasyMotion#EL(0,0)
onoremap <silent> <Plug>(easymotion-el) :call EasyMotion#EL(0,0)
xnoremap <silent> <Plug>(easymotion-gel) :call EasyMotion#EL(1,1)
nnoremap <silent> <Plug>(easymotion-gel) :call EasyMotion#EL(0,1)
snoremap <silent> <Plug>(easymotion-gel) :call EasyMotion#EL(0,1)
onoremap <silent> <Plug>(easymotion-gel) :call EasyMotion#EL(0,1)
xnoremap <silent> <Plug>(easymotion-bd-el) :call EasyMotion#EL(1,2)
nnoremap <silent> <Plug>(easymotion-bd-el) :call EasyMotion#EL(0,2)
snoremap <silent> <Plug>(easymotion-bd-el) :call EasyMotion#EL(0,2)
onoremap <silent> <Plug>(easymotion-bd-el) :call EasyMotion#EL(0,2)
xnoremap <silent> <Plug>(easymotion-jumptoanywhere) :call EasyMotion#JumpToAnywhere(1,2)
nnoremap <silent> <Plug>(easymotion-jumptoanywhere) :call EasyMotion#JumpToAnywhere(0,2)
snoremap <silent> <Plug>(easymotion-jumptoanywhere) :call EasyMotion#JumpToAnywhere(0,2)
onoremap <silent> <Plug>(easymotion-jumptoanywhere) :call EasyMotion#JumpToAnywhere(0,2)
xnoremap <silent> <Plug>(easymotion-vim-n) :call EasyMotion#Search(1,0,1)
nnoremap <silent> <Plug>(easymotion-vim-n) :call EasyMotion#Search(0,0,1)
snoremap <silent> <Plug>(easymotion-vim-n) :call EasyMotion#Search(0,0,1)
onoremap <silent> <Plug>(easymotion-vim-n) :call EasyMotion#Search(0,0,1)
xnoremap <silent> <Plug>(easymotion-n) :call EasyMotion#Search(1,0,0)
nnoremap <silent> <Plug>(easymotion-n) :call EasyMotion#Search(0,0,0)
snoremap <silent> <Plug>(easymotion-n) :call EasyMotion#Search(0,0,0)
onoremap <silent> <Plug>(easymotion-n) :call EasyMotion#Search(0,0,0)
xnoremap <silent> <Plug>(easymotion-bd-n) :call EasyMotion#Search(1,2,0)
nnoremap <silent> <Plug>(easymotion-bd-n) :call EasyMotion#Search(0,2,0)
snoremap <silent> <Plug>(easymotion-bd-n) :call EasyMotion#Search(0,2,0)
onoremap <silent> <Plug>(easymotion-bd-n) :call EasyMotion#Search(0,2,0)
xnoremap <silent> <Plug>(easymotion-vim-N) :call EasyMotion#Search(1,1,1)
nnoremap <silent> <Plug>(easymotion-vim-N) :call EasyMotion#Search(0,1,1)
snoremap <silent> <Plug>(easymotion-vim-N) :call EasyMotion#Search(0,1,1)
onoremap <silent> <Plug>(easymotion-vim-N) :call EasyMotion#Search(0,1,1)
xnoremap <silent> <Plug>(easymotion-N) :call EasyMotion#Search(1,1,0)
nnoremap <silent> <Plug>(easymotion-N) :call EasyMotion#Search(0,1,0)
snoremap <silent> <Plug>(easymotion-N) :call EasyMotion#Search(0,1,0)
onoremap <silent> <Plug>(easymotion-N) :call EasyMotion#Search(0,1,0)
xnoremap <silent> <Plug>(easymotion-eol-j) :call EasyMotion#Eol(1,0)
nnoremap <silent> <Plug>(easymotion-eol-j) :call EasyMotion#Eol(0,0)
snoremap <silent> <Plug>(easymotion-eol-j) :call EasyMotion#Eol(0,0)
onoremap <silent> <Plug>(easymotion-eol-j) :call EasyMotion#Eol(0,0)
xnoremap <silent> <Plug>(easymotion-sol-k) :call EasyMotion#Sol(1,1)
nnoremap <silent> <Plug>(easymotion-sol-k) :call EasyMotion#Sol(0,1)
snoremap <silent> <Plug>(easymotion-sol-k) :call EasyMotion#Sol(0,1)
onoremap <silent> <Plug>(easymotion-sol-k) :call EasyMotion#Sol(0,1)
xnoremap <silent> <Plug>(easymotion-sol-j) :call EasyMotion#Sol(1,0)
nnoremap <silent> <Plug>(easymotion-sol-j) :call EasyMotion#Sol(0,0)
snoremap <silent> <Plug>(easymotion-sol-j) :call EasyMotion#Sol(0,0)
onoremap <silent> <Plug>(easymotion-sol-j) :call EasyMotion#Sol(0,0)
xnoremap <silent> <Plug>(easymotion-k) :call EasyMotion#JK(1,1)
nnoremap <silent> <Plug>(easymotion-k) :call EasyMotion#JK(0,1)
snoremap <silent> <Plug>(easymotion-k) :call EasyMotion#JK(0,1)
onoremap <silent> <Plug>(easymotion-k) :call EasyMotion#JK(0,1)
xnoremap <silent> <Plug>(easymotion-j) :call EasyMotion#JK(1,0)
nnoremap <silent> <Plug>(easymotion-j) :call EasyMotion#JK(0,0)
snoremap <silent> <Plug>(easymotion-j) :call EasyMotion#JK(0,0)
onoremap <silent> <Plug>(easymotion-j) :call EasyMotion#JK(0,0)
xnoremap <silent> <Plug>(easymotion-bd-jk) :call EasyMotion#JK(1,2)
nnoremap <silent> <Plug>(easymotion-bd-jk) :call EasyMotion#JK(0,2)
snoremap <silent> <Plug>(easymotion-bd-jk) :call EasyMotion#JK(0,2)
onoremap <silent> <Plug>(easymotion-bd-jk) :call EasyMotion#JK(0,2)
xnoremap <silent> <Plug>(easymotion-eol-bd-jk) :call EasyMotion#Eol(1,2)
nnoremap <silent> <Plug>(easymotion-eol-bd-jk) :call EasyMotion#Eol(0,2)
snoremap <silent> <Plug>(easymotion-eol-bd-jk) :call EasyMotion#Eol(0,2)
onoremap <silent> <Plug>(easymotion-eol-bd-jk) :call EasyMotion#Eol(0,2)
xnoremap <silent> <Plug>(easymotion-sol-bd-jk) :call EasyMotion#Sol(1,2)
nnoremap <silent> <Plug>(easymotion-sol-bd-jk) :call EasyMotion#Sol(0,2)
snoremap <silent> <Plug>(easymotion-sol-bd-jk) :call EasyMotion#Sol(0,2)
onoremap <silent> <Plug>(easymotion-sol-bd-jk) :call EasyMotion#Sol(0,2)
xnoremap <silent> <Plug>(easymotion-eol-k) :call EasyMotion#Eol(1,1)
nnoremap <silent> <Plug>(easymotion-eol-k) :call EasyMotion#Eol(0,1)
snoremap <silent> <Plug>(easymotion-eol-k) :call EasyMotion#Eol(0,1)
onoremap <silent> <Plug>(easymotion-eol-k) :call EasyMotion#Eol(0,1)
xnoremap <silent> <Plug>(easymotion-iskeyword-ge) :call EasyMotion#EK(1,1)
nnoremap <silent> <Plug>(easymotion-iskeyword-ge) :call EasyMotion#EK(0,1)
snoremap <silent> <Plug>(easymotion-iskeyword-ge) :call EasyMotion#EK(0,1)
onoremap <silent> <Plug>(easymotion-iskeyword-ge) :call EasyMotion#EK(0,1)
xnoremap <silent> <Plug>(easymotion-w) :call EasyMotion#WB(1,0)
nnoremap <silent> <Plug>(easymotion-w) :call EasyMotion#WB(0,0)
snoremap <silent> <Plug>(easymotion-w) :call EasyMotion#WB(0,0)
onoremap <silent> <Plug>(easymotion-w) :call EasyMotion#WB(0,0)
xnoremap <silent> <Plug>(easymotion-bd-W) :call EasyMotion#WBW(1,2)
nnoremap <silent> <Plug>(easymotion-bd-W) :call EasyMotion#WBW(0,2)
snoremap <silent> <Plug>(easymotion-bd-W) :call EasyMotion#WBW(0,2)
onoremap <silent> <Plug>(easymotion-bd-W) :call EasyMotion#WBW(0,2)
xnoremap <silent> <Plug>(easymotion-iskeyword-w) :call EasyMotion#WBK(1,0)
nnoremap <silent> <Plug>(easymotion-iskeyword-w) :call EasyMotion#WBK(0,0)
snoremap <silent> <Plug>(easymotion-iskeyword-w) :call EasyMotion#WBK(0,0)
onoremap <silent> <Plug>(easymotion-iskeyword-w) :call EasyMotion#WBK(0,0)
xnoremap <silent> <Plug>(easymotion-gE) :call EasyMotion#EW(1,1)
nnoremap <silent> <Plug>(easymotion-gE) :call EasyMotion#EW(0,1)
snoremap <silent> <Plug>(easymotion-gE) :call EasyMotion#EW(0,1)
onoremap <silent> <Plug>(easymotion-gE) :call EasyMotion#EW(0,1)
xnoremap <silent> <Plug>(easymotion-e) :call EasyMotion#E(1,0)
nnoremap <silent> <Plug>(easymotion-e) :call EasyMotion#E(0,0)
snoremap <silent> <Plug>(easymotion-e) :call EasyMotion#E(0,0)
onoremap <silent> <Plug>(easymotion-e) :call EasyMotion#E(0,0)
xnoremap <silent> <Plug>(easymotion-bd-E) :call EasyMotion#EW(1,2)
nnoremap <silent> <Plug>(easymotion-bd-E) :call EasyMotion#EW(0,2)
snoremap <silent> <Plug>(easymotion-bd-E) :call EasyMotion#EW(0,2)
onoremap <silent> <Plug>(easymotion-bd-E) :call EasyMotion#EW(0,2)
xnoremap <silent> <Plug>(easymotion-iskeyword-e) :call EasyMotion#EK(1,0)
nnoremap <silent> <Plug>(easymotion-iskeyword-e) :call EasyMotion#EK(0,0)
snoremap <silent> <Plug>(easymotion-iskeyword-e) :call EasyMotion#EK(0,0)
onoremap <silent> <Plug>(easymotion-iskeyword-e) :call EasyMotion#EK(0,0)
xnoremap <silent> <Plug>(easymotion-b) :call EasyMotion#WB(1,1)
nnoremap <silent> <Plug>(easymotion-b) :call EasyMotion#WB(0,1)
snoremap <silent> <Plug>(easymotion-b) :call EasyMotion#WB(0,1)
onoremap <silent> <Plug>(easymotion-b) :call EasyMotion#WB(0,1)
xnoremap <silent> <Plug>(easymotion-iskeyword-b) :call EasyMotion#WBK(1,1)
nnoremap <silent> <Plug>(easymotion-iskeyword-b) :call EasyMotion#WBK(0,1)
snoremap <silent> <Plug>(easymotion-iskeyword-b) :call EasyMotion#WBK(0,1)
onoremap <silent> <Plug>(easymotion-iskeyword-b) :call EasyMotion#WBK(0,1)
xnoremap <silent> <Plug>(easymotion-iskeyword-bd-w) :call EasyMotion#WBK(1,2)
nnoremap <silent> <Plug>(easymotion-iskeyword-bd-w) :call EasyMotion#WBK(0,2)
snoremap <silent> <Plug>(easymotion-iskeyword-bd-w) :call EasyMotion#WBK(0,2)
onoremap <silent> <Plug>(easymotion-iskeyword-bd-w) :call EasyMotion#WBK(0,2)
xnoremap <silent> <Plug>(easymotion-W) :call EasyMotion#WBW(1,0)
nnoremap <silent> <Plug>(easymotion-W) :call EasyMotion#WBW(0,0)
snoremap <silent> <Plug>(easymotion-W) :call EasyMotion#WBW(0,0)
onoremap <silent> <Plug>(easymotion-W) :call EasyMotion#WBW(0,0)
xnoremap <silent> <Plug>(easymotion-bd-w) :call EasyMotion#WB(1,2)
nnoremap <silent> <Plug>(easymotion-bd-w) :call EasyMotion#WB(0,2)
snoremap <silent> <Plug>(easymotion-bd-w) :call EasyMotion#WB(0,2)
onoremap <silent> <Plug>(easymotion-bd-w) :call EasyMotion#WB(0,2)
xnoremap <silent> <Plug>(easymotion-iskeyword-bd-e) :call EasyMotion#EK(1,2)
nnoremap <silent> <Plug>(easymotion-iskeyword-bd-e) :call EasyMotion#EK(0,2)
snoremap <silent> <Plug>(easymotion-iskeyword-bd-e) :call EasyMotion#EK(0,2)
onoremap <silent> <Plug>(easymotion-iskeyword-bd-e) :call EasyMotion#EK(0,2)
xnoremap <silent> <Plug>(easymotion-ge) :call EasyMotion#E(1,1)
nnoremap <silent> <Plug>(easymotion-ge) :call EasyMotion#E(0,1)
snoremap <silent> <Plug>(easymotion-ge) :call EasyMotion#E(0,1)
onoremap <silent> <Plug>(easymotion-ge) :call EasyMotion#E(0,1)
xnoremap <silent> <Plug>(easymotion-E) :call EasyMotion#EW(1,0)
nnoremap <silent> <Plug>(easymotion-E) :call EasyMotion#EW(0,0)
snoremap <silent> <Plug>(easymotion-E) :call EasyMotion#EW(0,0)
onoremap <silent> <Plug>(easymotion-E) :call EasyMotion#EW(0,0)
xnoremap <silent> <Plug>(easymotion-bd-e) :call EasyMotion#E(1,2)
nnoremap <silent> <Plug>(easymotion-bd-e) :call EasyMotion#E(0,2)
snoremap <silent> <Plug>(easymotion-bd-e) :call EasyMotion#E(0,2)
onoremap <silent> <Plug>(easymotion-bd-e) :call EasyMotion#E(0,2)
xnoremap <silent> <Plug>(easymotion-B) :call EasyMotion#WBW(1,1)
nnoremap <silent> <Plug>(easymotion-B) :call EasyMotion#WBW(0,1)
snoremap <silent> <Plug>(easymotion-B) :call EasyMotion#WBW(0,1)
onoremap <silent> <Plug>(easymotion-B) :call EasyMotion#WBW(0,1)
nnoremap <silent> <Plug>(easymotion-overwin-w) :call EasyMotion#overwin#w()
nnoremap <silent> <Plug>(easymotion-overwin-line) :call EasyMotion#overwin#line()
nnoremap <silent> <Plug>(easymotion-overwin-f2) :call EasyMotion#OverwinF(2)
nnoremap <silent> <Plug>(easymotion-overwin-f) :call EasyMotion#OverwinF(1)
xnoremap <silent> <Plug>(easymotion-Tln) :call EasyMotion#TL(-1,1,1)
nnoremap <silent> <Plug>(easymotion-Tln) :call EasyMotion#TL(-1,0,1)
snoremap <silent> <Plug>(easymotion-Tln) :call EasyMotion#TL(-1,0,1)
onoremap <silent> <Plug>(easymotion-Tln) :call EasyMotion#TL(-1,0,1)
xnoremap <silent> <Plug>(easymotion-t2) :call EasyMotion#T(2,1,0)
nnoremap <silent> <Plug>(easymotion-t2) :call EasyMotion#T(2,0,0)
snoremap <silent> <Plug>(easymotion-t2) :call EasyMotion#T(2,0,0)
onoremap <silent> <Plug>(easymotion-t2) :call EasyMotion#T(2,0,0)
xnoremap <silent> <Plug>(easymotion-t) :call EasyMotion#T(1,1,0)
nnoremap <silent> <Plug>(easymotion-t) :call EasyMotion#T(1,0,0)
snoremap <silent> <Plug>(easymotion-t) :call EasyMotion#T(1,0,0)
onoremap <silent> <Plug>(easymotion-t) :call EasyMotion#T(1,0,0)
xnoremap <silent> <Plug>(easymotion-s) :call EasyMotion#S(1,1,2)
nnoremap <silent> <Plug>(easymotion-s) :call EasyMotion#S(1,0,2)
snoremap <silent> <Plug>(easymotion-s) :call EasyMotion#S(1,0,2)
onoremap <silent> <Plug>(easymotion-s) :call EasyMotion#S(1,0,2)
xnoremap <silent> <Plug>(easymotion-tn) :call EasyMotion#T(-1,1,0)
nnoremap <silent> <Plug>(easymotion-tn) :call EasyMotion#T(-1,0,0)
snoremap <silent> <Plug>(easymotion-tn) :call EasyMotion#T(-1,0,0)
onoremap <silent> <Plug>(easymotion-tn) :call EasyMotion#T(-1,0,0)
xnoremap <silent> <Plug>(easymotion-bd-t2) :call EasyMotion#T(2,1,2)
nnoremap <silent> <Plug>(easymotion-bd-t2) :call EasyMotion#T(2,0,2)
snoremap <silent> <Plug>(easymotion-bd-t2) :call EasyMotion#T(2,0,2)
onoremap <silent> <Plug>(easymotion-bd-t2) :call EasyMotion#T(2,0,2)
xnoremap <silent> <Plug>(easymotion-tl) :call EasyMotion#TL(1,1,0)
nnoremap <silent> <Plug>(easymotion-tl) :call EasyMotion#TL(1,0,0)
snoremap <silent> <Plug>(easymotion-tl) :call EasyMotion#TL(1,0,0)
onoremap <silent> <Plug>(easymotion-tl) :call EasyMotion#TL(1,0,0)
xnoremap <silent> <Plug>(easymotion-bd-tn) :call EasyMotion#T(-1,1,2)
nnoremap <silent> <Plug>(easymotion-bd-tn) :call EasyMotion#T(-1,0,2)
snoremap <silent> <Plug>(easymotion-bd-tn) :call EasyMotion#T(-1,0,2)
onoremap <silent> <Plug>(easymotion-bd-tn) :call EasyMotion#T(-1,0,2)
xnoremap <silent> <Plug>(easymotion-fn) :call EasyMotion#S(-1,1,0)
nnoremap <silent> <Plug>(easymotion-fn) :call EasyMotion#S(-1,0,0)
snoremap <silent> <Plug>(easymotion-fn) :call EasyMotion#S(-1,0,0)
onoremap <silent> <Plug>(easymotion-fn) :call EasyMotion#S(-1,0,0)
xnoremap <silent> <Plug>(easymotion-bd-tl) :call EasyMotion#TL(1,1,2)
nnoremap <silent> <Plug>(easymotion-bd-tl) :call EasyMotion#TL(1,0,2)
snoremap <silent> <Plug>(easymotion-bd-tl) :call EasyMotion#TL(1,0,2)
onoremap <silent> <Plug>(easymotion-bd-tl) :call EasyMotion#TL(1,0,2)
xnoremap <silent> <Plug>(easymotion-fl) :call EasyMotion#SL(1,1,0)
nnoremap <silent> <Plug>(easymotion-fl) :call EasyMotion#SL(1,0,0)
snoremap <silent> <Plug>(easymotion-fl) :call EasyMotion#SL(1,0,0)
onoremap <silent> <Plug>(easymotion-fl) :call EasyMotion#SL(1,0,0)
xnoremap <silent> <Plug>(easymotion-bd-tl2) :call EasyMotion#TL(2,1,2)
nnoremap <silent> <Plug>(easymotion-bd-tl2) :call EasyMotion#TL(2,0,2)
snoremap <silent> <Plug>(easymotion-bd-tl2) :call EasyMotion#TL(2,0,2)
onoremap <silent> <Plug>(easymotion-bd-tl2) :call EasyMotion#TL(2,0,2)
xnoremap <silent> <Plug>(easymotion-bd-fn) :call EasyMotion#S(-1,1,2)
nnoremap <silent> <Plug>(easymotion-bd-fn) :call EasyMotion#S(-1,0,2)
snoremap <silent> <Plug>(easymotion-bd-fn) :call EasyMotion#S(-1,0,2)
onoremap <silent> <Plug>(easymotion-bd-fn) :call EasyMotion#S(-1,0,2)
xnoremap <silent> <Plug>(easymotion-f) :call EasyMotion#S(1,1,0)
nnoremap <silent> <Plug>(easymotion-f) :call EasyMotion#S(1,0,0)
snoremap <silent> <Plug>(easymotion-f) :call EasyMotion#S(1,0,0)
onoremap <silent> <Plug>(easymotion-f) :call EasyMotion#S(1,0,0)
xnoremap <silent> <Plug>(easymotion-bd-fl) :call EasyMotion#SL(1,1,2)
nnoremap <silent> <Plug>(easymotion-bd-fl) :call EasyMotion#SL(1,0,2)
snoremap <silent> <Plug>(easymotion-bd-fl) :call EasyMotion#SL(1,0,2)
onoremap <silent> <Plug>(easymotion-bd-fl) :call EasyMotion#SL(1,0,2)
xnoremap <silent> <Plug>(easymotion-Fl2) :call EasyMotion#SL(2,1,1)
nnoremap <silent> <Plug>(easymotion-Fl2) :call EasyMotion#SL(2,0,1)
snoremap <silent> <Plug>(easymotion-Fl2) :call EasyMotion#SL(2,0,1)
onoremap <silent> <Plug>(easymotion-Fl2) :call EasyMotion#SL(2,0,1)
xnoremap <silent> <Plug>(easymotion-tl2) :call EasyMotion#TL(2,1,0)
nnoremap <silent> <Plug>(easymotion-tl2) :call EasyMotion#TL(2,0,0)
snoremap <silent> <Plug>(easymotion-tl2) :call EasyMotion#TL(2,0,0)
onoremap <silent> <Plug>(easymotion-tl2) :call EasyMotion#TL(2,0,0)
xnoremap <silent> <Plug>(easymotion-f2) :call EasyMotion#S(2,1,0)
nnoremap <silent> <Plug>(easymotion-f2) :call EasyMotion#S(2,0,0)
snoremap <silent> <Plug>(easymotion-f2) :call EasyMotion#S(2,0,0)
onoremap <silent> <Plug>(easymotion-f2) :call EasyMotion#S(2,0,0)
xnoremap <silent> <Plug>(easymotion-Fln) :call EasyMotion#SL(-1,1,1)
nnoremap <silent> <Plug>(easymotion-Fln) :call EasyMotion#SL(-1,0,1)
snoremap <silent> <Plug>(easymotion-Fln) :call EasyMotion#SL(-1,0,1)
onoremap <silent> <Plug>(easymotion-Fln) :call EasyMotion#SL(-1,0,1)
xnoremap <silent> <Plug>(easymotion-sln) :call EasyMotion#SL(-1,1,2)
nnoremap <silent> <Plug>(easymotion-sln) :call EasyMotion#SL(-1,0,2)
snoremap <silent> <Plug>(easymotion-sln) :call EasyMotion#SL(-1,0,2)
onoremap <silent> <Plug>(easymotion-sln) :call EasyMotion#SL(-1,0,2)
xnoremap <silent> <Plug>(easymotion-tln) :call EasyMotion#TL(-1,1,0)
nnoremap <silent> <Plug>(easymotion-tln) :call EasyMotion#TL(-1,0,0)
snoremap <silent> <Plug>(easymotion-tln) :call EasyMotion#TL(-1,0,0)
onoremap <silent> <Plug>(easymotion-tln) :call EasyMotion#TL(-1,0,0)
xnoremap <silent> <Plug>(easymotion-fl2) :call EasyMotion#SL(2,1,0)
nnoremap <silent> <Plug>(easymotion-fl2) :call EasyMotion#SL(2,0,0)
snoremap <silent> <Plug>(easymotion-fl2) :call EasyMotion#SL(2,0,0)
onoremap <silent> <Plug>(easymotion-fl2) :call EasyMotion#SL(2,0,0)
xnoremap <silent> <Plug>(easymotion-bd-fl2) :call EasyMotion#SL(2,1,2)
nnoremap <silent> <Plug>(easymotion-bd-fl2) :call EasyMotion#SL(2,0,2)
snoremap <silent> <Plug>(easymotion-bd-fl2) :call EasyMotion#SL(2,0,2)
onoremap <silent> <Plug>(easymotion-bd-fl2) :call EasyMotion#SL(2,0,2)
xnoremap <silent> <Plug>(easymotion-T2) :call EasyMotion#T(2,1,1)
nnoremap <silent> <Plug>(easymotion-T2) :call EasyMotion#T(2,0,1)
snoremap <silent> <Plug>(easymotion-T2) :call EasyMotion#T(2,0,1)
onoremap <silent> <Plug>(easymotion-T2) :call EasyMotion#T(2,0,1)
xnoremap <silent> <Plug>(easymotion-bd-tln) :call EasyMotion#TL(-1,1,2)
nnoremap <silent> <Plug>(easymotion-bd-tln) :call EasyMotion#TL(-1,0,2)
snoremap <silent> <Plug>(easymotion-bd-tln) :call EasyMotion#TL(-1,0,2)
onoremap <silent> <Plug>(easymotion-bd-tln) :call EasyMotion#TL(-1,0,2)
xnoremap <silent> <Plug>(easymotion-T) :call EasyMotion#T(1,1,1)
nnoremap <silent> <Plug>(easymotion-T) :call EasyMotion#T(1,0,1)
snoremap <silent> <Plug>(easymotion-T) :call EasyMotion#T(1,0,1)
onoremap <silent> <Plug>(easymotion-T) :call EasyMotion#T(1,0,1)
xnoremap <silent> <Plug>(easymotion-bd-t) :call EasyMotion#T(1,1,2)
nnoremap <silent> <Plug>(easymotion-bd-t) :call EasyMotion#T(1,0,2)
snoremap <silent> <Plug>(easymotion-bd-t) :call EasyMotion#T(1,0,2)
onoremap <silent> <Plug>(easymotion-bd-t) :call EasyMotion#T(1,0,2)
xnoremap <silent> <Plug>(easymotion-Tn) :call EasyMotion#T(-1,1,1)
nnoremap <silent> <Plug>(easymotion-Tn) :call EasyMotion#T(-1,0,1)
snoremap <silent> <Plug>(easymotion-Tn) :call EasyMotion#T(-1,0,1)
onoremap <silent> <Plug>(easymotion-Tn) :call EasyMotion#T(-1,0,1)
xnoremap <silent> <Plug>(easymotion-s2) :call EasyMotion#S(2,1,2)
nnoremap <silent> <Plug>(easymotion-s2) :call EasyMotion#S(2,0,2)
snoremap <silent> <Plug>(easymotion-s2) :call EasyMotion#S(2,0,2)
onoremap <silent> <Plug>(easymotion-s2) :call EasyMotion#S(2,0,2)
xnoremap <silent> <Plug>(easymotion-Tl) :call EasyMotion#TL(1,1,1)
nnoremap <silent> <Plug>(easymotion-Tl) :call EasyMotion#TL(1,0,1)
snoremap <silent> <Plug>(easymotion-Tl) :call EasyMotion#TL(1,0,1)
onoremap <silent> <Plug>(easymotion-Tl) :call EasyMotion#TL(1,0,1)
xnoremap <silent> <Plug>(easymotion-sn) :call EasyMotion#S(-1,1,2)
nnoremap <silent> <Plug>(easymotion-sn) :call EasyMotion#S(-1,0,2)
snoremap <silent> <Plug>(easymotion-sn) :call EasyMotion#S(-1,0,2)
onoremap <silent> <Plug>(easymotion-sn) :call EasyMotion#S(-1,0,2)
xnoremap <silent> <Plug>(easymotion-Fn) :call EasyMotion#S(-1,1,1)
nnoremap <silent> <Plug>(easymotion-Fn) :call EasyMotion#S(-1,0,1)
snoremap <silent> <Plug>(easymotion-Fn) :call EasyMotion#S(-1,0,1)
onoremap <silent> <Plug>(easymotion-Fn) :call EasyMotion#S(-1,0,1)
xnoremap <silent> <Plug>(easymotion-sl) :call EasyMotion#SL(1,1,2)
nnoremap <silent> <Plug>(easymotion-sl) :call EasyMotion#SL(1,0,2)
snoremap <silent> <Plug>(easymotion-sl) :call EasyMotion#SL(1,0,2)
onoremap <silent> <Plug>(easymotion-sl) :call EasyMotion#SL(1,0,2)
xnoremap <silent> <Plug>(easymotion-Fl) :call EasyMotion#SL(1,1,1)
nnoremap <silent> <Plug>(easymotion-Fl) :call EasyMotion#SL(1,0,1)
snoremap <silent> <Plug>(easymotion-Fl) :call EasyMotion#SL(1,0,1)
onoremap <silent> <Plug>(easymotion-Fl) :call EasyMotion#SL(1,0,1)
xnoremap <silent> <Plug>(easymotion-sl2) :call EasyMotion#SL(2,1,2)
nnoremap <silent> <Plug>(easymotion-sl2) :call EasyMotion#SL(2,0,2)
snoremap <silent> <Plug>(easymotion-sl2) :call EasyMotion#SL(2,0,2)
onoremap <silent> <Plug>(easymotion-sl2) :call EasyMotion#SL(2,0,2)
xnoremap <silent> <Plug>(easymotion-bd-fln) :call EasyMotion#SL(-1,1,2)
nnoremap <silent> <Plug>(easymotion-bd-fln) :call EasyMotion#SL(-1,0,2)
snoremap <silent> <Plug>(easymotion-bd-fln) :call EasyMotion#SL(-1,0,2)
onoremap <silent> <Plug>(easymotion-bd-fln) :call EasyMotion#SL(-1,0,2)
xnoremap <silent> <Plug>(easymotion-F) :call EasyMotion#S(1,1,1)
nnoremap <silent> <Plug>(easymotion-F) :call EasyMotion#S(1,0,1)
snoremap <silent> <Plug>(easymotion-F) :call EasyMotion#S(1,0,1)
onoremap <silent> <Plug>(easymotion-F) :call EasyMotion#S(1,0,1)
xnoremap <silent> <Plug>(easymotion-bd-f) :call EasyMotion#S(1,1,2)
nnoremap <silent> <Plug>(easymotion-bd-f) :call EasyMotion#S(1,0,2)
snoremap <silent> <Plug>(easymotion-bd-f) :call EasyMotion#S(1,0,2)
onoremap <silent> <Plug>(easymotion-bd-f) :call EasyMotion#S(1,0,2)
xnoremap <silent> <Plug>(easymotion-F2) :call EasyMotion#S(2,1,1)
nnoremap <silent> <Plug>(easymotion-F2) :call EasyMotion#S(2,0,1)
snoremap <silent> <Plug>(easymotion-F2) :call EasyMotion#S(2,0,1)
onoremap <silent> <Plug>(easymotion-F2) :call EasyMotion#S(2,0,1)
xnoremap <silent> <Plug>(easymotion-bd-f2) :call EasyMotion#S(2,1,2)
nnoremap <silent> <Plug>(easymotion-bd-f2) :call EasyMotion#S(2,0,2)
snoremap <silent> <Plug>(easymotion-bd-f2) :call EasyMotion#S(2,0,2)
onoremap <silent> <Plug>(easymotion-bd-f2) :call EasyMotion#S(2,0,2)
xnoremap <silent> <Plug>(easymotion-Tl2) :call EasyMotion#TL(2,1,1)
nnoremap <silent> <Plug>(easymotion-Tl2) :call EasyMotion#TL(2,0,1)
snoremap <silent> <Plug>(easymotion-Tl2) :call EasyMotion#TL(2,0,1)
onoremap <silent> <Plug>(easymotion-Tl2) :call EasyMotion#TL(2,0,1)
xnoremap <silent> <Plug>(easymotion-fln) :call EasyMotion#SL(-1,1,0)
nnoremap <silent> <Plug>(easymotion-fln) :call EasyMotion#SL(-1,0,0)
snoremap <silent> <Plug>(easymotion-fln) :call EasyMotion#SL(-1,0,0)
onoremap <silent> <Plug>(easymotion-fln) :call EasyMotion#SL(-1,0,0)
vnoremap <silent> <Plug>LeaderfGtagsGrep :=leaderf#Gtags#startCmdline(2, 1, 'g')
vnoremap <silent> <Plug>LeaderfGtagsSymbol :=leaderf#Gtags#startCmdline(2, 1, 's')
vnoremap <silent> <Plug>LeaderfGtagsReference :=leaderf#Gtags#startCmdline(2, 1, 'r')
vnoremap <silent> <Plug>LeaderfGtagsDefinition :=leaderf#Gtags#startCmdline(2, 1, 'd')
nnoremap <Plug>LeaderfGtagsGrep :=leaderf#Gtags#startCmdline(0, 1, 'g')
onoremap <Plug>LeaderfGtagsGrep :=leaderf#Gtags#startCmdline(0, 1, 'g')
nnoremap <Plug>LeaderfGtagsSymbol :=leaderf#Gtags#startCmdline(0, 1, 's')
onoremap <Plug>LeaderfGtagsSymbol :=leaderf#Gtags#startCmdline(0, 1, 's')
nnoremap <Plug>LeaderfGtagsReference :=leaderf#Gtags#startCmdline(0, 1, 'r')
onoremap <Plug>LeaderfGtagsReference :=leaderf#Gtags#startCmdline(0, 1, 'r')
nnoremap <Plug>LeaderfGtagsDefinition :=leaderf#Gtags#startCmdline(0, 1, 'd')
onoremap <Plug>LeaderfGtagsDefinition :=leaderf#Gtags#startCmdline(0, 1, 'd')
vnoremap <silent> <Plug>LeaderfRgBangVisualRegexBoundary :=leaderf#Rg#startCmdline(2, 1, 1, 1)
vnoremap <silent> <Plug>LeaderfRgBangVisualRegexNoBoundary :=leaderf#Rg#startCmdline(2, 1, 1, 0)
vnoremap <silent> <Plug>LeaderfRgBangVisualLiteralBoundary :=leaderf#Rg#startCmdline(2, 1, 0, 1)
vnoremap <silent> <Plug>LeaderfRgBangVisualLiteralNoBoundary :=leaderf#Rg#startCmdline(2, 1, 0, 0)
vnoremap <silent> <Plug>LeaderfRgVisualRegexBoundary :=leaderf#Rg#startCmdline(2, 0, 1, 1)
vnoremap <silent> <Plug>LeaderfRgVisualRegexNoBoundary :=leaderf#Rg#startCmdline(2, 0, 1, 0)
vnoremap <silent> <Plug>LeaderfRgVisualLiteralBoundary :=leaderf#Rg#startCmdline(2, 0, 0, 1)
vnoremap <silent> <Plug>LeaderfRgVisualLiteralNoBoundary :=leaderf#Rg#startCmdline(2, 0, 0, 0)
noremap <Plug>LeaderfRgWORDRegexBoundary :=leaderf#Rg#startCmdline(1, 0, 1, 1)
noremap <Plug>LeaderfRgWORDRegexNoBoundary :=leaderf#Rg#startCmdline(1, 0, 1, 0)
noremap <Plug>LeaderfRgWORDLiteralBoundary :=leaderf#Rg#startCmdline(1, 0, 0, 0)
noremap <Plug>LeaderfRgWORDLiteralNoBoundary :=leaderf#Rg#startCmdline(1, 0, 0, 0)
noremap <Plug>LeaderfRgBangCwordRegexBoundary :=leaderf#Rg#startCmdline(0, 1, 1, 1)
noremap <Plug>LeaderfRgBangCwordRegexNoBoundary :=leaderf#Rg#startCmdline(0, 1, 1, 0)
noremap <Plug>LeaderfRgBangCwordLiteralBoundary :=leaderf#Rg#startCmdline(0, 1, 0, 1)
noremap <Plug>LeaderfRgBangCwordLiteralNoBoundary :=leaderf#Rg#startCmdline(0, 1, 0, 0)
noremap <Plug>LeaderfRgCwordRegexBoundary :=leaderf#Rg#startCmdline(0, 0, 1, 1)
noremap <Plug>LeaderfRgCwordRegexNoBoundary :=leaderf#Rg#startCmdline(0, 0, 1, 0)
noremap <Plug>LeaderfRgCwordLiteralBoundary :=leaderf#Rg#startCmdline(0, 0, 0, 1)
noremap <Plug>LeaderfRgCwordLiteralNoBoundary :=leaderf#Rg#startCmdline(0, 0, 0, 0)
noremap <Plug>LeaderfRgPrompt :Leaderf rg -e 
noremap <silent> <Plug>LeaderfMruCwdFullScreen :Leaderf mru --fullScreen
noremap <silent> <Plug>LeaderfMruCwdRight :Leaderf mru --right
noremap <silent> <Plug>LeaderfMruCwdLeft :Leaderf mru --left
noremap <silent> <Plug>LeaderfMruCwdBottom :Leaderf mru --bottom
noremap <silent> <Plug>LeaderfMruCwdTop :Leaderf mru --top
noremap <silent> <Plug>LeaderfBufferFullScreen :Leaderf buffer --fullScreen
noremap <silent> <Plug>LeaderfBufferRight :Leaderf buffer --right
noremap <silent> <Plug>LeaderfBufferLeft :Leaderf buffer --left
noremap <silent> <Plug>LeaderfBufferBottom :Leaderf buffer --bottom
noremap <silent> <Plug>LeaderfBufferTop :Leaderf buffer --top
noremap <silent> <Plug>LeaderfFileFullScreen :Leaderf file --fullScreen
noremap <silent> <Plug>LeaderfFileRight :Leaderf file --right
noremap <silent> <Plug>LeaderfFileLeft :Leaderf file --left
noremap <silent> <Plug>LeaderfFileBottom :Leaderf file --bottom
noremap <silent> <Plug>LeaderfFileTop :Leaderf file --top
nnoremap <silent> <Plug>unimpairedTPNext :exe "p".(v:count ? v:count : "")."tnext"
nnoremap <silent> <Plug>unimpairedTPPrevious :exe "p".(v:count ? v:count : "")."tprevious"
nnoremap <silent> <Plug>(unimpaired-ptnext) :exe v:count1 . "ptnext"
nnoremap <silent> <Plug>(unimpaired-ptprevious) :exe v:count1 . "ptprevious"
nnoremap <silent> <Plug>unimpairedTLast :exe "".(v:count ? v:count : "")."tlast"
nnoremap <silent> <Plug>unimpairedTFirst :exe "".(v:count ? v:count : "")."tfirst"
nnoremap <silent> <Plug>unimpairedTNext :exe "".(v:count ? v:count : "")."tnext"
nnoremap <silent> <Plug>unimpairedTPrevious :exe "".(v:count ? v:count : "")."tprevious"
nnoremap <Plug>(unimpaired-tlast) :=v:count ? v:count . "trewind" : "tlast"
nnoremap <Plug>(unimpaired-tfirst) :=v:count ? v:count . "trewind" : "tfirst"
nnoremap <silent> <Plug>(unimpaired-tnext) :exe "".(v:count ? v:count : "")."tnext"
nnoremap <silent> <Plug>(unimpaired-tprevious) :exe "".(v:count ? v:count : "")."tprevious"
nnoremap <silent> <Plug>unimpairedQNFile :exe "".(v:count ? v:count : "")."cnfile"zv
nnoremap <silent> <Plug>unimpairedQPFile :exe "".(v:count ? v:count : "")."cpfile"zv
nnoremap <silent> <Plug>(unimpaired-cnfile) :exe "".(v:count ? v:count : "")."cnfile"zv
nnoremap <silent> <Plug>(unimpaired-cpfile) :exe "".(v:count ? v:count : "")."cpfile"zv
nnoremap <silent> <Plug>unimpairedQLast :exe "".(v:count ? v:count : "")."clast"zv
nnoremap <silent> <Plug>unimpairedQFirst :exe "".(v:count ? v:count : "")."cfirst"zv
nnoremap <silent> <Plug>unimpairedQNext :exe "".(v:count ? v:count : "")."cnext"zv
nnoremap <silent> <Plug>unimpairedQPrevious :exe "".(v:count ? v:count : "")."cprevious"zv
nnoremap <Plug>(unimpaired-clast) :=v:count ? v:count . "cc" : "clast"zv
nnoremap <Plug>(unimpaired-cfirst) :=v:count ? v:count . "cc" : "cfirst"zv
nnoremap <silent> <Plug>(unimpaired-cnext) :exe "".(v:count ? v:count : "")."cnext"zv
nnoremap <silent> <Plug>(unimpaired-cprevious) :exe "".(v:count ? v:count : "")."cprevious"zv
nnoremap <silent> <Plug>unimpairedLNFile :exe "".(v:count ? v:count : "")."lnfile"zv
nnoremap <silent> <Plug>unimpairedLPFile :exe "".(v:count ? v:count : "")."lpfile"zv
nnoremap <silent> <Plug>(unimpaired-lnfile) :exe "".(v:count ? v:count : "")."lnfile"zv
nnoremap <silent> <Plug>(unimpaired-lpfile) :exe "".(v:count ? v:count : "")."lpfile"zv
nnoremap <silent> <Plug>unimpairedLLast :exe "".(v:count ? v:count : "")."llast"zv
nnoremap <silent> <Plug>unimpairedLFirst :exe "".(v:count ? v:count : "")."lfirst"zv
nnoremap <silent> <Plug>unimpairedLNext :exe "".(v:count ? v:count : "")."lnext"zv
nnoremap <silent> <Plug>unimpairedLPrevious :exe "".(v:count ? v:count : "")."lprevious"zv
nnoremap <Plug>(unimpaired-llast) :=v:count ? v:count . "ll" : "llast"zv
nnoremap <Plug>(unimpaired-lfirst) :=v:count ? v:count . "ll" : "lfirst"zv
nnoremap <silent> <Plug>(unimpaired-lnext) :exe "".(v:count ? v:count : "")."lnext"zv
nnoremap <silent> <Plug>(unimpaired-lprevious) :exe "".(v:count ? v:count : "")."lprevious"zv
nnoremap <silent> <Plug>unimpairedBLast :exe "".(v:count ? v:count : "")."blast"
nnoremap <silent> <Plug>unimpairedBFirst :exe "".(v:count ? v:count : "")."bfirst"
nnoremap <silent> <Plug>unimpairedBNext :exe "".(v:count ? v:count : "")."bnext"
nnoremap <silent> <Plug>unimpairedBPrevious :exe "".(v:count ? v:count : "")."bprevious"
nnoremap <Plug>(unimpaired-blast) :=v:count ? v:count . "buffer" : "blast"
nnoremap <Plug>(unimpaired-bfirst) :=v:count ? v:count . "buffer" : "bfirst"
nnoremap <silent> <Plug>(unimpaired-bnext) :exe "".(v:count ? v:count : "")."bnext"
nnoremap <silent> <Plug>(unimpaired-bprevious) :exe "".(v:count ? v:count : "")."bprevious"
nnoremap <silent> <Plug>unimpairedALast :exe "".(v:count ? v:count : "")."last"
nnoremap <silent> <Plug>unimpairedAFirst :exe "".(v:count ? v:count : "")."first"
nnoremap <silent> <Plug>unimpairedANext :exe "".(v:count ? v:count : "")."next"
nnoremap <silent> <Plug>unimpairedAPrevious :exe "".(v:count ? v:count : "")."previous"
nnoremap <Plug>(unimpaired-last) :=v:count ? v:count . "argument" : "last"
nnoremap <Plug>(unimpaired-first) :=v:count ? v:count . "argument" : "first"
nnoremap <silent> <Plug>(unimpaired-next) :exe "".(v:count ? v:count : "")."next"
nnoremap <silent> <Plug>(unimpaired-previous) :exe "".(v:count ? v:count : "")."previous"
nnoremap <silent> <Plug>(ale_repeat_selection) :ALERepeatSelection
nnoremap <silent> <Plug>(ale_code_action) :ALECodeAction
nnoremap <silent> <Plug>(ale_filerename) :ALEFileRename
nnoremap <silent> <Plug>(ale_rename) :ALERename
nnoremap <silent> <Plug>(ale_import) :ALEImport
nnoremap <silent> <Plug>(ale_documentation) :ALEDocumentation
nnoremap <silent> <Plug>(ale_hover) :ALEHover
nnoremap <silent> <Plug>(ale_find_references) :ALEFindReferences
nnoremap <silent> <Plug>(ale_go_to_implementation_in_vsplit) :ALEGoToImplementation -vsplit
nnoremap <silent> <Plug>(ale_go_to_implementation_in_split) :ALEGoToImplementation -split
nnoremap <silent> <Plug>(ale_go_to_implementation_in_tab) :ALEGoToImplementation -tab
nnoremap <silent> <Plug>(ale_go_to_implementation) :ALEGoToImplementation
nnoremap <silent> <Plug>(ale_go_to_type_definition_in_vsplit) :ALEGoToTypeDefinition -vsplit
nnoremap <silent> <Plug>(ale_go_to_type_definition_in_split) :ALEGoToTypeDefinition -split
nnoremap <silent> <Plug>(ale_go_to_type_definition_in_tab) :ALEGoToTypeDefinition -tab
nnoremap <silent> <Plug>(ale_go_to_type_definition) :ALEGoToTypeDefinition
nnoremap <silent> <Plug>(ale_go_to_definition_in_vsplit) :ALEGoToDefinition -vsplit
nnoremap <silent> <Plug>(ale_go_to_definition_in_split) :ALEGoToDefinition -split
nnoremap <silent> <Plug>(ale_go_to_definition_in_tab) :ALEGoToDefinition -tab
nnoremap <silent> <Plug>(ale_go_to_definition) :ALEGoToDefinition
nnoremap <silent> <Plug>(ale_fix) :ALEFix
nnoremap <silent> <Plug>(ale_detail) :ALEDetail
nnoremap <silent> <Plug>(ale_lint) :ALELint
nnoremap <silent> <Plug>(ale_reset_buffer) :ALEResetBuffer
nnoremap <silent> <Plug>(ale_disable_buffer) :ALEDisableBuffer
nnoremap <silent> <Plug>(ale_enable_buffer) :ALEEnableBuffer
nnoremap <silent> <Plug>(ale_toggle_buffer) :ALEToggleBuffer
nnoremap <silent> <Plug>(ale_reset) :ALEReset
nnoremap <silent> <Plug>(ale_disable) :ALEDisable
nnoremap <silent> <Plug>(ale_enable) :ALEEnable
nnoremap <silent> <Plug>(ale_toggle) :ALEToggle
nnoremap <silent> <Plug>(ale_last) :ALELast
nnoremap <silent> <Plug>(ale_first) :ALEFirst
nnoremap <silent> <Plug>(ale_next_wrap_warning) :ALENext -wrap -warning
nnoremap <silent> <Plug>(ale_next_warning) :ALENext -warning
nnoremap <silent> <Plug>(ale_next_wrap_error) :ALENext -wrap -error
nnoremap <silent> <Plug>(ale_next_error) :ALENext -error
nnoremap <silent> <Plug>(ale_next_wrap) :ALENextWrap
nnoremap <silent> <Plug>(ale_next) :ALENext
nnoremap <silent> <Plug>(ale_previous_wrap_warning) :ALEPrevious -wrap -warning
nnoremap <silent> <Plug>(ale_previous_warning) :ALEPrevious -warning
nnoremap <silent> <Plug>(ale_previous_wrap_error) :ALEPrevious -wrap -error
nnoremap <silent> <Plug>(ale_previous_error) :ALEPrevious -error
nnoremap <silent> <Plug>(ale_previous_wrap) :ALEPreviousWrap
nnoremap <silent> <Plug>(ale_previous) :ALEPrevious
nnoremap <Plug>NERDCommenterAltDelims :call nerdcommenter#SwitchToAlternativeDelimiters(1)
xnoremap <silent> <Plug>NERDCommenterUncomment :call nerdcommenter#Comment("x", "Uncomment")
nnoremap <silent> <Plug>NERDCommenterUncomment :call nerdcommenter#Comment("n", "Uncomment")
xnoremap <silent> <Plug>NERDCommenterAlignBoth :call nerdcommenter#Comment("x", "AlignBoth")
nnoremap <silent> <Plug>NERDCommenterAlignBoth :call nerdcommenter#Comment("n", "AlignBoth")
xnoremap <silent> <Plug>NERDCommenterAlignLeft :call nerdcommenter#Comment("x", "AlignLeft")
nnoremap <silent> <Plug>NERDCommenterAlignLeft :call nerdcommenter#Comment("n", "AlignLeft")
nnoremap <silent> <Plug>NERDCommenterAppend :call nerdcommenter#Comment("n", "Append")
xnoremap <silent> <Plug>NERDCommenterYank :call nerdcommenter#Comment("x", "Yank")
nnoremap <silent> <Plug>NERDCommenterYank :call nerdcommenter#Comment("n", "Yank")
xnoremap <silent> <Plug>NERDCommenterSexy :call nerdcommenter#Comment("x", "Sexy")
nnoremap <silent> <Plug>NERDCommenterSexy :call nerdcommenter#Comment("n", "Sexy")
xnoremap <silent> <Plug>NERDCommenterInvert :call nerdcommenter#Comment("x", "Invert")
nnoremap <silent> <Plug>NERDCommenterInvert :call nerdcommenter#Comment("n", "Invert")
nnoremap <silent> <Plug>NERDCommenterToEOL :call nerdcommenter#Comment("n", "ToEOL")
xnoremap <silent> <Plug>NERDCommenterNested :call nerdcommenter#Comment("x", "Nested")
nnoremap <silent> <Plug>NERDCommenterNested :call nerdcommenter#Comment("n", "Nested")
xnoremap <silent> <Plug>NERDCommenterMinimal :call nerdcommenter#Comment("x", "Minimal")
nnoremap <silent> <Plug>NERDCommenterMinimal :call nerdcommenter#Comment("n", "Minimal")
xnoremap <silent> <Plug>NERDCommenterToggle :call nerdcommenter#Comment("x", "Toggle")
nnoremap <silent> <Plug>NERDCommenterToggle :call nerdcommenter#Comment("n", "Toggle")
xnoremap <silent> <Plug>NERDCommenterComment :call nerdcommenter#Comment("x", "Comment")
nnoremap <silent> <Plug>NERDCommenterComment :call nerdcommenter#Comment("n", "Comment")
nnoremap <silent> <Plug>(startify-open-buffers) :call startify#open_buffers()
nnoremap <Up>s :mksession! session.vim
nnoremap <Up><Up> :source session.vim
nnoremap <F3> :TagbarOpenAutoClose
noremap <C-B> :s/\v,([ ])@!/, /g
nnoremap <C-P> "+p
nnoremap <Up>l :call ZFVimIM_cloudLog()
nnoremap <Up>u :call ZFVimIM_upload()
noremap <Down> <Nop>
noremap <Down>t :terminal
noremap <Left> <Nop>
vnoremap <Right> <Nop>
onoremap <Right> <Nop>
noremap <Up> <Nop>
noremap <F2> :NERDTreeToggle
nnoremap <C-J> :call Tab_switch()
tnoremap <C-J> w:execute "res " . g:winheight
tnoremap <C-V> N?^>n
vnoremap <C-Y> "+y
nnoremap <C-N> :call Insert_line()i
inoremap  
inoremap <expr> 	 pumvisible() ? "\" : "\	"
cnoremap <NL> <Down>
cnoremap  <Up>
inoremap  f)x;
inoremap ;r =FunEx_roxygen()
inoremap ;ct =FunEx_md_title()<End>a
inoremap ;cr =FunEx_md_code()
inoremap ;cc =FunEx_md_comment()
inoremap <silent> ;j =Get_args(2)dF d1b<BS>=Fast_print()bF)
inoremap ;i =Get_args(1)=Iabbrev_echo()
inoremap ;f =Annotate_file()F`i
inoremap ;m =Annotate_reportHeading()
inoremap ;d =FunEx_as_description()ka
inoremap ;t =strftime("%Y-%m-%dT%H:%M:%S+00:00")
inoremap ;t3 ## {-}bi i
inoremap ;t2 ## {-}bi i
inoremap ;t1 # {-}bi i
inoremap <silent> <expr> ;, ZFVimIME_keymap_add_i()
inoremap <silent> <expr> ;: ZFVimIME_keymap_next_i()
inoremap <silent> <expr> ;; ZFVimIME_keymap_toggle_i()
inoremap <silent> <expr> ;. ZFVimIME_keymap_remove_i()
inoremap ;b dF_s_
inoremap ;q F xgi
inoremap ;u b~gi
inoremap ;x bxgi
inoremap `i ``i
inoremap `` ```{r}```ka#| 
inoremap `e ```{r eval = T, echo = F}```ka
inoremap `h ```{r eval = T, echo = F, results = "asis"}```kaautor()ko#| 
inoremap `f ```{r fig:call FigNum()a=g:rfig, eval = T, echo = F, fig.cap = ""}```ka
inoremap `t ```{r tab.id = "table:call TabNum()a=g:rtab", ft.keepnext = T}```ka
iabbr kbl knitr::kable(data, format = "markdown", caption = "")b
iabbr pba pbapply::pbapply
iabbr pbm pbapply::pbmapply
iabbr pbs pbapply::pbsapply
iabbr pbl pbapply::pblapply
iabbr asss assign("envir_meta", environment(), parent.env(environment()))
iabbr ffs function()
iabbr ff function() {}i?(
iabbr mda [annotation]: -----------------------------------------
iabbr ;;; assign("test", , .GlobalEnv)F,i
iabbr ii %in%
iabbr pp %>%
iabbr vv <-
iabbr fps - 图\@ref(fig:)注：bb
iabbr ldt <!---BLOCK_TOC{seq_id: 'tab'}--->
iabbr ldf <!---BLOCK_TOC{seq_id: 'fig'}--->
iabbr ldc <!---BLOCK_TOC--->
iabbr lds <!---BLOCK_LANDSCAPE_START---><!---BLOCK_LANDSCAPE_STOP--->k
iabbr rtb \@ref(tab:)F xf)
iabbr rfg \@ref(fig:)F xf)
iabbr htimg <center><img src="" width="100%"></center>^f"
iabbr ll \flushleft
iabbr rr \flushright
iabbr inccn \includegraphics{}
iabbr inccw \includegraphics[width=135mm]{}
iabbr incc \includegraphics[height=65mm]{}
iabbr txtc \textcolor{}{}b
iabbr mdcol. ::: {.col data-latex="{0.05\textwidth}"} :::bik
iabbr mdcol3 ::: {.col data-latex="{0.3\textwidth}"} :::bik
iabbr mdcol4 ::: {.col data-latex="{0.4\textwidth}"} :::bik
iabbr mdcol1 ::: {.col data-latex="{0.1\textwidth}"} :::bik
iabbr mdcol6 ::: {.col data-latex="{0.6\textwidth}"} :::bik
iabbr mdcol5 ::: {.col data-latex="{0.5\textwidth}"} :::bik
iabbr mdcols :::::: {.cols data-latex=""} ::::::bik
iabbr docd []{.deletion}bba
iabbr doci []{.insertion}bba
iabbr ttbl {@tbl:}{nolink=True}4ba
iabbr ffgr {@fig:}{nolink=True}4ba
iabbr mdc [citation]:
iabbr nsp &ensp;&ensp;
iabbr msp &emsp;&emsp;
iabbr mdi ## [introduction]
iabbr fgr \@ref(fig:)<Left>
iabbr stf ## @figure
iabbr ctae ## $start_________________________
iabbr ctas ## ^start_________________________
iabbr ctr ## ========== Run block ==========
iabbr spp ::: {.col data-latex="{0.02\textwidth}"}\hspace{1pt}:::
let &cpo=s:cpo_save
unlet s:cpo_save
set autoindent
set background=dark
set backspace=indent,eol,start
set completeopt=menuone
set cpoptions=aAceFsB
set display=truncate
set expandtab
set fileencodings=ucs-bom,utf-8,default,latin1
set guifont=Monospace\ 16
set guioptions=aegirLt
set helplang=en
set laststatus=2
set linespace=10
set omnifunc=CompleteR
set path=.,/usr/include,,,~/outline/**,~/MCnebula2/**,~/.vim/after/ftplugin/**
set printoptions=paper:a4
set ruler
set runtimepath=~/.vim,~/.vim/bundle/vim-fugitive,~/.vim/bundle/vim-airline,~/.vim/bundle/Vundle.vim,~/.vim/bundle/nerdtree,~/.vim/bundle/vim-startify,~/.vim/bundle/auto-pairs,~/.vim/bundle/vim-gotham,~/.vim/bundle/tabular,~/.vim/bundle/vimtex,~/.vim/bundle/nerdcommenter,~/.vim/bundle/YouCompleteMe,~/.vim/bundle/ale,~/.vim/bundle/Nvim-R,~/.vim/bundle/vim-unimpaired,~/.vim/bundle/vim-translator,~/.vim/bundle/tagbar,~/.vim/bundle/ZFVimIM,~/.vim/bundle/ZFVimJob,~/.vim/bundle/ZFVimIM_openapi,~/.vim/bundle/vim-anyfold,~/.vim/bundle/vim-floaterm,~/.vim/bundle/pandoc-complete,~/.vim/bundle/LeaderF,~/.vim/bundle/vim-easymotion,/var/lib/vim/addons,/etc/vim,/usr/share/vim/vimfiles,/usr/share/vim/vim82,/usr/share/vim/vimfiles/after,/etc/vim/after,/var/lib/vim/addons/after,~/.vim/after,~/.vim/bundle/Vundle.vim,~/.vim/bundle/vim-fugitive/after,~/.vim/bundle/vim-airline/after,~/.vim/bundle/Vundle.vim/after,~/.vim/bundle/nerdtree/after,~/.vim/bundle/vim-startify/after,~/.vim/bundle/auto-pairs/after,~/.vim/bundle/vim-gotham/after,~/.vim/bundle/tabular/after,~/.vim/bundle/vimtex/after,~/.vim/bundle/nerdcommenter/after,~/.vim/bundle/YouCompleteMe/after,~/.vim/bundle/ale/after,~/.vim/bundle/Nvim-R/after,~/.vim/bundle/vim-unimpaired/after,~/.vim/bundle/vim-translator/after,~/.vim/bundle/tagbar/after,~/.vim/bundle/ZFVimIM/after,~/.vim/bundle/ZFVimJob/after,~/.vim/bundle/ZFVimIM_openapi/after,~/.vim/bundle/vim-anyfold/after,~/.vim/bundle/vim-floaterm/after,~/.vim/bundle/pandoc-complete/after,~/.vim/bundle/LeaderF/after,~/.vim/bundle/vim-easymotion/after
set scrolloff=5
set sessionoptions=blank,buffers,curdir,folds,help,options,tabpages,winsize
set shiftwidth=2
set shortmess=filnxtToOSIc
set smartindent
set softtabstop=2
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.sty,.cls,.fdb_latexmk,.fls,.pdf,.synctex.gz
set switchbuf=useopen
set tabstop=2
set undoreload=0
set visualbell
set wildmode=longest,list
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/outline/lixiao/2023_07_07_eval
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
argglobal
%argdel
$argadd index.Rmd
set stal=2
tabnew
tabrewind
edit index.Rmd
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
argglobal
let s:cpo_save=&cpo
set cpo&vim
lnoremap <buffer> <silent> <expr> <BS> ZFVimIME_backspace("<BS>")
inoremap <buffer> <silent> <M-n> :call AutoPairsJump()a
inoremap <buffer> <silent> <expr> <M-p> AutoPairsToggle()
inoremap <buffer> <silent> <M-b> =AutoPairsBackInsert()
inoremap <buffer> <silent> <M-e> =AutoPairsFastWrap()
inoremap <buffer> <silent> <C-H> =AutoPairsDelete()
inoremap <buffer> <silent> <BS> =AutoPairsDelete()
inoremap <buffer> <silent> <M-'> =AutoPairsMoveCharacter('''')
inoremap <buffer> <silent> <M-"> =AutoPairsMoveCharacter('"')
inoremap <buffer> <silent> <M-}> =AutoPairsMoveCharacter('}')
inoremap <buffer> <silent> <M-{> =AutoPairsMoveCharacter('{')
inoremap <buffer> <silent> <M-]> =AutoPairsMoveCharacter(']')
inoremap <buffer> <silent> <M-[> =AutoPairsMoveCharacter('[')
inoremap <buffer> <silent> <M-)> =AutoPairsMoveCharacter(')')
inoremap <buffer> <silent> <M-(> =AutoPairsMoveCharacter('(')
inoremap <buffer> <silent> § =AutoPairsMoveCharacter('''')
inoremap <buffer> <silent> ¢ =AutoPairsMoveCharacter('"')
inoremap <buffer> <silent> © =AutoPairsMoveCharacter(')')
inoremap <buffer> <silent> ¨ =AutoPairsMoveCharacter('(')
inoremap <buffer> <silent> î :call AutoPairsJump()a
inoremap <buffer> <silent> <expr> ð AutoPairsToggle()
inoremap <buffer> <silent> â =AutoPairsBackInsert()
inoremap <buffer> <silent> å =AutoPairsFastWrap()
inoremap <buffer> <silent> ý =AutoPairsMoveCharacter('}')
inoremap <buffer> <silent> û =AutoPairsMoveCharacter('{')
inoremap <buffer> <silent> Ý =AutoPairsMoveCharacter(']')
inoremap <buffer> <silent> Û =AutoPairsMoveCharacter('[')
vnoremap <buffer> <silent> \kn :call RKnit()
vnoremap <buffer> <silent> \rd :call RSetWD()
vnoremap <buffer> <silent> \ko :call RMakeRmd("odt_document")
vnoremap <buffer> <silent> \kh :call RMakeRmd("html_document")
vnoremap <buffer> <silent> \kw :call RMakeRmd("word_document")
vnoremap <buffer> <silent> \kl :call RMakeRmd("beamer_presentation")
vnoremap <buffer> <silent> \kp :call RMakeRmd("pdf_document")
vnoremap <buffer> <silent> \ka :call RMakeRmd("all")
vnoremap <buffer> <silent> \kr :call RMakeRmd("default")
vnoremap <buffer> <silent> \r- :call RBrOpenCloseLs("C")
vnoremap <buffer> <silent> \r= :call RBrOpenCloseLs("O")
vnoremap <buffer> <silent> \ro :call RObjBrowser()
vnoremap <buffer> <silent> \rb :call RAction("plotsumm", "v")
vnoremap <buffer> <silent> \rg :call RAction("plot", "v")
vnoremap <buffer> <silent> \rs :call RAction("summary", "v")
vnoremap <buffer> <silent> \rh :call RAction("help")
vnoremap <buffer> <silent> \re :call RAction("example")
vnoremap <buffer> <silent> \ra :call RAction("args")
vnoremap <buffer> <silent> \td :call RAction("dputtab", "v")
vnoremap <buffer> <silent> \vh :call RAction("viewobj", "v", ", howto='above 7split', nrows=6")
vnoremap <buffer> <silent> \vv :call RAction("viewobj", "v", ", howto='vsplit'")
vnoremap <buffer> <silent> \vs :call RAction("viewobj", "v", ", howto='split'")
vnoremap <buffer> <silent> \rv :call RAction("viewobj", "v")
vnoremap <buffer> <silent> \rt :call RAction("str", "v")
vnoremap <buffer> <silent> \rn :call RAction("nvim.names", "v")
vnoremap <buffer> <silent> \rp :call RAction("print", "v")
vnoremap <buffer> <silent> \rm :call RClearAll()
vnoremap <buffer> <silent> \rr :call RClearConsole()
vnoremap <buffer> <silent> \rl :call g:SendCmdToR("ls()")
vnoremap <buffer> <silent> \o :call RWarningMsg("This command does not work over a selection of lines.")
vnoremap <buffer> <silent> \sa :call SendSelectionToR("echo", "down")
vnoremap <buffer> <silent> \sd :call SendSelectionToR("silent", "down")
vnoremap <buffer> <silent> \se :call SendSelectionToR("echo", "stay")
vnoremap <buffer> <silent> \ss :call SendSelectionToR("silent", "stay")
vnoremap <buffer> <silent> \fa :call SendFunctionToR("echo", "down")
vnoremap <buffer> <silent> \fd :call SendFunctionToR("silent", "down")
vnoremap <buffer> <silent> \fe :call SendFunctionToR("echo", "stay")
vnoremap <buffer> <silent> \ff :call SendFunctionToR("silent", "stay")
vnoremap <buffer> <silent> \rw :call RQuit('save')
vnoremap <buffer> <silent> \rq :call RQuit('nosave')
vnoremap <buffer> <silent> \rc :call StartR("custom")
vnoremap <buffer> <silent> \rf :call StartR("R")
nnoremap <buffer> <silent> \kn :call RKnit()
onoremap <buffer> <silent> \kn :call RKnit()
nnoremap <buffer> <silent> \rd :call RSetWD()
onoremap <buffer> <silent> \rd :call RSetWD()
nnoremap <buffer> <silent> \ko :call RMakeRmd("odt_document")
onoremap <buffer> <silent> \ko :call RMakeRmd("odt_document")
nnoremap <buffer> <silent> \kh :call RMakeRmd("html_document")
onoremap <buffer> <silent> \kh :call RMakeRmd("html_document")
nnoremap <buffer> <silent> \kw :call RMakeRmd("word_document")
onoremap <buffer> <silent> \kw :call RMakeRmd("word_document")
nnoremap <buffer> <silent> \kl :call RMakeRmd("beamer_presentation")
onoremap <buffer> <silent> \kl :call RMakeRmd("beamer_presentation")
nnoremap <buffer> <silent> \kp :call RMakeRmd("pdf_document")
onoremap <buffer> <silent> \kp :call RMakeRmd("pdf_document")
nnoremap <buffer> <silent> \ka :call RMakeRmd("all")
onoremap <buffer> <silent> \ka :call RMakeRmd("all")
nnoremap <buffer> <silent> \kr :call RMakeRmd("default")
onoremap <buffer> <silent> \kr :call RMakeRmd("default")
nnoremap <buffer> <silent> \r- :call RBrOpenCloseLs("C")
onoremap <buffer> <silent> \r- :call RBrOpenCloseLs("C")
nnoremap <buffer> <silent> \r= :call RBrOpenCloseLs("O")
onoremap <buffer> <silent> \r= :call RBrOpenCloseLs("O")
nnoremap <buffer> <silent> \ro :call RObjBrowser()
onoremap <buffer> <silent> \ro :call RObjBrowser()
nnoremap <buffer> <silent> \rb :call RAction("plotsumm")
onoremap <buffer> <silent> \rb :call RAction("plotsumm")
nnoremap <buffer> <silent> \rg :call RAction("plot")
onoremap <buffer> <silent> \rg :call RAction("plot")
nnoremap <buffer> <silent> \rs :call RAction("summary")
onoremap <buffer> <silent> \rs :call RAction("summary")
nnoremap <buffer> <silent> \rh :call RAction("help")
onoremap <buffer> <silent> \rh :call RAction("help")
nnoremap <buffer> <silent> \re :call RAction("example")
onoremap <buffer> <silent> \re :call RAction("example")
nnoremap <buffer> <silent> \ra :call RAction("args")
onoremap <buffer> <silent> \ra :call RAction("args")
nnoremap <buffer> <silent> \td :call RAction("dputtab")
onoremap <buffer> <silent> \td :call RAction("dputtab")
nnoremap <buffer> <silent> \vh :call RAction("viewobj", ", howto='above 7split', nrows=6")
onoremap <buffer> <silent> \vh :call RAction("viewobj", ", howto='above 7split', nrows=6")
nnoremap <buffer> <silent> \vv :call RAction("viewobj", ", howto='vsplit'")
onoremap <buffer> <silent> \vv :call RAction("viewobj", ", howto='vsplit'")
nnoremap <buffer> <silent> \vs :call RAction("viewobj", ", howto='split'")
onoremap <buffer> <silent> \vs :call RAction("viewobj", ", howto='split'")
nnoremap <buffer> <silent> \rv :call RAction("viewobj")
onoremap <buffer> <silent> \rv :call RAction("viewobj")
nnoremap <buffer> <silent> \rt :call RAction("str")
onoremap <buffer> <silent> \rt :call RAction("str")
nnoremap <buffer> <silent> \rn :call RAction("nvim.names")
onoremap <buffer> <silent> \rn :call RAction("nvim.names")
nnoremap <buffer> <silent> \rp :call RAction("print")
onoremap <buffer> <silent> \rp :call RAction("print")
nnoremap <buffer> <silent> \rm :call RClearAll()
onoremap <buffer> <silent> \rm :call RClearAll()
nnoremap <buffer> <silent> \rr :call RClearConsole()
onoremap <buffer> <silent> \rr :call RClearConsole()
nnoremap <buffer> <silent> \rl :call g:SendCmdToR("ls()")
onoremap <buffer> <silent> \rl :call g:SendCmdToR("ls()")
nnoremap <buffer> <silent> \o :call SendLineToRAndInsertOutput()0
onoremap <buffer> <silent> \o :call SendLineToRAndInsertOutput()0
nnoremap <buffer> <silent> \sa :call SendSelectionToR("echo", "down", "normal")
onoremap <buffer> <silent> \sa :call SendSelectionToR("echo", "down", "normal")
nnoremap <buffer> <silent> \sd :call SendSelectionToR("silent", "down", "normal")
onoremap <buffer> <silent> \sd :call SendSelectionToR("silent", "down", "normal")
nnoremap <buffer> <silent> \se :call SendSelectionToR("echo", "stay", "normal")
onoremap <buffer> <silent> \se :call SendSelectionToR("echo", "stay", "normal")
nnoremap <buffer> <silent> \ss :call SendSelectionToR("silent", "stay", "normal")
onoremap <buffer> <silent> \ss :call SendSelectionToR("silent", "stay", "normal")
nnoremap <buffer> <silent> \fa :call SendFunctionToR("echo", "down")
onoremap <buffer> <silent> \fa :call SendFunctionToR("echo", "down")
nnoremap <buffer> <silent> \fd :call SendFunctionToR("silent", "down")
onoremap <buffer> <silent> \fd :call SendFunctionToR("silent", "down")
nnoremap <buffer> <silent> \fe :call SendFunctionToR("echo", "stay")
onoremap <buffer> <silent> \fe :call SendFunctionToR("echo", "stay")
nnoremap <buffer> <silent> \ff :call SendFunctionToR("silent", "stay")
onoremap <buffer> <silent> \ff :call SendFunctionToR("silent", "stay")
nnoremap <buffer> <silent> \rw :call RQuit('save')
onoremap <buffer> <silent> \rw :call RQuit('save')
nnoremap <buffer> <silent> \rq :call RQuit('nosave')
onoremap <buffer> <silent> \rq :call RQuit('nosave')
nnoremap <buffer> <silent> \rc :call StartR("custom")
onoremap <buffer> <silent> \rc :call StartR("custom")
nnoremap <buffer> <silent> \rf :call StartR("R")
onoremap <buffer> <silent> \rf :call StartR("R")
noremap <buffer> <silent> \gN :call b:PreviousRChunk()
noremap <buffer> <silent> \gn :call b:NextRChunk()
noremap <buffer> <silent> \ca :call b:SendChunkToR("echo", "down")
noremap <buffer> <silent> \cd :call b:SendChunkToR("silent", "down")
noremap <buffer> <silent> \ce :call b:SendChunkToR("echo", "stay")
noremap <buffer> <silent> \cc :call b:SendChunkToR("silent", "stay")
noremap <buffer> <silent> \ud :call RAction("undebug")
noremap <buffer> <silent> \bg :call RAction("debug")
noremap <buffer> <silent> \r<Right> :call RSendPartOfLine("right", 0)
noremap <buffer> <silent> \r<Left> :call RSendPartOfLine("left", 0)
noremap <buffer> <silent> \m :set opfunc=SendMotionToRg@
noremap <buffer> <silent> \d :call SendLineToR("down")0
noremap <buffer> <silent> \l :call SendLineToR("stay")
noremap <buffer> <silent> \ch :call SendFHChunkToR()
noremap <buffer> <silent> \pa :call SendParagraphToR("echo", "down")
noremap <buffer> <silent> \pd :call SendParagraphToR("silent", "down")
noremap <buffer> <silent> \pe :call SendParagraphToR("echo", "stay")
noremap <buffer> <silent> \pp :call SendParagraphToR("silent", "stay")
vnoremap <buffer> <silent> \so :call SendSelectionToR("echo", "stay", "NewtabInsert")
noremap <buffer> <silent> \ba :call SendMBlockToR("echo", "down")
noremap <buffer> <silent> \bd :call SendMBlockToR("silent", "down")
noremap <buffer> <silent> \be :call SendMBlockToR("echo", "stay")
noremap <buffer> <silent> \bb :call SendMBlockToR("silent", "stay")
vnoremap <buffer> <silent> <Plug>RKnit :call RKnit()
vnoremap <buffer> <silent> <Plug>RSetwd :call RSetWD()
vnoremap <buffer> <silent> <Plug>RMakeODT :call RMakeRmd("odt_document")
vnoremap <buffer> <silent> <Plug>RMakeHTML :call RMakeRmd("html_document")
vnoremap <buffer> <silent> <Plug>RMakeWord :call RMakeRmd("word_document")
vnoremap <buffer> <silent> <Plug>RMakePDFKb :call RMakeRmd("beamer_presentation")
vnoremap <buffer> <silent> <Plug>RMakePDFK :call RMakeRmd("pdf_document")
vnoremap <buffer> <silent> <Plug>RMakeAll :call RMakeRmd("all")
vnoremap <buffer> <silent> <Plug>RMakeRmd :call RMakeRmd("default")
vnoremap <buffer> <silent> <Plug>RCloseLists :call RBrOpenCloseLs("C")
vnoremap <buffer> <silent> <Plug>ROpenLists :call RBrOpenCloseLs("O")
vnoremap <buffer> <silent> <Plug>RUpdateObjBrowser :call RObjBrowser()
vnoremap <buffer> <silent> <Plug>RSPlot :call RAction("plotsumm", "v")
vnoremap <buffer> <silent> <Plug>RPlot :call RAction("plot", "v")
vnoremap <buffer> <silent> <Plug>RSummary :call RAction("summary", "v")
vnoremap <buffer> <silent> <Plug>RHelp :call RAction("help")
vnoremap <buffer> <silent> <Plug>RShowEx :call RAction("example")
vnoremap <buffer> <silent> <Plug>RShowArgs :call RAction("args")
vnoremap <buffer> <silent> <Plug>RDputObj :call RAction("dputtab", "v")
vnoremap <buffer> <silent> <Plug>RViewDFa :call RAction("viewobj", "v", ", howto='above 7split', nrows=6")
vnoremap <buffer> <silent> <Plug>RViewDFv :call RAction("viewobj", "v", ", howto='vsplit'")
vnoremap <buffer> <silent> <Plug>RViewDFs :call RAction("viewobj", "v", ", howto='split'")
vnoremap <buffer> <silent> <Plug>RViewDF :call RAction("viewobj", "v")
vnoremap <buffer> <silent> <Plug>RObjectStr :call RAction("str", "v")
vnoremap <buffer> <silent> <Plug>RObjectNames :call RAction("nvim.names", "v")
vnoremap <buffer> <silent> <Plug>RObjectPr :call RAction("print", "v")
vnoremap <buffer> <silent> <Plug>RClearAll :call RClearAll()
vnoremap <buffer> <silent> <Plug>RClearConsole :call RClearConsole()
vnoremap <buffer> <silent> <Plug>RListSpace :call g:SendCmdToR("ls()")
vnoremap <buffer> <silent> <Plug>(RDSendLineAndInsertOutput) :call RWarningMsg("This command does not work over a selection of lines.")
vnoremap <buffer> <silent> <Plug>REDSendSelection :call SendSelectionToR("echo", "down")
vnoremap <buffer> <silent> <Plug>RDSendSelection :call SendSelectionToR("silent", "down")
vnoremap <buffer> <silent> <Plug>RESendSelection :call SendSelectionToR("echo", "stay")
vnoremap <buffer> <silent> <Plug>RSendSelection :call SendSelectionToR("silent", "stay")
vnoremap <buffer> <silent> <Plug>RDSendFunction :call SendFunctionToR("echo", "down")
nnoremap <buffer> <silent> <Plug>RDSendFunction :call SendFunctionToR("echo", "down")
onoremap <buffer> <silent> <Plug>RDSendFunction :call SendFunctionToR("echo", "down")
vnoremap <buffer> <silent> <Plug>RSendFunction :call SendFunctionToR("silent", "stay")
vnoremap <buffer> <silent> <Plug>RSaveClose :call RQuit('save')
vnoremap <buffer> <silent> <Plug>RClose :call RQuit('nosave')
vnoremap <buffer> <silent> <Plug>RCustomStart :call StartR("custom")
vnoremap <buffer> <silent> <Plug>RStart :call StartR("R")
nnoremap <buffer> <silent> <Plug>RKnit :call RKnit()
onoremap <buffer> <silent> <Plug>RKnit :call RKnit()
nnoremap <buffer> <silent> <Plug>RSetwd :call RSetWD()
onoremap <buffer> <silent> <Plug>RSetwd :call RSetWD()
nnoremap <buffer> <silent> <Plug>RMakeODT :call RMakeRmd("odt_document")
onoremap <buffer> <silent> <Plug>RMakeODT :call RMakeRmd("odt_document")
nnoremap <buffer> <silent> <Plug>RMakeHTML :call RMakeRmd("html_document")
onoremap <buffer> <silent> <Plug>RMakeHTML :call RMakeRmd("html_document")
nnoremap <buffer> <silent> <Plug>RMakeWord :call RMakeRmd("word_document")
onoremap <buffer> <silent> <Plug>RMakeWord :call RMakeRmd("word_document")
nnoremap <buffer> <silent> <Plug>RMakePDFKb :call RMakeRmd("beamer_presentation")
onoremap <buffer> <silent> <Plug>RMakePDFKb :call RMakeRmd("beamer_presentation")
nnoremap <buffer> <silent> <Plug>RMakePDFK :call RMakeRmd("pdf_document")
onoremap <buffer> <silent> <Plug>RMakePDFK :call RMakeRmd("pdf_document")
nnoremap <buffer> <silent> <Plug>RMakeAll :call RMakeRmd("all")
onoremap <buffer> <silent> <Plug>RMakeAll :call RMakeRmd("all")
nnoremap <buffer> <silent> <Plug>RMakeRmd :call RMakeRmd("default")
onoremap <buffer> <silent> <Plug>RMakeRmd :call RMakeRmd("default")
nnoremap <buffer> <silent> <Plug>RCloseLists :call RBrOpenCloseLs("C")
onoremap <buffer> <silent> <Plug>RCloseLists :call RBrOpenCloseLs("C")
nnoremap <buffer> <silent> <Plug>ROpenLists :call RBrOpenCloseLs("O")
onoremap <buffer> <silent> <Plug>ROpenLists :call RBrOpenCloseLs("O")
nnoremap <buffer> <silent> <Plug>RUpdateObjBrowser :call RObjBrowser()
onoremap <buffer> <silent> <Plug>RUpdateObjBrowser :call RObjBrowser()
nnoremap <buffer> <silent> <Plug>RSPlot :call RAction("plotsumm")
onoremap <buffer> <silent> <Plug>RSPlot :call RAction("plotsumm")
nnoremap <buffer> <silent> <Plug>RPlot :call RAction("plot")
onoremap <buffer> <silent> <Plug>RPlot :call RAction("plot")
nnoremap <buffer> <silent> <Plug>RSummary :call RAction("summary")
onoremap <buffer> <silent> <Plug>RSummary :call RAction("summary")
nnoremap <buffer> <silent> <Plug>RHelp :call RAction("help")
onoremap <buffer> <silent> <Plug>RHelp :call RAction("help")
nnoremap <buffer> <silent> <Plug>RShowEx :call RAction("example")
onoremap <buffer> <silent> <Plug>RShowEx :call RAction("example")
nnoremap <buffer> <silent> <Plug>RShowArgs :call RAction("args")
onoremap <buffer> <silent> <Plug>RShowArgs :call RAction("args")
nnoremap <buffer> <silent> <Plug>RDputObj :call RAction("dputtab")
onoremap <buffer> <silent> <Plug>RDputObj :call RAction("dputtab")
nnoremap <buffer> <silent> <Plug>RViewDFa :call RAction("viewobj", ", howto='above 7split', nrows=6")
onoremap <buffer> <silent> <Plug>RViewDFa :call RAction("viewobj", ", howto='above 7split', nrows=6")
nnoremap <buffer> <silent> <Plug>RViewDFv :call RAction("viewobj", ", howto='vsplit'")
onoremap <buffer> <silent> <Plug>RViewDFv :call RAction("viewobj", ", howto='vsplit'")
nnoremap <buffer> <silent> <Plug>RViewDFs :call RAction("viewobj", ", howto='split'")
onoremap <buffer> <silent> <Plug>RViewDFs :call RAction("viewobj", ", howto='split'")
nnoremap <buffer> <silent> <Plug>RViewDF :call RAction("viewobj")
onoremap <buffer> <silent> <Plug>RViewDF :call RAction("viewobj")
nnoremap <buffer> <silent> <Plug>RObjectStr :call RAction("str")
onoremap <buffer> <silent> <Plug>RObjectStr :call RAction("str")
nnoremap <buffer> <silent> <Plug>RObjectNames :call RAction("nvim.names")
onoremap <buffer> <silent> <Plug>RObjectNames :call RAction("nvim.names")
nnoremap <buffer> <silent> <Plug>RObjectPr :call RAction("print")
onoremap <buffer> <silent> <Plug>RObjectPr :call RAction("print")
nnoremap <buffer> <silent> <Plug>RClearAll :call RClearAll()
onoremap <buffer> <silent> <Plug>RClearAll :call RClearAll()
nnoremap <buffer> <silent> <Plug>RClearConsole :call RClearConsole()
onoremap <buffer> <silent> <Plug>RClearConsole :call RClearConsole()
nnoremap <buffer> <silent> <Plug>RListSpace :call g:SendCmdToR("ls()")
onoremap <buffer> <silent> <Plug>RListSpace :call g:SendCmdToR("ls()")
nnoremap <buffer> <silent> <Plug>(RDSendLineAndInsertOutput) :call SendLineToRAndInsertOutput()0
onoremap <buffer> <silent> <Plug>(RDSendLineAndInsertOutput) :call SendLineToRAndInsertOutput()0
nnoremap <buffer> <silent> <Plug>REDSendSelection :call SendSelectionToR("echo", "down", "normal")
onoremap <buffer> <silent> <Plug>REDSendSelection :call SendSelectionToR("echo", "down", "normal")
nnoremap <buffer> <silent> <Plug>RDSendSelection :call SendSelectionToR("silent", "down", "normal")
onoremap <buffer> <silent> <Plug>RDSendSelection :call SendSelectionToR("silent", "down", "normal")
nnoremap <buffer> <silent> <Plug>RESendSelection :call SendSelectionToR("echo", "stay", "normal")
onoremap <buffer> <silent> <Plug>RESendSelection :call SendSelectionToR("echo", "stay", "normal")
nnoremap <buffer> <silent> <Plug>RSendSelection :call SendSelectionToR("silent", "stay", "normal")
onoremap <buffer> <silent> <Plug>RSendSelection :call SendSelectionToR("silent", "stay", "normal")
nnoremap <buffer> <silent> <Plug>RSendFunction :call SendFunctionToR("silent", "stay")
onoremap <buffer> <silent> <Plug>RSendFunction :call SendFunctionToR("silent", "stay")
nnoremap <buffer> <silent> <Plug>RSaveClose :call RQuit('save')
onoremap <buffer> <silent> <Plug>RSaveClose :call RQuit('save')
nnoremap <buffer> <silent> <Plug>RClose :call RQuit('nosave')
onoremap <buffer> <silent> <Plug>RClose :call RQuit('nosave')
nnoremap <buffer> <silent> <Plug>RCustomStart :call StartR("custom")
onoremap <buffer> <silent> <Plug>RCustomStart :call StartR("custom")
nnoremap <buffer> <silent> <Plug>RStart :call StartR("R")
onoremap <buffer> <silent> <Plug>RStart :call StartR("R")
noremap <buffer> <silent> <M-n> :call AutoPairsJump()
noremap <buffer> <silent> <M-p> :call AutoPairsToggle()
noremap <buffer> <silent> <Plug>RPreviousRChunk :call b:PreviousRChunk()
noremap <buffer> <silent> <Plug>RNextRChunk :call b:NextRChunk()
noremap <buffer> <silent> <Plug>REDSendChunk :call b:SendChunkToR("echo", "down")
noremap <buffer> <silent> <Plug>RDSendChunk :call b:SendChunkToR("silent", "down")
noremap <buffer> <silent> <Plug>RESendChunk :call b:SendChunkToR("echo", "stay")
noremap <buffer> <silent> <Plug>RSendChunk :call b:SendChunkToR("silent", "stay")
noremap <buffer> <silent> <Plug>RUndebug :call RAction("undebug")
noremap <buffer> <silent> <Plug>RDebug :call RAction("debug")
noremap <buffer> <silent> <Plug>RNRightPart :call RSendPartOfLine("right", 0)
noremap <buffer> <silent> <Plug>RNLeftPart :call RSendPartOfLine("left", 0)
noremap <buffer> <silent> <Plug>RSendMotion :set opfunc=SendMotionToRg@
noremap <buffer> <silent> <Plug>RDSendLine :call SendLineToR("down")0
noremap <buffer> <silent> <Plug>RSendLine :call SendLineToR("stay")
noremap <buffer> <silent> <Plug>RSendChunkFH :call SendFHChunkToR()
noremap <buffer> <silent> <Plug>REDSendParagraph :call SendParagraphToR("echo", "down")
noremap <buffer> <silent> <Plug>RDSendParagraph :call SendParagraphToR("silent", "down")
noremap <buffer> <silent> <Plug>RESendParagraph :call SendParagraphToR("echo", "stay")
noremap <buffer> <silent> <Plug>RSendParagraph :call SendParagraphToR("silent", "stay")
vnoremap <buffer> <silent> <Plug>RSendSelAndInsertOutput :call SendSelectionToR("echo", "stay", "NewtabInsert")
noremap <buffer> <silent> <Plug>REDSendMBlock :call SendMBlockToR("echo", "down")
noremap <buffer> <silent> <Plug>RDSendMBlock :call SendMBlockToR("silent", "down")
noremap <buffer> <silent> <Plug>RESendMBlock :call SendMBlockToR("echo", "stay")
noremap <buffer> <silent> <Plug>RSendMBlock :call SendMBlockToR("silent", "stay")
inoremap <buffer> <silent>  =AutoPairsDelete()
lnoremap <buffer> <silent> <expr>  ZFVimIME_enter("")
lnoremap <buffer> <silent> <expr>  ZFVimIME_esc("")
lnoremap <buffer> <silent> <expr>   ZFVimIME_space(" ")
inoremap <buffer> <silent>   =AutoPairsSpace()
lnoremap <buffer> <silent> <expr> ! ZFVimIME_symbol("!")
lnoremap <buffer> <silent> <expr> " ZFVimIME_symbol("\"")
inoremap <buffer> <silent> " =AutoPairsInsert('"')
lnoremap <buffer> <silent> <expr> $ ZFVimIME_symbol("$")
lnoremap <buffer> <silent> <expr> ' ZFVimIME_symbol("'")
inoremap <buffer> <silent> ' =AutoPairsInsert('''')
lnoremap <buffer> <silent> <expr> ( ZFVimIME_symbol("(")
inoremap <buffer> <silent> ( =AutoPairsInsert('(')
lnoremap <buffer> <silent> <expr> ) ZFVimIME_symbol(")")
inoremap <buffer> <silent> ) =AutoPairsInsert(')')
lnoremap <buffer> <silent> <expr> , ZFVimIME_symbol(",")
lnoremap <buffer> <silent> <expr> - ZFVimIME_pageUp("-")
lnoremap <buffer> <silent> <expr> . ZFVimIME_symbol(".")
lnoremap <buffer> <silent> <expr> / ZFVimIME_symbol("/")
lnoremap <buffer> <silent> <expr> 0 ZFVimIME_label(0)
lnoremap <buffer> <silent> <expr> 1 ZFVimIME_label(1)
lnoremap <buffer> <silent> <expr> 2 ZFVimIME_label(2)
lnoremap <buffer> <silent> <expr> 3 ZFVimIME_label(3)
lnoremap <buffer> <silent> <expr> 4 ZFVimIME_label(4)
lnoremap <buffer> <silent> <expr> 5 ZFVimIME_label(5)
lnoremap <buffer> <silent> <expr> 6 ZFVimIME_label(6)
lnoremap <buffer> <silent> <expr> 7 ZFVimIME_label(7)
lnoremap <buffer> <silent> <expr> 8 ZFVimIME_label(8)
lnoremap <buffer> <silent> <expr> 9 ZFVimIME_label(9)
lnoremap <buffer> <silent> <expr> : ZFVimIME_symbol(":")
lnoremap <buffer> <silent> <expr> ; ZFVimIME_symbol(";")
lnoremap <buffer> <silent> <expr> < ZFVimIME_symbol("<")
lnoremap <buffer> <silent> <expr> = ZFVimIME_pageDown("=")
lnoremap <buffer> <silent> <expr> > ZFVimIME_symbol(">")
lnoremap <buffer> <silent> <expr> ? ZFVimIME_symbol("?")
noremap <buffer> <silent> î :call AutoPairsJump()
noremap <buffer> <silent> ð :call AutoPairsToggle()
lnoremap <buffer> <silent> <expr> [ ZFVimIME_chooseL("[")
inoremap <buffer> <silent> [ =AutoPairsInsert('[')
lnoremap <buffer> <silent> <expr> \ ZFVimIME_symbol("\\")
lnoremap <buffer> <silent> <expr> ] ZFVimIME_chooseR("]")
inoremap <buffer> <silent> ] =AutoPairsInsert(']')
lnoremap <buffer> <silent> <expr> ^ ZFVimIME_symbol("^")
lnoremap <buffer> <silent> <expr> _ ZFVimIME_symbol("_")
inoremap <buffer> <silent> _ :call ReplaceUnderS()a
lnoremap <buffer> <silent> <expr> ` ZFVimIME_symbol("`")
inoremap <buffer> <silent> ` :call RWriteRmdChunk()a
lnoremap <buffer> <silent> <expr> a ZFVimIME_input("a")
lnoremap <buffer> <silent> <expr> b ZFVimIME_input("b")
lnoremap <buffer> <silent> <expr> c ZFVimIME_input("c")
lnoremap <buffer> <silent> <expr> d ZFVimIME_input("d")
lnoremap <buffer> <silent> <expr> e ZFVimIME_input("e")
lnoremap <buffer> <silent> <expr> f ZFVimIME_input("f")
lnoremap <buffer> <silent> <expr> g ZFVimIME_input("g")
lnoremap <buffer> <silent> <expr> h ZFVimIME_input("h")
lnoremap <buffer> <silent> <expr> i ZFVimIME_input("i")
lnoremap <buffer> <silent> <expr> j ZFVimIME_input("j")
lnoremap <buffer> <silent> <expr> k ZFVimIME_input("k")
lnoremap <buffer> <silent> <expr> l ZFVimIME_input("l")
lnoremap <buffer> <silent> <expr> m ZFVimIME_input("m")
lnoremap <buffer> <silent> <expr> n ZFVimIME_input("n")
lnoremap <buffer> <silent> <expr> o ZFVimIME_input("o")
lnoremap <buffer> <silent> <expr> p ZFVimIME_input("p")
lnoremap <buffer> <silent> <expr> q ZFVimIME_input("q")
lnoremap <buffer> <silent> <expr> r ZFVimIME_input("r")
lnoremap <buffer> <silent> <expr> s ZFVimIME_input("s")
lnoremap <buffer> <silent> <expr> t ZFVimIME_input("t")
lnoremap <buffer> <silent> <expr> u ZFVimIME_input("u")
lnoremap <buffer> <silent> <expr> v ZFVimIME_input("v")
lnoremap <buffer> <silent> <expr> w ZFVimIME_input("w")
lnoremap <buffer> <silent> <expr> x ZFVimIME_input("x")
lnoremap <buffer> <silent> <expr> y ZFVimIME_input("y")
lnoremap <buffer> <silent> <expr> z ZFVimIME_input("z")
inoremap <buffer> <silent> { =AutoPairsInsert('{')
inoremap <buffer> <silent> } =AutoPairsInsert('}')
let &cpo=s:cpo_save
unlet s:cpo_save
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal backupcopy=
setlocal balloonexpr=
setlocal nobinary
setlocal nobreakindent
setlocal breakindentopt=
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),0],:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=fb:*,fb:-,fb:+,n:>
setlocal commentstring=#\ %s
setlocal complete=.,w,b,u,t,i
setlocal concealcursor=
setlocal conceallevel=0
setlocal completefunc=
setlocal nocopyindent
setlocal cryptmethod=
setlocal nocursorbind
setlocal nocursorcolumn
set cursorline
setlocal cursorline
setlocal cursorlineopt=both
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'rmd'
setlocal filetype=rmd
endif
setlocal fixendofline
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
setlocal foldmethod=manual
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=FormatRmd()
setlocal formatoptions=tcqln
setlocal formatlistpat=^\\s*\\d\\+\\.\\s\\+\\|^\\s*[-*+]\\s\\+
setlocal formatprg=
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=-1
setlocal include=
setlocal includeexpr=
setlocal indentexpr=GetRmdIndent()
setlocal indentkeys=0{,0},<:>,!^F,o,O,e
setlocal noinfercase
setlocal iskeyword=@,48-57,_,.
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
setlocal lispwords=
setlocal nolist
setlocal listchars=
setlocal makeencoding=
setlocal makeprg=
setlocal matchpairs=(:),{:},[:]
setlocal modeline
setlocal modifiable
setlocal nrformats=bin,octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=CompleteR
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
setlocal norelativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal scrolloff=5
setlocal shiftwidth=2
setlocal noshortname
setlocal showbreak=
setlocal sidescrolloff=-1
setlocal signcolumn=auto
setlocal smartindent
setlocal softtabstop=2
set spell
setlocal spell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal spelloptions=
setlocal statusline=%!airline#statusline(1)
setlocal suffixesadd=
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'rmd'
setlocal syntax=rmd
endif
setlocal tabstop=2
setlocal tagcase=
setlocal tagfunc=
setlocal tags=
setlocal termwinkey=
setlocal termwinscroll=10000
setlocal termwinsize=
setlocal textwidth=0
setlocal thesaurus=
setlocal thesaurusfunc=
setlocal noundofile
setlocal undolevels=-123456
setlocal varsofttabstop=
setlocal vartabstop=
setlocal virtualedit=
setlocal wincolor=
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
silent! normal! zE
let &fdl = &fdl
let s:l = 2 - ((1 * winheight(0) + 9) / 19)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 2
normal! 0
tabnext
edit post_modify.R
argglobal
balt index.Rmd
let s:cpo_save=&cpo
set cpo&vim
inoremap <buffer> <silent> <M-n> :call AutoPairsJump()a
inoremap <buffer> <silent> <expr> <M-p> AutoPairsToggle()
inoremap <buffer> <silent> <M-b> =AutoPairsBackInsert()
inoremap <buffer> <silent> <M-e> =AutoPairsFastWrap()
inoremap <buffer> <silent> <C-H> =AutoPairsDelete()
inoremap <buffer> <silent> <BS> =AutoPairsDelete()
inoremap <buffer> <silent> <M-'> =AutoPairsMoveCharacter('''')
inoremap <buffer> <silent> <M-"> =AutoPairsMoveCharacter('"')
inoremap <buffer> <silent> <M-}> =AutoPairsMoveCharacter('}')
inoremap <buffer> <silent> <M-{> =AutoPairsMoveCharacter('{')
inoremap <buffer> <silent> <M-]> =AutoPairsMoveCharacter(']')
inoremap <buffer> <silent> <M-[> =AutoPairsMoveCharacter('[')
inoremap <buffer> <silent> <M-)> =AutoPairsMoveCharacter(')')
inoremap <buffer> <silent> <M-(> =AutoPairsMoveCharacter('(')
inoremap <buffer> <silent> § =AutoPairsMoveCharacter('''')
inoremap <buffer> <silent> ¢ =AutoPairsMoveCharacter('"')
inoremap <buffer> <silent> © =AutoPairsMoveCharacter(')')
inoremap <buffer> <silent> ¨ =AutoPairsMoveCharacter('(')
inoremap <buffer> <silent> î :call AutoPairsJump()a
inoremap <buffer> <silent> <expr> ð AutoPairsToggle()
inoremap <buffer> <silent> â =AutoPairsBackInsert()
inoremap <buffer> <silent> å =AutoPairsFastWrap()
inoremap <buffer> <silent> ý =AutoPairsMoveCharacter('}')
inoremap <buffer> <silent> û =AutoPairsMoveCharacter('{')
inoremap <buffer> <silent> Ý =AutoPairsMoveCharacter(']')
inoremap <buffer> <silent> Û =AutoPairsMoveCharacter('[')
vnoremap <buffer> <silent> \rd :call RSetWD()
vnoremap <buffer> <silent> \ko :call RMakeRmd("odt_document")
vnoremap <buffer> <silent> \kh :call RMakeRmd("html_document")
vnoremap <buffer> <silent> \kw :call RMakeRmd("word_document")
vnoremap <buffer> <silent> \kl :call RMakeRmd("beamer_presentation")
vnoremap <buffer> <silent> \kp :call RMakeRmd("pdf_document")
vnoremap <buffer> <silent> \ka :call RMakeRmd("all")
vnoremap <buffer> <silent> \kr :call RMakeRmd("default")
vnoremap <buffer> <silent> \r- :call RBrOpenCloseLs("C")
vnoremap <buffer> <silent> \r= :call RBrOpenCloseLs("O")
vnoremap <buffer> <silent> \ro :call RObjBrowser()
vnoremap <buffer> <silent> \rb :call RAction("plotsumm", "v")
vnoremap <buffer> <silent> \rg :call RAction("plot", "v")
vnoremap <buffer> <silent> \rs :call RAction("summary", "v")
vnoremap <buffer> <silent> \rh :call RAction("help")
vnoremap <buffer> <silent> \re :call RAction("example")
vnoremap <buffer> <silent> \ra :call RAction("args")
vnoremap <buffer> <silent> \td :call RAction("dputtab", "v")
vnoremap <buffer> <silent> \vh :call RAction("viewobj", "v", ", howto='above 7split', nrows=6")
vnoremap <buffer> <silent> \vv :call RAction("viewobj", "v", ", howto='vsplit'")
vnoremap <buffer> <silent> \vs :call RAction("viewobj", "v", ", howto='split'")
vnoremap <buffer> <silent> \rv :call RAction("viewobj", "v")
vnoremap <buffer> <silent> \rt :call RAction("str", "v")
vnoremap <buffer> <silent> \rn :call RAction("nvim.names", "v")
vnoremap <buffer> <silent> \rp :call RAction("print", "v")
vnoremap <buffer> <silent> \rm :call RClearAll()
vnoremap <buffer> <silent> \rr :call RClearConsole()
vnoremap <buffer> <silent> \rl :call g:SendCmdToR("ls()")
vnoremap <buffer> <silent> \o :call RWarningMsg("This command does not work over a selection of lines.")
vnoremap <buffer> <silent> \sa :call SendSelectionToR("echo", "down")
vnoremap <buffer> <silent> \sd :call SendSelectionToR("silent", "down")
vnoremap <buffer> <silent> \se :call SendSelectionToR("echo", "stay")
vnoremap <buffer> <silent> \ss :call SendSelectionToR("silent", "stay")
vnoremap <buffer> <silent> \fa :call SendFunctionToR("echo", "down")
vnoremap <buffer> <silent> \fd :call SendFunctionToR("silent", "down")
vnoremap <buffer> <silent> \fe :call SendFunctionToR("echo", "stay")
vnoremap <buffer> <silent> \ff :call SendFunctionToR("silent", "stay")
vnoremap <buffer> <silent> \rw :call RQuit('save')
vnoremap <buffer> <silent> \rq :call RQuit('nosave')
vnoremap <buffer> <silent> \rc :call StartR("custom")
vnoremap <buffer> <silent> \rf :call StartR("R")
nnoremap <buffer> <silent> \rd :call RSetWD()
onoremap <buffer> <silent> \rd :call RSetWD()
nnoremap <buffer> <silent> \ko :call RMakeRmd("odt_document")
onoremap <buffer> <silent> \ko :call RMakeRmd("odt_document")
nnoremap <buffer> <silent> \kh :call RMakeRmd("html_document")
onoremap <buffer> <silent> \kh :call RMakeRmd("html_document")
nnoremap <buffer> <silent> \kw :call RMakeRmd("word_document")
onoremap <buffer> <silent> \kw :call RMakeRmd("word_document")
nnoremap <buffer> <silent> \kl :call RMakeRmd("beamer_presentation")
onoremap <buffer> <silent> \kl :call RMakeRmd("beamer_presentation")
nnoremap <buffer> <silent> \kp :call RMakeRmd("pdf_document")
onoremap <buffer> <silent> \kp :call RMakeRmd("pdf_document")
nnoremap <buffer> <silent> \ka :call RMakeRmd("all")
onoremap <buffer> <silent> \ka :call RMakeRmd("all")
nnoremap <buffer> <silent> \kr :call RMakeRmd("default")
onoremap <buffer> <silent> \kr :call RMakeRmd("default")
nnoremap <buffer> <silent> \r- :call RBrOpenCloseLs("C")
onoremap <buffer> <silent> \r- :call RBrOpenCloseLs("C")
nnoremap <buffer> <silent> \r= :call RBrOpenCloseLs("O")
onoremap <buffer> <silent> \r= :call RBrOpenCloseLs("O")
nnoremap <buffer> <silent> \ro :call RObjBrowser()
onoremap <buffer> <silent> \ro :call RObjBrowser()
nnoremap <buffer> <silent> \rb :call RAction("plotsumm")
onoremap <buffer> <silent> \rb :call RAction("plotsumm")
nnoremap <buffer> <silent> \rg :call RAction("plot")
onoremap <buffer> <silent> \rg :call RAction("plot")
nnoremap <buffer> <silent> \rs :call RAction("summary")
onoremap <buffer> <silent> \rs :call RAction("summary")
nnoremap <buffer> <silent> \rh :call RAction("help")
onoremap <buffer> <silent> \rh :call RAction("help")
nnoremap <buffer> <silent> \re :call RAction("example")
onoremap <buffer> <silent> \re :call RAction("example")
nnoremap <buffer> <silent> \ra :call RAction("args")
onoremap <buffer> <silent> \ra :call RAction("args")
nnoremap <buffer> <silent> \td :call RAction("dputtab")
onoremap <buffer> <silent> \td :call RAction("dputtab")
nnoremap <buffer> <silent> \vh :call RAction("viewobj", ", howto='above 7split', nrows=6")
onoremap <buffer> <silent> \vh :call RAction("viewobj", ", howto='above 7split', nrows=6")
nnoremap <buffer> <silent> \vv :call RAction("viewobj", ", howto='vsplit'")
onoremap <buffer> <silent> \vv :call RAction("viewobj", ", howto='vsplit'")
nnoremap <buffer> <silent> \vs :call RAction("viewobj", ", howto='split'")
onoremap <buffer> <silent> \vs :call RAction("viewobj", ", howto='split'")
nnoremap <buffer> <silent> \rv :call RAction("viewobj")
onoremap <buffer> <silent> \rv :call RAction("viewobj")
nnoremap <buffer> <silent> \rt :call RAction("str")
onoremap <buffer> <silent> \rt :call RAction("str")
nnoremap <buffer> <silent> \rn :call RAction("nvim.names")
onoremap <buffer> <silent> \rn :call RAction("nvim.names")
nnoremap <buffer> <silent> \rp :call RAction("print")
onoremap <buffer> <silent> \rp :call RAction("print")
nnoremap <buffer> <silent> \rm :call RClearAll()
onoremap <buffer> <silent> \rm :call RClearAll()
nnoremap <buffer> <silent> \rr :call RClearConsole()
onoremap <buffer> <silent> \rr :call RClearConsole()
nnoremap <buffer> <silent> \rl :call g:SendCmdToR("ls()")
onoremap <buffer> <silent> \rl :call g:SendCmdToR("ls()")
nnoremap <buffer> <silent> \o :call SendLineToRAndInsertOutput()0
onoremap <buffer> <silent> \o :call SendLineToRAndInsertOutput()0
nnoremap <buffer> <silent> \sa :call SendSelectionToR("echo", "down", "normal")
onoremap <buffer> <silent> \sa :call SendSelectionToR("echo", "down", "normal")
nnoremap <buffer> <silent> \sd :call SendSelectionToR("silent", "down", "normal")
onoremap <buffer> <silent> \sd :call SendSelectionToR("silent", "down", "normal")
nnoremap <buffer> <silent> \se :call SendSelectionToR("echo", "stay", "normal")
onoremap <buffer> <silent> \se :call SendSelectionToR("echo", "stay", "normal")
nnoremap <buffer> <silent> \ss :call SendSelectionToR("silent", "stay", "normal")
onoremap <buffer> <silent> \ss :call SendSelectionToR("silent", "stay", "normal")
nnoremap <buffer> <silent> \fa :call SendFunctionToR("echo", "down")
onoremap <buffer> <silent> \fa :call SendFunctionToR("echo", "down")
nnoremap <buffer> <silent> \fd :call SendFunctionToR("silent", "down")
onoremap <buffer> <silent> \fd :call SendFunctionToR("silent", "down")
nnoremap <buffer> <silent> \fe :call SendFunctionToR("echo", "stay")
onoremap <buffer> <silent> \fe :call SendFunctionToR("echo", "stay")
nnoremap <buffer> <silent> \ff :call SendFunctionToR("silent", "stay")
onoremap <buffer> <silent> \ff :call SendFunctionToR("silent", "stay")
nnoremap <buffer> <silent> \rw :call RQuit('save')
onoremap <buffer> <silent> \rw :call RQuit('save')
nnoremap <buffer> <silent> \rq :call RQuit('nosave')
onoremap <buffer> <silent> \rq :call RQuit('nosave')
nnoremap <buffer> <silent> \rc :call StartR("custom")
onoremap <buffer> <silent> \rc :call StartR("custom")
nnoremap <buffer> <silent> \rf :call StartR("R")
onoremap <buffer> <silent> \rf :call StartR("R")
noremap <buffer> <silent> \ud :call RAction("undebug")
noremap <buffer> <silent> \bg :call RAction("debug")
noremap <buffer> <silent> \su :call SendAboveLinesToR()
noremap <buffer> <silent> \r<Right> :call RSendPartOfLine("right", 0)
noremap <buffer> <silent> \r<Left> :call RSendPartOfLine("left", 0)
noremap <buffer> <silent> \m :set opfunc=SendMotionToRg@
noremap <buffer> <silent> \d :call SendLineToR("down")0
noremap <buffer> <silent> \l :call SendLineToR("stay")
noremap <buffer> <silent> \pa :call SendParagraphToR("echo", "down")
noremap <buffer> <silent> \pd :call SendParagraphToR("silent", "down")
noremap <buffer> <silent> \pe :call SendParagraphToR("echo", "stay")
noremap <buffer> <silent> \pp :call SendParagraphToR("silent", "stay")
vnoremap <buffer> <silent> \so :call SendSelectionToR("echo", "stay", "NewtabInsert")
noremap <buffer> <silent> \ba :call SendMBlockToR("echo", "down")
noremap <buffer> <silent> \bd :call SendMBlockToR("silent", "down")
noremap <buffer> <silent> \be :call SendMBlockToR("echo", "stay")
noremap <buffer> <silent> \bb :call SendMBlockToR("silent", "stay")
noremap <buffer> <silent> \ks :call RSpin()
noremap <buffer> <silent> \ao :call ShowRout()
noremap <buffer> <silent> \ae :call SendFileToR("echo")
noremap <buffer> <silent> \aa :call SendFileToR("silent")
vnoremap <buffer> <silent> <Plug>RSetwd :call RSetWD()
vnoremap <buffer> <silent> <Plug>RMakeODT :call RMakeRmd("odt_document")
vnoremap <buffer> <silent> <Plug>RMakeHTML :call RMakeRmd("html_document")
vnoremap <buffer> <silent> <Plug>RMakeWord :call RMakeRmd("word_document")
vnoremap <buffer> <silent> <Plug>RMakePDFKb :call RMakeRmd("beamer_presentation")
vnoremap <buffer> <silent> <Plug>RMakePDFK :call RMakeRmd("pdf_document")
vnoremap <buffer> <silent> <Plug>RMakeAll :call RMakeRmd("all")
vnoremap <buffer> <silent> <Plug>RMakeRmd :call RMakeRmd("default")
vnoremap <buffer> <silent> <Plug>RCloseLists :call RBrOpenCloseLs("C")
vnoremap <buffer> <silent> <Plug>ROpenLists :call RBrOpenCloseLs("O")
vnoremap <buffer> <silent> <Plug>RUpdateObjBrowser :call RObjBrowser()
vnoremap <buffer> <silent> <Plug>RSPlot :call RAction("plotsumm", "v")
vnoremap <buffer> <silent> <Plug>RPlot :call RAction("plot", "v")
vnoremap <buffer> <silent> <Plug>RSummary :call RAction("summary", "v")
vnoremap <buffer> <silent> <Plug>RHelp :call RAction("help")
vnoremap <buffer> <silent> <Plug>RShowEx :call RAction("example")
vnoremap <buffer> <silent> <Plug>RShowArgs :call RAction("args")
vnoremap <buffer> <silent> <Plug>RDputObj :call RAction("dputtab", "v")
vnoremap <buffer> <silent> <Plug>RViewDFa :call RAction("viewobj", "v", ", howto='above 7split', nrows=6")
vnoremap <buffer> <silent> <Plug>RViewDFv :call RAction("viewobj", "v", ", howto='vsplit'")
vnoremap <buffer> <silent> <Plug>RViewDFs :call RAction("viewobj", "v", ", howto='split'")
vnoremap <buffer> <silent> <Plug>RViewDF :call RAction("viewobj", "v")
vnoremap <buffer> <silent> <Plug>RObjectStr :call RAction("str", "v")
vnoremap <buffer> <silent> <Plug>RObjectNames :call RAction("nvim.names", "v")
vnoremap <buffer> <silent> <Plug>RObjectPr :call RAction("print", "v")
vnoremap <buffer> <silent> <Plug>RClearAll :call RClearAll()
vnoremap <buffer> <silent> <Plug>RClearConsole :call RClearConsole()
vnoremap <buffer> <silent> <Plug>RListSpace :call g:SendCmdToR("ls()")
vnoremap <buffer> <silent> <Plug>(RDSendLineAndInsertOutput) :call RWarningMsg("This command does not work over a selection of lines.")
vnoremap <buffer> <silent> <Plug>REDSendSelection :call SendSelectionToR("echo", "down")
vnoremap <buffer> <silent> <Plug>RDSendSelection :call SendSelectionToR("silent", "down")
vnoremap <buffer> <silent> <Plug>RESendSelection :call SendSelectionToR("echo", "stay")
vnoremap <buffer> <silent> <Plug>RSendSelection :call SendSelectionToR("silent", "stay")
vnoremap <buffer> <silent> <Plug>RDSendFunction :call SendFunctionToR("echo", "down")
nnoremap <buffer> <silent> <Plug>RDSendFunction :call SendFunctionToR("echo", "down")
onoremap <buffer> <silent> <Plug>RDSendFunction :call SendFunctionToR("echo", "down")
vnoremap <buffer> <silent> <Plug>RSendFunction :call SendFunctionToR("silent", "stay")
vnoremap <buffer> <silent> <Plug>RSaveClose :call RQuit('save')
vnoremap <buffer> <silent> <Plug>RClose :call RQuit('nosave')
vnoremap <buffer> <silent> <Plug>RCustomStart :call StartR("custom")
vnoremap <buffer> <silent> <Plug>RStart :call StartR("R")
nnoremap <buffer> <silent> <Plug>RSetwd :call RSetWD()
onoremap <buffer> <silent> <Plug>RSetwd :call RSetWD()
nnoremap <buffer> <silent> <Plug>RMakeODT :call RMakeRmd("odt_document")
onoremap <buffer> <silent> <Plug>RMakeODT :call RMakeRmd("odt_document")
nnoremap <buffer> <silent> <Plug>RMakeHTML :call RMakeRmd("html_document")
onoremap <buffer> <silent> <Plug>RMakeHTML :call RMakeRmd("html_document")
nnoremap <buffer> <silent> <Plug>RMakeWord :call RMakeRmd("word_document")
onoremap <buffer> <silent> <Plug>RMakeWord :call RMakeRmd("word_document")
nnoremap <buffer> <silent> <Plug>RMakePDFKb :call RMakeRmd("beamer_presentation")
onoremap <buffer> <silent> <Plug>RMakePDFKb :call RMakeRmd("beamer_presentation")
nnoremap <buffer> <silent> <Plug>RMakePDFK :call RMakeRmd("pdf_document")
onoremap <buffer> <silent> <Plug>RMakePDFK :call RMakeRmd("pdf_document")
nnoremap <buffer> <silent> <Plug>RMakeAll :call RMakeRmd("all")
onoremap <buffer> <silent> <Plug>RMakeAll :call RMakeRmd("all")
nnoremap <buffer> <silent> <Plug>RMakeRmd :call RMakeRmd("default")
onoremap <buffer> <silent> <Plug>RMakeRmd :call RMakeRmd("default")
nnoremap <buffer> <silent> <Plug>RCloseLists :call RBrOpenCloseLs("C")
onoremap <buffer> <silent> <Plug>RCloseLists :call RBrOpenCloseLs("C")
nnoremap <buffer> <silent> <Plug>ROpenLists :call RBrOpenCloseLs("O")
onoremap <buffer> <silent> <Plug>ROpenLists :call RBrOpenCloseLs("O")
nnoremap <buffer> <silent> <Plug>RUpdateObjBrowser :call RObjBrowser()
onoremap <buffer> <silent> <Plug>RUpdateObjBrowser :call RObjBrowser()
nnoremap <buffer> <silent> <Plug>RSPlot :call RAction("plotsumm")
onoremap <buffer> <silent> <Plug>RSPlot :call RAction("plotsumm")
nnoremap <buffer> <silent> <Plug>RPlot :call RAction("plot")
onoremap <buffer> <silent> <Plug>RPlot :call RAction("plot")
nnoremap <buffer> <silent> <Plug>RSummary :call RAction("summary")
onoremap <buffer> <silent> <Plug>RSummary :call RAction("summary")
nnoremap <buffer> <silent> <Plug>RHelp :call RAction("help")
onoremap <buffer> <silent> <Plug>RHelp :call RAction("help")
nnoremap <buffer> <silent> <Plug>RShowEx :call RAction("example")
onoremap <buffer> <silent> <Plug>RShowEx :call RAction("example")
nnoremap <buffer> <silent> <Plug>RShowArgs :call RAction("args")
onoremap <buffer> <silent> <Plug>RShowArgs :call RAction("args")
nnoremap <buffer> <silent> <Plug>RDputObj :call RAction("dputtab")
onoremap <buffer> <silent> <Plug>RDputObj :call RAction("dputtab")
nnoremap <buffer> <silent> <Plug>RViewDFa :call RAction("viewobj", ", howto='above 7split', nrows=6")
onoremap <buffer> <silent> <Plug>RViewDFa :call RAction("viewobj", ", howto='above 7split', nrows=6")
nnoremap <buffer> <silent> <Plug>RViewDFv :call RAction("viewobj", ", howto='vsplit'")
onoremap <buffer> <silent> <Plug>RViewDFv :call RAction("viewobj", ", howto='vsplit'")
nnoremap <buffer> <silent> <Plug>RViewDFs :call RAction("viewobj", ", howto='split'")
onoremap <buffer> <silent> <Plug>RViewDFs :call RAction("viewobj", ", howto='split'")
nnoremap <buffer> <silent> <Plug>RViewDF :call RAction("viewobj")
onoremap <buffer> <silent> <Plug>RViewDF :call RAction("viewobj")
nnoremap <buffer> <silent> <Plug>RObjectStr :call RAction("str")
onoremap <buffer> <silent> <Plug>RObjectStr :call RAction("str")
nnoremap <buffer> <silent> <Plug>RObjectNames :call RAction("nvim.names")
onoremap <buffer> <silent> <Plug>RObjectNames :call RAction("nvim.names")
nnoremap <buffer> <silent> <Plug>RObjectPr :call RAction("print")
onoremap <buffer> <silent> <Plug>RObjectPr :call RAction("print")
nnoremap <buffer> <silent> <Plug>RClearAll :call RClearAll()
onoremap <buffer> <silent> <Plug>RClearAll :call RClearAll()
nnoremap <buffer> <silent> <Plug>RClearConsole :call RClearConsole()
onoremap <buffer> <silent> <Plug>RClearConsole :call RClearConsole()
nnoremap <buffer> <silent> <Plug>RListSpace :call g:SendCmdToR("ls()")
onoremap <buffer> <silent> <Plug>RListSpace :call g:SendCmdToR("ls()")
nnoremap <buffer> <silent> <Plug>(RDSendLineAndInsertOutput) :call SendLineToRAndInsertOutput()0
onoremap <buffer> <silent> <Plug>(RDSendLineAndInsertOutput) :call SendLineToRAndInsertOutput()0
nnoremap <buffer> <silent> <Plug>REDSendSelection :call SendSelectionToR("echo", "down", "normal")
onoremap <buffer> <silent> <Plug>REDSendSelection :call SendSelectionToR("echo", "down", "normal")
nnoremap <buffer> <silent> <Plug>RDSendSelection :call SendSelectionToR("silent", "down", "normal")
onoremap <buffer> <silent> <Plug>RDSendSelection :call SendSelectionToR("silent", "down", "normal")
nnoremap <buffer> <silent> <Plug>RESendSelection :call SendSelectionToR("echo", "stay", "normal")
onoremap <buffer> <silent> <Plug>RESendSelection :call SendSelectionToR("echo", "stay", "normal")
nnoremap <buffer> <silent> <Plug>RSendSelection :call SendSelectionToR("silent", "stay", "normal")
onoremap <buffer> <silent> <Plug>RSendSelection :call SendSelectionToR("silent", "stay", "normal")
nnoremap <buffer> <silent> <Plug>RSendFunction :call SendFunctionToR("silent", "stay")
onoremap <buffer> <silent> <Plug>RSendFunction :call SendFunctionToR("silent", "stay")
nnoremap <buffer> <silent> <Plug>RSaveClose :call RQuit('save')
onoremap <buffer> <silent> <Plug>RSaveClose :call RQuit('save')
nnoremap <buffer> <silent> <Plug>RClose :call RQuit('nosave')
onoremap <buffer> <silent> <Plug>RClose :call RQuit('nosave')
nnoremap <buffer> <silent> <Plug>RCustomStart :call StartR("custom")
onoremap <buffer> <silent> <Plug>RCustomStart :call StartR("custom")
nnoremap <buffer> <silent> <Plug>RStart :call StartR("R")
onoremap <buffer> <silent> <Plug>RStart :call StartR("R")
noremap <buffer> <silent> <M-n> :call AutoPairsJump()
noremap <buffer> <silent> <M-p> :call AutoPairsToggle()
noremap <buffer> <silent> <Plug>RUndebug :call RAction("undebug")
noremap <buffer> <silent> <Plug>RDebug :call RAction("debug")
noremap <buffer> <silent> <Plug>RSendAboveLines :call SendAboveLinesToR()
noremap <buffer> <silent> <Plug>RNRightPart :call RSendPartOfLine("right", 0)
noremap <buffer> <silent> <Plug>RNLeftPart :call RSendPartOfLine("left", 0)
noremap <buffer> <silent> <Plug>RSendMotion :set opfunc=SendMotionToRg@
noremap <buffer> <silent> <Plug>RDSendLine :call SendLineToR("down")0
noremap <buffer> <silent> <Plug>RSendLine :call SendLineToR("stay")
noremap <buffer> <silent> <Plug>REDSendParagraph :call SendParagraphToR("echo", "down")
noremap <buffer> <silent> <Plug>RDSendParagraph :call SendParagraphToR("silent", "down")
noremap <buffer> <silent> <Plug>RESendParagraph :call SendParagraphToR("echo", "stay")
noremap <buffer> <silent> <Plug>RSendParagraph :call SendParagraphToR("silent", "stay")
vnoremap <buffer> <silent> <Plug>RSendSelAndInsertOutput :call SendSelectionToR("echo", "stay", "NewtabInsert")
noremap <buffer> <silent> <Plug>REDSendMBlock :call SendMBlockToR("echo", "down")
noremap <buffer> <silent> <Plug>RDSendMBlock :call SendMBlockToR("silent", "down")
noremap <buffer> <silent> <Plug>RESendMBlock :call SendMBlockToR("echo", "stay")
noremap <buffer> <silent> <Plug>RSendMBlock :call SendMBlockToR("silent", "stay")
noremap <buffer> <silent> <Plug>RSpinFile :call RSpin()
noremap <buffer> <silent> <Plug>RShowRout :call ShowRout()
noremap <buffer> <silent> <Plug>RESendFile :call SendFileToR("echo")
noremap <buffer> <silent> <Plug>RSendFile :call SendFileToR("silent")
inoremap <buffer> <silent>  =AutoPairsDelete()
inoremap <buffer> <silent>   =AutoPairsSpace()
inoremap <buffer> <silent> " =AutoPairsInsert('"')
inoremap <buffer> <silent> ' =AutoPairsInsert('''')
inoremap <buffer> <silent> ( =AutoPairsInsert('(')
inoremap <buffer> <silent> ) =AutoPairsInsert(')')
noremap <buffer> <silent> î :call AutoPairsJump()
noremap <buffer> <silent> ð :call AutoPairsToggle()
inoremap <buffer> <silent> [ =AutoPairsInsert('[')
inoremap <buffer> <silent> ] =AutoPairsInsert(']')
inoremap <buffer> <silent> _ :call ReplaceUnderS()a
inoremap <buffer> <silent> ` =AutoPairsInsert('`')
inoremap <buffer> <silent> { =AutoPairsInsert('{')
inoremap <buffer> <silent> } =AutoPairsInsert('}')
let &cpo=s:cpo_save
unlet s:cpo_save
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal backupcopy=
setlocal balloonexpr=
setlocal nobinary
setlocal nobreakindent
setlocal breakindentopt=
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),0],:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=:#',:###,:##,:#
setlocal commentstring=#\ %s
setlocal complete=.,w,b,u,t,i
setlocal concealcursor=
setlocal conceallevel=0
setlocal completefunc=
setlocal nocopyindent
setlocal cryptmethod=
setlocal nocursorbind
setlocal nocursorcolumn
set cursorline
setlocal cursorline
setlocal cursorlineopt=both
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'r'
setlocal filetype=r
endif
setlocal fixendofline
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
setlocal foldmethod=manual
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=cq
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal formatprg=
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=-1
setlocal include=
setlocal includeexpr=
setlocal indentexpr=GetRIndent()
setlocal indentkeys=0{,0},:,!^F,o,O,e
setlocal noinfercase
setlocal iskeyword=@,48-57,_,.
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
setlocal lispwords=
setlocal nolist
setlocal listchars=
setlocal makeencoding=
setlocal makeprg=
setlocal matchpairs=(:),{:},[:]
setlocal modeline
setlocal modifiable
setlocal nrformats=bin,octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=CompleteR
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
setlocal norelativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal scrolloff=-1
setlocal shiftwidth=2
setlocal noshortname
setlocal showbreak=
setlocal sidescrolloff=-1
setlocal signcolumn=auto
setlocal smartindent
setlocal softtabstop=2
set spell
setlocal spell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal spelloptions=
setlocal statusline=%!airline#statusline(1)
setlocal suffixesadd=
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'r'
setlocal syntax=r
endif
setlocal tabstop=2
setlocal tagcase=
setlocal tagfunc=
setlocal tags=
setlocal termwinkey=
setlocal termwinscroll=10000
setlocal termwinsize=
setlocal textwidth=0
setlocal thesaurus=
setlocal thesaurusfunc=
setlocal noundofile
setlocal undolevels=-123456
setlocal varsofttabstop=
setlocal vartabstop=
setlocal virtualedit=
setlocal wincolor=
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
silent! normal! zE
let &fdl = &fdl
let s:l = 1 - ((0 * winheight(0) + 11) / 23)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
tabnext 1
set stal=1
badd +379 index.Rmd
badd +5259 ~/utils.tool/inst/extdata/library.bib
badd +29 ~/.vim/after/ftplugin/install.sh
badd +14 post_modify.R
badd +75 dep.Rmd
badd +6 ~/.vim/after/ftplugin/reloadPackage.R
badd +3 ~/utils.tool/inst/extdata/script_templ_lixiao/index.Rmd
badd +339 ../2023_06_30_eval/index.Rmd
badd +9 ~/outline/lixiao/2023_06_30_eval/post_modify.R
badd +7 ~/utils.tool/inst/extdata/script_templ_lixiao/post_modify.R
badd +86 ~/.vim/after/ftplugin/rmd.vim
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToOSIc
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
