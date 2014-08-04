all:

link:
	ln -sf ${PWD}/vimrc ~/.vimrc
	ln -sf ${PWD} ~/.vim/bundle/dotvim

thesaurus:
	wget http://www.gutenberg.org/dirs/etext02/mthes10.zip
	mkdir -p mthes10
	unzip mthes10.zip -d mthes10
