#!/bin/bash


SDIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
SDIR := $(patsubst %/, %, $(SDIR))


all: install


install: install-fish install-nvim install-gdb install-tmux install-alacritty install-i3 install-mc

install-fish:
	stow fish

install-nvim:
	stow nvim
	rm -rf ${HOME}/.local/share/nvim/site/pack/packer/start/packer.nvim
	git clone -q --depth 1 https://github.com/wbthomason/packer.nvim \
		${HOME}/.local/share/nvim/site/pack/packer/start/packer.nvim

install-gdb:
	rm -rf ${HOME}/.local/share/gdb/qt5
	mkdir -p ${HOME}/.local/share/gdb/qt5
	git clone https://invent.kde.org/ebuka/gdb_printers.git ${HOME}/.local/share/gdb/qt5
	svn co svn://gcc.gnu.org/svn/gcc/trunk/libstdc++-v3/python ${HOME}/.local/share/gdb/stl
	stow gdb

install-tmux:
	stow tmux

install-alacritty:
	stow alacritty

install-i3:
	stow i3 polybar rofi

install-mc:
	stow --adopt mc


clean:
	stow --delete fish nvim gdb tmux alacritty mc i3 polybar rofi
