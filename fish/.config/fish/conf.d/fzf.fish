set -x FZF_DEFAULT_OPTS    "--height 40% --layout=reverse --border --no-mouse"
set -x FZF_DEFAULT_COMMAND "fd --type f --exclude .git --ignore-case"
set -x FZF_CTRL_T_COMMAND  "$FZF_DEFAULT_COMMAND"
