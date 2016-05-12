PREFIX=$(cd "$(dirname "$0")"; pwd)

ROOT=~/dev
cp -R $PREFIX/home $ROOT 
mkdir -p $ROOT/.log $ROOT/.tmp
docker run -d -v $ROOT:/home/dev -v $ROOT/.log:/var/log -v $ROOT/.tmp:/tmp  --name dev -p 20000:22 -p 20001-20100:20001-20100 -p 8081-8082:8081-8082 80:80 tz/world
