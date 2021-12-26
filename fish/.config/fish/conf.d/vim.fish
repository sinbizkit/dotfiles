if type -q nvim
	set -Ux EDITOR nvim
	set -Ux MANPAGER "nvim +Man!"
else if type -q vim
	set -Ux EDITOR vim
end
