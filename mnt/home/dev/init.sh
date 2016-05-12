PREFIX=$(cd "$(dirname "$0")"; pwd)/..


cd ~ 
virtualenv -p /usr/bin/python3 /home/dev/.py3env

mkdir download
cd download

git clone https://github.com/wting/autojump.git
cd autojump
./install.py
source ~/.bashrc




