XDG_NVIM=~/.config/nvim

all:

link:
	ln -sf ${PWD}/vimrc ~/.vimrc
	ln -sf ${PWD}/nvimrc ${XDG_NVIM}/init.vim
	ln -sf ${PWD} ~/.vim/bundle/dotvim

thesaurus:
	wget http://www.gutenberg.org/dirs/etext02/mthes10.zip
	mkdir -p mthes10
	unzip mthes10.zip -d mthes10

vim-plug:
	curl -fLo ${XDG_NVIM}/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
