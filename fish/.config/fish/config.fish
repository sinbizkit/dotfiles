#
#  File: config.fish
# Created by Ivan Berdnikov on 06/03/19
#

# Supress greetings message.
function fish_greeting
end

# omf settings (https://github.com/oh-my-fish/oh-my-fish).
# Theme (https://github.com/oh-my-fish/theme-bobthefish)
set -g theme_color_scheme terminal-dark
set -g theme_display_git yes
set -g theme_display_hostname ssh
set -g theme_newline_cursor yes
set -g theme_date_format "+%a %H:%M"

# Global.
if type -q vim
	set -Ux EDITOR vim
end
if type -q nvim
	set -Ux MANPAGER "nvim -c 'set ft=man' -"
end

if type -q direnv
	direnv hook fish | source
end

# Helpful aliases
alias hexedit="hexedit --color"

# Environment vars.
set -x CMAKE_BUILD_PARALLEL_LEVEL 16
set -x CTEST_PARALLEL_LEVEL       16
#GDB
set -x GDB_STL_PP_ROOT "$HOME/utils/gdb-pp/gdbstl"
set -x GDB_QT5_PP_ROOT "$HOME/utils/gdb-pp/qt5"
# LLVM
set -x LLVM_ASAN_SYMBOLIZER "llvm-symbolizer"
#fzf
set -x FZF_DEFAULT_OPTS    "--height 40% --layout=reverse --border --no-mouse"
set -x FZF_DEFAULT_COMMAND "fd --type f --exclude .git --ignore-case"
set -x FZF_CTRL_T_COMMAND  "$FZF_DEFAULT_COMMAND"

set PATH $HOME/.local/bin $PATH
set PATH $HOME/.local/go/bin $PATH
set PATH $HOME/.cargo/bin $PATH
