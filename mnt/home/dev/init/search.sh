sudo apt-get update
sudo apt-get upgrade

sudo apt-get install software-properties-common -y

sudo add-apt-repository ppa:webupd8team/java -y
sudo apt-get update
sudo apt-get install oracle-java8-installer maven -y

wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add -
sudo echo "deb http://packages.elasticsearch.org/elasticsearch/1.1/debian stable main" >> /etc/apt/sources.list

sudo apt-get update -y
sudo apt-get install elasticsearch -y
mkdir -p ~/download
cd ~/download

git clone https://github.com/huaban/elasticsearch-analysis-jieba
cd elasticsearch-analysis-jieba
mvn package
/usr/share/elasticsearch/plugins


