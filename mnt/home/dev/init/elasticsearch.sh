PREFIX=$(cd "$(dirname "$0")"; pwd)

sudo apt-get update -y
sudo apt-get upgrade -y

sudo apt-get install software-properties-common -y

sudo add-apt-repository ppa:webupd8team/java -y
sudo apt-get update -y
sudo apt-get install oracle-java8-installer maven -y

wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://packages.elastic.co/elasticsearch/2.x/debian stable main" | sudo tee -a /etc/apt/sources.list.d/elasticsearch-2.x.list


sudo apt-get update -y
sudo apt-get install elasticsearch -y
mkdir -p ~/download
cd ~/download


wget -c https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v1.9.3/elasticsearch-analysis-ik-1.9.3.zip


sudo mkdir -p /var/log/elasticsearch /data/elasticsearch
sudo chown elasticsearch:elasticsearch /var/log/elasticsearch 
sudo chown elasticsearch:elasticsearch /data/elasticsearch

cd /usr/share/elasticsearch
sudo bin/plugin install file:/home/$USER/download/elasticsearch-analysis-ik-1.9.3.zip

sudo cp $PREFIX/config/elasticsearch.yml /etc/elasticsearch

sudo rm -rf /usr/share/elasticsearch/plugins/analysis-ik/config
sudo ln -s /etc/elasticsearch/analysis-ik /usr/share/elasticsearch/plugins/analysis-ik/config


rm /etc/supervisor/conf.d/elasticsearch.conf
sudo ln -s $PREFIX/supervisord/elasticsearch.conf /etc/supervisor/conf.d/
sudo supervisorctl reload 
sudo supervisorctl restart all
