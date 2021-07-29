let g:fzf_action = {
  \ 'ctrl-t': 'tab split'
  \ , 'ctrl-o': 'split'
  \ , 'ctrl-e': 'vsplit'
  \ }

autocmd FileType fzf set nonumber norelativenumber
let g:fzf_buffers_jump = 1 " Jump to the existing window if possible
nnoremap <silent> <Leader>t :Files<CR>
nnoremap <silent> <Leader>r :Tags<CR>
nnoremap <silent> <Leader>b :Buffers<CR>

