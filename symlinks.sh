if [ ! -e ~/.config/nvim ] && [ ! -L ~/.config/nvim ]; then
    ln -s $PWD/. ~/.config/nvim
fi
