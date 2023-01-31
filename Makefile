SHELL := /bin/bash
TARGET_DIR := $(HOME)


all: install


install: install-fish install-nvim install-gdb install-tmux install-alacritty install-i3 install-mc

.PHONY: install-fish
install-fish:
	stow --target=${TARGET_DIR} fish

.PHONY: install-nvim
install-nvim:
	stow --target=${TARGET_DIR} nvim

.PHONY: install-gdb
install-gdb:
	rm -rf ${HOME}/.local/share/gdb/qt5
	mkdir -p ${HOME}/.local/share/gdb/qt5
	git clone https://invent.kde.org/ebuka/gdb_printers.git ${HOME}/.local/share/gdb/qt5
	svn co svn://gcc.gnu.org/svn/gcc/trunk/libstdc++-v3/python ${HOME}/.local/share/gdb/stl
	stow --target=${TARGET_DIR} gdb

.PHONY: install-tmux
install-tmux:
	stow --target=${TARGET_DIR} tmux

.PHONY: install-alacritty
install-alacritty:
	stow --target=${TARGET_DIR} alacritty

.PHONY: install-i3
install-i3:
	stow --target=${TARGET_DIR} i3 polybar rofi

.PHONY: install-mc
install-mc:
	stow --adopt --target=${TARGET_DIR} mc

.PHONY: clean
clean:
	stow --delete --target=${TARGET_DIR} fish nvim gdb tmux alacritty mc i3 polybar rofi
