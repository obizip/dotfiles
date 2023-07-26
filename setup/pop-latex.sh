cd Downloads
wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
tar xvf install-tl-unx.tar.gz

cd install-tl-2*

# repository is option
sudo ./install-tl -repository http://mirror.ctan.org/systems/texlive/tlnet/
# you have to install mathscience and latexextra
# install doc file and src file is not required 
# ref texlive-ja(https://github.com/Paperist/texlive-ja/blob/main/debian/texlive.profile)


# sudo /usr/local/texlive/????/bin/*/tlmgr path add
sudo /usr/local/texlive/2023/bin/x86_64-linux/tlmgr path add

sudo tlmgr install latexmk

# install latexindent
# https://command-not-found.com/latexindent
sudo apt install latex-extra-utils
