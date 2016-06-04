sudo apt-get update
sudo apt-get upgrade

sudo apt-get install software-properties-common -y

sudo add-apt-repository ppa:webupd8team/java -y
sudo apt-get update
sudo apt-get install oracle-java9-installer -y

wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add -
sudo echo "deb http://packages.elasticsearch.org/elasticsearch/1.1/debian stable main" >> /etc/apt/sources.list

sudo apt-get update -y
sudo apt-get install elasticsearch -y
