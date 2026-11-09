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
	${SHELL} ${MKFILE_DIR}/script/nvim/install.sh
	stow --target=${CONFIG_DIR} nvim

.PHONY: uninstall-nvim
uninstall-nvim:
	${SHELL} ${MKFILE_DIR}/script/nvim/uninstall.sh
	stow --delete --target=${CONFIG_DIR} nvim

.PHONY: install-tmux
install-tmux:
	${SHELL} ${MKFILE_DIR}/script/tmux/install.sh
	stow --target=${HOME} tmux

.PHONY: uninstall-tmux
uninstall-tmux:
	${SHELL} ${MKFILE_DIR}/script/tmux/uninstall.sh
	stow --delete --target=${HOME} tmux

.PHONY: install-alacritty
install-alacritty: preinstall
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
install-lf: preinstall github
	${SHELL} ${MKFILE_DIR}/script/lf/install.sh
	stow --target=${CONFIG_DIR} lf

.PHONY: uninstall-lf
uninstall-lf:
	${SHELL} ${MKFILE_DIR}/script/lf/uninstall.sh
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
clean:  preinstall uninstall-nvim
	stow --delete --target=${HOME} fish gdb tmux alacritty mc i3 polybar rofi

.PHONY: preinstall
preinstall:
	${SHELL} ${MKFILE_DIR}/script/preinstall.sh
	${SHELL} ${MKFILE_DIR}/script/stow.sh
