" NERDTree
let NERDTreeShowHidden=1
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif


" Vim Wiki
let g:vimwiki_list = [{ 'path': '/Users/worrawutp/Google Drive/vimwiki/', 'syntax':'markdown', 'ext': '.md' }]                  

" NV
let g:nv_search_paths = ['/Users/worrawutp/Google Drive/vimwiki']  

