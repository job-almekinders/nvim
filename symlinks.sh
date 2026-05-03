if [ ! -e ~/.config/nvim ] && [ ! -L ~/.config/nvim ]; then
    ln -s ~/repos/main/nvim ~/.config/nvim
fi
