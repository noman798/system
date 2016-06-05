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


wget https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v1.9.3/elasticsearch-analysis-ik-1.9.3.zip

sudo bin/plugin install file:~/download/elasticsearch-analysis-ik-1.9.3.zip


