#!/bin/bash


SDIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))


install-vim:
	mkdir -p ${HOME}/.config/nvim
	ln -sf ${SDIR}/vim/init.vim ${HOME}/.config/nvim/init.vim
	ln -sf ${SDIR}/vim/coc-settings.json ${HOME}/.config/nvim/coc-settings.json
	ln -sf ${SDIR}/vim/functions.vim ${HOME}/.config/nvim/functions.vim
	ln -sfd ${SDIR}/vim/ftplugin ${HOME}/.config/nvim/ftplugin
	ln -sfd ${SDIR}/vim/UltiSnips ${HOME}/.config/nvim/UltiSnips
	curl -fLo ${HOME}/.config/nvim/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	nvim +PlugUpdate +qa
