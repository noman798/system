brew install docker docker-compose docker-machine
brew cask install virtualbox
brew install bash-completion
docker-machine create
docker-machine start
eval "$(docker-machine env default)"

PREFIX=$(cd "$(dirname "$0")"; pwd)/..


ROOT=/Users/$USER/docker

mkdir -p $ROOT
rsync -avC $PREFIX/mnt/ $ROOT/
rsync -avC $ROOT/root/ $ROOT/home/dev/

cd $ROOT
mkdir -p var/log \
    var/lib/redis \
    var/lib/mongodb \
    var/lib/mlocate \
    data \
    tmp


DOCKER=$PREFIX/docker
$DOCKER/build.sh
echo "BUILDED !!!"
echo "Try docker run ..."
docker run -d -v $ROOT/home:/home/ \
    -v $ROOT/var/log:/var/log \
    -v $ROOT/tmp:/tmp  \
    -v $ROOT/root:/root  \
    -v $ROOT/var/lib/redis:/var/lib/redis \
    -v $ROOT/var/lib/mongodb:/var/lib/mongodb \
    -v $ROOT/var/lib/mlocate:/var/lib/mlocate \
    -v $ROOT/data:/data \
    --name tz \
    -p 20000:22 -p 20001-20100:20001-20100 -p 8081-8082:8081-8082 -p 80:80 -p 443:443 \
    tz/world
