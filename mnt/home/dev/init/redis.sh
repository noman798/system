PREFIX=$(cd "$(dirname "$0")"; pwd)
cd $PREFIX

wget http://download.redis.io/redis-stable.tar.gz
tar zxvf redis-stable.tar.gz
rm redis-stable.tar.gz
cd redis-stable
make
sudo make install
cd $PREFIX
rm -rf redis-stable

sudo useradd redis
sudo chown redis /var/lib/redis/
sudo mkdir -p /etc/redis
sudo cp $PREFIX/config/redis*.conf /etc/redis

sudo ln -s $PREFIX/supervisord/redis*.conf /etc/supervisor/conf.d/
sudo supervisorctl reload 
sudo supervisorctl restart all
