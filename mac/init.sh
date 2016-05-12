docker-machine start
eval "$(docker-machine env default)"

PREFIX=$(cd "$(dirname "$0")"; pwd)/..
DOCKER=$PREFIX/docker

$DOCKER/build.sh

ROOT=/Users/$USER/mnt

mkdir -p $ROOT
cp -R $PREFIX/mnt $ROOT
cp -R $ROOT/root $ROOT/home/dev

cd $ROOT
mkdir -p var/log \
    var/lib/redis \
    var/lib/mongodb \
    var/lib/mlocate \
    tmp
docker run -d -v $BASE:/home/ \
    -v $ROOT/var/log:/var/log \
    -v $ROOT/tmp:/tmp  \
    -v $ROOT/root:/root  \
    -v $ROOT/var/lib/redis:/var/lib/redis \
    -v $ROOT/var/lib/mongodb:/var/lib/mongodb \
    -v $ROOT/var/lib/mlocate:/var/lib/mlocate \
    --name dev \
    -p 20000:22 -p 20001-20100:20001-20100 -p 8081-8082:8081-8082 80:80 443:443 \
    tz/world
