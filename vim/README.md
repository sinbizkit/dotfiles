# NeoVim`s configuration files.

## Installation.

- Neovim.

~~~bash
git clone https://github.com/neovim/neovim
make CMAKE_BUILD_TYPE=Release -j4
1.3 sudo make install
~~~
>It may require *libtool, libtool-bin* installation.

- vim-plug
~~~bash
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
~~~
- update-alternatives (optional)
~~~bash
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
sudo update-alternatives --config vi
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
sudo update-alternatives --config vim
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
sudo update-alternatives --config editor
~~~