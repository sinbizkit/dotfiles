#!/bin/bash


SDIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
SDIR := $(patsubst %/, %, $(SDIR))


all: install


install: install-nvim install-gdb install-tmux install-alacritty install-i3 install-mc


# vim.
install-nvim:
	curl -fLo ${SDIR}/nvim/.config/nvim/autoload/plug.vim \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	stow nvim

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
	stow i3 polybar

install-mc:
	stow --adopt mc


clean:
	stow --delete nvim gdb tmux alacritty mc i3 polybar
