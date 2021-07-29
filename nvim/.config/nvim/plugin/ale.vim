let g:ale_completion_enabled   = 0
let g:ale_sign_error           = '✘'
let g:ale_sign_warning         = ''
let g:ale_sign_info            = ''
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter        = 0
let g:ale_lint_on_save         = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_maximum_file_size    = 100 * 1024 " 100 kbytes max
let g:ale_echo_msg_format      = '[%linter%] %s [%severity%]'
let g:airline#extensions#ale#enabled = 1
nnoremap <silent> <Leader>ll :ALELint<CR>
nnoremap <silent> <Leader>lj :ALENext<CR>
nnoremap <silent> <Leader>lk :ALEPrevious<CR>
nnoremap <silent> <Leader>lf :ALEFix<CR>

