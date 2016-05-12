
mkdir ~/.hgplugin
curl https://bitbucket.org/GrahamHelliwell/hg-sync/raw/cdb1d3f0ca68766d775746b02b301547ce3af0df/sync.py > ~/.hgplugin/sync.py

virtualenv -p /usr/bin/python3 /home/dev/.py3env
git clone https://github.com/wting/autojump.git
cd autojump
./install.py



