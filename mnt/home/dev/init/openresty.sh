PREFIX=$(cd "$(dirname "$0")"; pwd)
cd $PREFIX

wget `curl -s https://api.github.com/repos/openresty/openresty/tags | grep zipball_url | head -n 1 | cut -d '"' -f 4` -o openresty.zip

# wget http://download.redis.io/redis-stable.tar.gz
# tar zxvf redis-stable.tar.gz
# rm redis-stable.tar.gz
# cd redis-stable
# make
# sudo make install
# cd $PREFIX
# rm -rf redis-stable

