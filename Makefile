SHELL := /bin/bash
LOCAL_DIR := ${HOME}/.local
CONFIG_DIR := ${HOME}/.config
PICS_DIR := ${HOME}/Pictures
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

.PHONY: install-sway
install-sway: preinstall
	${SHELL} ${MKFILE_DIR}/script/sway/install.sh
	stow --target=${CONFIG_DIR} sway
	stow --target=${CONFIG_DIR} swaylock
	mkdir -p ${PICS_DIR} && stow --target=${PICS_DIR} img

.PHONY: uninstall-sway
uninstall-sway:
	${SHELL} ${MKFILE_DIR}/script/sway/uninstall.sh
	stow --delete --target=${CONFIG_DIR} sway
	stow --delete --target=${CONFIG_DIR} swaylock
	stow --delete --target=${PICS_DIR} img

.PHONY: install-waybar
install-waybar:
	${SHELL} ${MKFILE_DIR}/script/waybar/install.sh
	stow --target=${CONFIG_DIR} waybar
	
.PHONY: uninstall-waybar
uninstall-waybar:
	${SHELL} ${MKFILE_DIR}/script/waybar/uninstall.sh
	stow --delete --target=${CONFIG_DIR} waybar

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
	${SHELL} ${MKFILE_DIR}/script/fzf/fzf.sh

.PHONY: clean-fzf
clean-fzf:
	stow --delete --dir=${MKFILE_DIR}/script/fzf --target=${LOCAL_DIR} .root
	rm -rf ${MKFILE_DIR}/script/fzf/.root

.PHONY: install-fd
install-fd: preinstall
	${SHELL} ${MKFILE_DIR}/script/fd.sh

.PHONY: clean-fd
clean-fd:
	sudo apt purge -y fd-musl

.PHONY: install-dunst
install-dunst: preinstall
	${SHELL} ${MKFILE_DIR}/script/dunst/install.sh
	stow --target=${CONFIG_DIR} dunst

.PHONY: uninstall-dunst
uninstall-dunst:
	${SHELL} ${MKFILE_DIR}/script/dunst/uninstall.sh
	stow --delete --target=${CONFIG_DIR} dunst

.PHONY: install-xdg-desktop-portal-wlr
install-xdg-desktop-portal-wlr: preinstall
	sudo apt install -y xdg-desktop-portal libdrm2 libgbm1 libinih1 libpipewire-0.3-0 libwayland-client0 pipewire
	${SHELL} ${MKFILE_DIR}/script/xdg-desktop-portal-wlr/install.sh

uninstall-xdg-desktop-portal-wlr:
	${SHELL} ${MKFILE_DIR}/script/xdg-desktop-portal-wlr/uninstall.sh

.PHONY: github
github:
	${SHELL} ${MKFILE_DIR}/script/github.sh

.PHONY: preinstall
preinstall:
	${SHELL} ${MKFILE_DIR}/script/preinstall.sh
	${SHELL} ${MKFILE_DIR}/script/stow.sh
