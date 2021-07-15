#!/bin/bash


SDIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
SDIR := $(patsubst %/, %, $(SDIR))


all: install-vim install-gdb install-tmux install-alacritty


# vim.
install-vim: mkdir-vim install-vim-vimrc install-vim-cocrc install-vim-after install-vim-autoload \
	install-vim-ftplugin install-vim-snippets install-vim-plug update-vim-plugins

mkdir-vim:
	mkdir -p ${HOME}/.config/nvim

install-vim-vimrc: mkdir-vim
	ln -sf ${SDIR}/vim/init.vim ${HOME}/.config/nvim/init.vim

install-vim-cocrc:
	ln -sf ${SDIR}/vim/coc-settings.json ${HOME}/.config/nvim/coc-settings.json

install-vim-after: mkdir-vim
	ln -sdf ${SDIR}/vim/after ${HOME}/.config/nvim/

install-vim-autoload: mkdir-vim
	ln -sdf ${SDIR}/vim/autoload ${HOME}/.config/nvim/

install-vim-ftplugin: mkdir-vim
	ln -sdf ${SDIR}/vim/ftplugin ${HOME}/.config/nvim/

install-vim-snippets: mkdir-vim
	ln -sdf ${SDIR}/vim/UltiSnips ${HOME}/.config/nvim/

install-vim-plug: mkdir-vim
	curl -fLo ${SDIR}/vim/autoload/plug.vim \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

update-vim-plugins:
	nvim +PlugUpdate +qa

# gdb.
install-gdb: install-gdb-pretty-printers
	mkdir -p ${HOME}/.config/gdb
	ln -sf ${SDIR}/gdb/3rdparty/dashboard/.gdbinit ${HOME}/.config/gdb/dashboard
	ln -sf ${SDIR}/gdb/gdbinit ${HOME}/.gdbinit

install-gdb-pretty-printers:
	mkdir -p ${HOME}/.local/share/gdb/qt5
	git clone https://invent.kde.org/ebuka/gdb_printers.git ${HOME}/.local/share/gdb/qt5
	svn co svn://gcc.gnu.org/svn/gcc/trunk/libstdc++-v3/python ${HOME}/.local/share/gdb/stl

# tmux.
install-tmux:
	ln -sf ${SDIR}/tmux/tmux.conf ${HOME}/.tmux.conf
	mkdir -p ${HOME}/.tmux/plugins
	ln -sdf ${SDIR}/tmux/3rdparty/tpm ${HOME}/.tmux/plugins/

# alacritty.
install-alacritty:
	mkdir -p ${HOME}/.config/alacritty
	ln -sf ${SDIR}/alacritty/alacritty.yml ${HOME}/.config/alacritty/alacritty.yml

# Midnight Commander.
install-mc:
	mkdir -p ${HOME}/.config/mc
	ln -sf ${SDIR}/mc/ini ${HOME}/.config/mc/ini
