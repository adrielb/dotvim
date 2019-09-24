" syntax clear
syntax match mdMoDay "\(Oct\|Nov\) \(\d\d\|\d\)"
syntax match mdNumber	"\d\+"
syntax match mdDate "\d\d\d\d-\d\d-\d\d"
syntax match mdDollar "$\d\+[TBM]"
highlight link mdMoDay  GruvboxOrangeBold
highlight link mdDate GruvboxOrangeBold
highlight link mdNumber GruvboxAquaBold
highlight link mdDollar GruvboxAquaBold
