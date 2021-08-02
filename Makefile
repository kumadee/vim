.PHONY: LPlugManager WPlugManager

LPlugManager:
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && \
	    mkdir -p ~/.vim/plugged && \
	    cp linux/.vimrc ~/.vimrc && \


WPlugManager:
	iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
	ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force


