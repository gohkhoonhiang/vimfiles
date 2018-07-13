git submodule init && git submodule update

for FOLDER in .swp installed_plugins bundle;
do
    if [ ! -e "${FOLDER}" ]; then
        mkdir ${FOLDER}
    fi
done

if [ ! -e venv2 ]; then
    virtualenv -p python venv2
fi
if [ ! -e venv3 ]; then
    virtualenv -p python3 venv3
fi

for PENV in venv2 venv3; do
    . ${PENV}/bin/activate
    pip install neovim jedi
done

if [ ! -e "init.vim" ]; then
    ln -s .vimrc init.vim
fi

pushd $HOME
if [ ! -e ".vim" ]
    ln -s ~/.vimfiles .vim
fi
if [ ! -e ".vimrc" ]
    ln -s ~/.vimfiles/.vimrc .vimrc
fi
popd

CONFIG_FDR="$HOME/.config"
mkdir -p "${CONFIG_FDR}"
pushd ${CONFIG_FDR}
if [ ! -e "nvim" ]; then
    ln -s ~/.vim nvim
fi
popd
