PREFIX=$(cd "$(dirname "$0")"; pwd)

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
sudo echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
sudo apt-get update
sudo apt-get install -y --allow-unauthenticated mongodb-org
sudo rm /etc/mongod.conf
sudo ln -s $PREFIX/config/mongod.conf /etc/

grep "mongodb " /etc/rc.local||sed "$i sudo -u mongodb /usr/bin/mongod  --config /etc/mongod.conf --fork" /etc/rc.local 
sudo -u mongodb /usr/bin/mongod  --config /etc/mongod.conf --fork

