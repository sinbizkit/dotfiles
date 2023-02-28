SHELL := /bin/bash
TARGET_DIR := $(HOME)
MKFILE_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

all: install


install: install-fish \
	install-nvim \
	install-gdb \
	install-tmux \
	install-alacritty \
	install-i3 \
	install-mc \
	install-lf \
	install-fzf \
	install-fd

.PHONY: install-fish
install-fish: preinstall install-stow
	${SHELL} ${MKFILE_DIR}/script/fish.sh
	stow --target=${TARGET_DIR} fish

.PHONY: install-nvim
install-nvim: preinstall install-stow
	${SHELL} ${MKFILE_DIR}/script/nvim.sh
	stow --target=${TARGET_DIR} nvim

.PHONY: install-gdb
install-gdb:
	rm -rf ${HOME}/.local/share/gdb/qt5
	mkdir -p ${HOME}/.local/share/gdb/qt5
	git clone https://invent.kde.org/ebuka/gdb_printers.git ${HOME}/.local/share/gdb/qt5
	svn co svn://gcc.gnu.org/svn/gcc/trunk/libstdc++-v3/python ${HOME}/.local/share/gdb/stl
	stow --target=${TARGET_DIR} gdb

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

install-stow: preinstall
	${SHELL} ${MKFILE_DIR}/script/stow.sh

.PHONY: clean
clean:
	stow --delete --target=${TARGET_DIR} fish nvim gdb tmux alacritty mc i3 polybar rofi

preinstall:
	${SHELL} ${MKFILE_DIR}/script/preinstall.sh
