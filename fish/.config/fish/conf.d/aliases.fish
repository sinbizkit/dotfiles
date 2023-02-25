# Set vim as alias for neovim for macOS. Use update-alternatives for
# nix platforms.
if type -q nvim
	alias vim="nvim"
end

if type -q exa
	alias ls="exa --group-directories-first"
	alias la="exa --all --group-directories-first"
	alias ll="exa --long --group-directories-first"
	alias lla="exa --long --all --group-directories-first"
end
