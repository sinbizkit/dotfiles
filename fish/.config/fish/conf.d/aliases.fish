# Set vim as alias for neovim for macOS. Use update-alternatives for
# nix platforms.
if type -q nvim
	alias vim="nvim"
end

if type -q exa
	alias ls="eza --group-directories-first"
	alias la="eza --all --group-directories-first"
	alias ll="eza --long --group-directories-first"
	alias lla="eza --long --all --group-directories-first"
end
