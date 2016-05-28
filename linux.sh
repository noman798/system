VERSION=master-bcd02ab

ROOT=/home/tzol
PREFIX=$(cd "$(dirname "$0")"; pwd)

mkdir -p $ROOT
rsync -avC $PREFIX/mnt/ $ROOT/
rsync -avC $ROOT/root/ $ROOT/home/dev/
sudo cp -R ~/.ssh  $ROOT/

cd $ROOT
mkdir -p var/log \
    var/lib/redis \
    var/lib/mongodb \
    var/lib/mlocate \
    var/log/supervisor \
    data \
    tmp

sudo chown -R 1000 $ROOT

docker pull daocloud.io/zuroc/tz:$VERSION
echo "DOCKER RUN"
docker run -d -v $ROOT/home:/home \
    -v $ROOT/var/log:/var/log \
    -v $ROOT/tmp:/tmp  \
    -v $ROOT/root:/root  \
    -v $ROOT/var/lib/redis:/var/lib/redis \
    -v $ROOT/var/lib/mongodb:/var/lib/mongodb \
    -v $ROOT/var/lib/mlocate:/var/lib/mlocate \
    -v $ROOT/data:/data \
    --name tzol \
    -p 30000:22 -p 30001-30100:30001-30100 -p 30101-30102:8081-8082 -p 30103:80 -p 30104:443 \
    daocloud.io/zuroc/tz:$VERSION
