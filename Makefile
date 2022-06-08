#!/bin/bash


TARGET_DIR := $(HOME)


all: install


install: install-fish install-nvim install-gdb install-tmux install-alacritty install-i3 install-mc

install-fish:
	stow --target=${TARGET_DIR} fish

install-nvim:
	stow --target=${TARGET_DIR} nvim
	rm -rf ${HOME}/.local/share/nvim/site/pack/packer/start/packer.nvim
	git clone -q --depth 1 https://github.com/wbthomason/packer.nvim \
		${HOME}/.local/share/nvim/site/pack/packer/start/packer.nvim

install-gdb:
	rm -rf ${HOME}/.local/share/gdb/qt5
	mkdir -p ${HOME}/.local/share/gdb/qt5
	git clone https://invent.kde.org/ebuka/gdb_printers.git ${HOME}/.local/share/gdb/qt5
	svn co svn://gcc.gnu.org/svn/gcc/trunk/libstdc++-v3/python ${HOME}/.local/share/gdb/stl
	stow --target=${TARGET_DIR} gdb

install-tmux:
	stow --target=${TARGET_DIR} tmux

install-alacritty:
	stow --target=${TARGET_DIR} alacritty

install-i3:
	stow --target=${TARGET_DIR} i3 polybar rofi

install-mc:
	stow --adopt --target=${TARGET_DIR} mc


clean:
	stow --delete --target=${TARGET_DIR} fish nvim gdb tmux alacritty mc i3 polybar rofi
