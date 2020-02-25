#!/bin/bash


SDIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
SDIR := $(patsubst %/, %, $(SDIR))


all: install-vim install-gdb install-tmux


install-vim:
	mkdir -p ${HOME}/.config/nvim
	ln -sf ${SDIR}/vim/init.vim ${HOME}/.config/nvim/init.vim
	ln -sf ${SDIR}/vim/coc-settings.json ${HOME}/.config/nvim/coc-settings.json
	ln -sf ${SDIR}/vim/functions.vim ${HOME}/.config/nvim/functions.vim
	ln -sdf ${SDIR}/vim/ftplugin ${HOME}/.config/nvim/
	ln -sdf ${SDIR}/vim/UltiSnips ${HOME}/.config/nvim/
	curl -fLo ${HOME}/.config/nvim/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	nvim +PlugUpdate +qa


install-gdb: install-gdb-pretty-printers
	mkdir -p ${HOME}/.config/gdb
	ln -sf ${SDIR}/gdb/3rdparty/dashboard/.gdbinit ${HOME}/.config/gdb/dashboard
	ln -sf ${SDIR}/gdb/gdbinit ${HOME}/.gdbinit

install-gdb-pretty-printers:
	mkdir -p ${HOME}/.local/share/gdb/qt5
	curl -fLo ${HOME}/.local/share/gdb/qt5/qt.py \
		https://cgit.kde.org/kdevelop.git/plain/plugins/gdb/printers/qt.py
	curl -fLo ${HOME}/.local/share/gdb/qt5/helper.py \
		https://cgit.kde.org/kdevelop.git/plain/plugins/gdb/printers/helper.py
	svn co svn://gcc.gnu.org/svn/gcc/trunk/libstdc++-v3/python ${HOME}/.local/share/gdb/stl


install-tmux:
	ln -sf ${SDIR}/tmux/tmux.conf ${HOME}/.tmux.conf
	mkdir -p ${HOME}/.tmux/plugins
	ln -sdf ${SDIR}/tmux/3rdparty/tpm ${HOME}/.tmux/plugins/
