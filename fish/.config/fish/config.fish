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

