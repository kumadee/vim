.PHONY: LPlugManager WPlugManager

# Only for linux
LPlugManager:
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && \
	    mkdir -p ~/.vim/plugged && \
	    cp linux/.vimrc ~/.vimrc && \
	    cp linux/plugins.vim ~/.vim/plugins.vim

# Only for windows
WPlugManager:
	iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
	ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force

build-nvim:
	cd nvim && podman build . -t localhost/nvim:latest

start-nvim:
	podman volume create --ignore nvim && \
		podman run --rm -it -v nvim:/root -v .:/code:Z localhost/nvim:latest
