#
#  File: config.fish
# Created by Ivan Berdnikov on 06/03/19
#

# vi-keybindings by default
fish_vi_key_bindings
# Restore "<Ctrl>f" mapping from emacs mode.
for mode in insert default visual
	bind -M $mode \cf forward-char
end

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
