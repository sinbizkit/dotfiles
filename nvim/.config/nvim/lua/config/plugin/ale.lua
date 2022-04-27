local g = vim.g

g.ale_completion_enabled   = 0
g.ale_sign_error           = '✘'
g.ale_sign_warning         = ''
g.ale_sign_info            = ''
g.ale_lint_on_text_changed = 'never'
g.ale_lint_on_enter        = 0
g.ale_lint_on_save         = 0
g.ale_lint_on_insert_leave = 0
g.ale_maximum_file_size    = 100 * 1024 -- 100 kbytes max
g.ale_echo_msg_format      = '[%linter%] %s [%severity%]'
