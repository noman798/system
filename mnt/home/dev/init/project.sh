cd ~

curl -fsS https://dlang.org/install.sh | bash -s dmd

hg clone ssh://hg@bitbucket.org/vcwatch/tz

pip install -r ~/tz/code/py/requirement.txt
cd ~/tz/cli/docker
cp config.example.py config.py 
python make_config.py


cd ~/tz/cli
./install





cd ~
hg clone ssh://hg@bitbucket.org/vcwatch/system
hg clone ssh://hg@bitbucket.org/noman798/room

grep "PYTHONPATH=/home/dev/tz/code/py" ~/.bashrc ||echo "export PYTHONPATH=/home/dev/tz/code/py:\$PYTHONPATH" >>  ~/.bashrc
source ~/.bashrc
