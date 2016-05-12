docker-machine start
eval "$(docker-machine env default)"

PREFIX=$(cd "$(dirname "$0")"; pwd)
$PREFIX/../docker/build.sh

BASE=/Users/$USER/dev
cp -R $PREFIX/home $BASE

ROOT=$BASE/.root
mkdir -p $ROOT
cd $ROOT
mkdir -p var/log \
    var/lib/redis \
    var/lib/mongodb \
    var/lib/mlocate \
    tmp
docker run -d -v $ROOT:/home/dev \
    -v $ROOT/var/log:/var/log \
    -v $ROOT/tmp:/tmp  \
    -v $ROOT/var/lib/redis:/var/lib/redis \
    -v $ROOT/var/lib/mongodb:/var/lib/mongodb \
    -v $ROOT/var/lib/mlocate:/var/lib/mlocate \
    --name dev \
    -p 20000:22 -p 20001-20100:20001-20100 -p 8081-8082:8081-8082 80:80 443:443 \
    tz/world