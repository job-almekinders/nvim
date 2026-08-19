if [ ! -e ~/.config/nvim ] && [ ! -L ~/.config/nvim ]; then
    echo "linking..."
    ln -s $PWD/. ~/.config/nvim
else
    echo "already linked."
fi
