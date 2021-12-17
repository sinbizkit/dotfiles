# Set vim as alias for neovim for macOS. Use update-alternatives for
# nix platforms.
if test (uname) = "Darwin"; and test -e (which nvim)
	alias vim="nvim"
end
