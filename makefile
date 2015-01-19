all:

link:
	ln -sf ${PWD}/vimrc ~/.vimrc
	ln -sf ${PWD} ~/.vim/bundle/dotvim
	ln -sf ${PWD}/nvimrc ~/.nvimrc

thesaurus:
	wget http://www.gutenberg.org/dirs/etext02/mthes10.zip
	mkdir -p mthes10
	unzip mthes10.zip -d mthes10

vim-plug:
	mkdir -p ~/.nvim/autoload
	curl -fLo ~/.nvim/autoload/plug.vim \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
