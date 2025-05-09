#!/bin/bash

# This script is meant to be run inside the
# text-workflows-install-container to configure paths and memory.

# Paths for root and vscode users.
echo "MANPATH=$MANPATH:/usr/local/texlive/${TEX_YEAR}/texmf-dist/doc/man" >> ~/.bashrc
echo "INFOPATH=$INFOPATH:/usr/local/texlive/${TEX_YEAR}/texmf-dist/doc/info" >> ~/.bashrc
echo "PATH=$PATH:/usr/local/texlive/${TEX_YEAR}/bin/x86_64-linux" >> ~/.bashrc

echo "MANPATH=$MANPATH:/usr/local/texlive/${TEX_YEAR}/texmf-dist/doc/man" >> /home/vscode/.bashrc
echo "INFOPATH=$INFOPATH:/usr/local/texlive/${TEX_YEAR}/texmf-dist/doc/info" >> /home/vscode/.bashrc
echo "PATH=$PATH:/usr/local/texlive/${TEX_YEAR}/bin/x86_64-linux" >> /home/vscode/.bashrc

. ~/.bashrc

# Memory config.
cp /ext/assets/texmf.cnf /usr/local/texlive/$TEX_YEAR/texmf.cnf

/usr/local/texlive/$TEX_YEAR/bin/x86_64-linux/fmtutil-sys --all

# Spanish and english hack for XINDY.
cd /usr/local/texlive/$TEX_YEAR/texmf-dist/xindy/modules/lang/spanish/
ln -s modern-utf8-lang.xdy utf8-lang.xdy
ln -s modern-utf8-test.xdy utf8-test.xdy
ln -s modern-utf8.xdy utf8.xdy
