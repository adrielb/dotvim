XDG_NVIM=~/.config/nvim

all:

link:
	ln -sf ${PWD} ${XDG_NVIM}

thesaurus:
	wget http://www.gutenberg.org/dirs/etext02/mthes10.zip
	mkdir -p mthes10
	unzip mthes10.zip -d mthes10

vim-plug:
	curl -fLo ${XDG_NVIM}/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

profile:
	nvim --startuptime /tmp/vim.log +qall
	nvim /tmp/vim.log
