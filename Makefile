SHELL := /bin/bash
LOCAL_DIR := ${HOME}/.local
CONFIG_DIR := ${HOME}/.config
MKFILE_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
OS := $(shell ${SHELL} ${MKFILE_DIR}/script/os.sh)

export OS

all: install

install: install-fish \
	install-nvim \
	install-tmux \
	install-alacritty \
	install-i3 \
	install-lf \
	install-fzf \
	install-fd \
	install-dunst

.PHONY: install-fish
install-fish: preinstall
	${SHELL} ${MKFILE_DIR}/script/fish.sh
	stow --target=${HOME} fish

.PHONY: install-nvim
install-nvim: preinstall
	${SHELL} ${MKFILE_DIR}/script/nvim/nvim.sh
	stow --target=${CONFIG_DIR} nvim

.PHONY: clean-nvim
clean-nvim:
	stow --delete --dir=${MKFILE_DIR}/script/nvim --target=${LOCAL_DIR} .root
	stow --delete --target=${CONFIG_DIR} nvim
	rm -rf ${MKFILE_DIR}/script/nvim/.root

.PHONY: install-tmux
install-tmux: preinstall
	${SHELL} ${MKFILE_DIR}/script/tmux.sh
	stow --target=${HOME} tmux

.PHONY: install-alacritty
install-alacritty: preinstall install-lf
	${SHELL} ${MKFILE_DIR}/script/alacritty.sh
	stow --target=${HOME} alacritty

.PHONY: install-ghostty
install-ghostty: preinstall
	${SHELL} ${MKFILE_DIR}/script/ghostty.sh
	stow --target=${HOME} ghostty

.PHONY: install-i3
install-i3: preinstall
	${SHELL} ${MKFILE_DIR}/script/i3.sh
	stow --target=${HOME} i3 polybar rofi

.PHONY: install-lf
install-lf: preinstall install-fzf
	${SHELL} ${MKFILE_DIR}/script/lf/lf.sh
	stow --target=${CONFIG_DIR} lf

.PHONY: clean-lf
clean-lf:
	stow --delete --dir=${MKFILE_DIR}/script/lf --target=${LOCAL_DIR} .root
	stow --delete --target=${CONFIG_DIR} lf

.PHONY: install-fzf
install-fzf: preinstall install-fd
	${SHELL} ${MKFILE_DIR}/script/fzf.sh

.PHONY: install-fd
install-fd: preinstall
	${SHELL} ${MKFILE_DIR}/script/fd.sh

.PHONY: install-dunst
install-dunst: preinstall
	${SHELL} ${MKFILE_DIR}/script/dunst.sh
	stow --target=${HOME} dunst

.PHONY: clean
clean:  preinstall clean-nvim
	stow --delete --target=${HOME} fish gdb tmux alacritty mc i3 polybar rofi

.PHONY: preinstall
preinstall:
	${SHELL} ${MKFILE_DIR}/script/preinstall.sh
	${SHELL} ${MKFILE_DIR}/script/stow.sh
