PREFIX=$(cd "$(dirname "$0")"; pwd)
cd $PREFIX

wget `curl -s https://api.github.com/repos/openresty/openresty/tags | grep zipball_url | head -n 1 | cut -d '"' -f 4` -O openresty.zip -c
unzip openresty.zip
rm openresty.zip
cd openresty-*/
make try-luajit
cd openresty-*/
./configure
make && sudo make install

# cd redis-stable
# make
# sudo make install
# cd $PREFIX
# rm -rf redis-stable

