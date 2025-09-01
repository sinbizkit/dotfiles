SHELL := /bin/bash
TARGET_DIR := $(HOME)
MKFILE_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

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
install-fish: preinstall install-stow
	${SHELL} ${MKFILE_DIR}/script/fish.sh
	stow --target=${TARGET_DIR} fish

.PHONY: install-nvim
install-nvim: preinstall install-stow
	${SHELL} ${MKFILE_DIR}/script/nvim.sh
	stow --target=${TARGET_DIR} nvim

.PHONY: install-tmux
install-tmux: preinstall install-stow
	${SHELL} ${MKFILE_DIR}/script/tmux.sh
	stow --target=${TARGET_DIR} tmux

.PHONY: install-alacritty
install-alacritty: preinstall install-stow install-lf
	${SHELL} ${MKFILE_DIR}/script/alacritty.sh
	stow --target=${TARGET_DIR} alacritty

.PHONY: install-i3
install-i3: preinstall install-stow
	${SHELL} ${MKFILE_DIR}/script/i3.sh
	stow --target=${TARGET_DIR} i3 polybar rofi

.PHONY: install-lf
install-lf: preinstall install-stow install-fzf
	${SHELL} ${MKFILE_DIR}/script/lf.sh
	stow --adopt --target=${TARGET_DIR} lf

.PHONY: install-fzf
install-fzf: preinstall install-fd
	${SHELL} ${MKFILE_DIR}/script/fzf.sh

.PHONY: install-fd
install-fd: preinstall
	${SHELL} ${MKFILE_DIR}/script/fd.sh

.PHONY: install-dunst
install-dunst: preinstall
	${SHELL} ${MKFILE_DIR}/script/dunst.sh
	stow --target=${TARGET_DIR} dunst

install-stow: preinstall
	${SHELL} ${MKFILE_DIR}/script/stow.sh

.PHONY: clean
clean:  preinstall
	stow --delete --target=${TARGET_DIR} fish nvim gdb tmux alacritty mc i3 polybar rofi

preinstall:
	${SHELL} ${MKFILE_DIR}/script/preinstall.sh
