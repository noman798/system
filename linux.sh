ROOT=/data/tzonline

PREFIX=$(cd "$(dirname "$0")"; pwd)/../..

mkdir -p $ROOT
rsync -avC $PREFIX/mnt/ $ROOT/
rsync -avC $ROOT/root/ $ROOT/home/dev/
sudo cp ~/.ssh/* ~/docker/home/dev/.ssh/*

cd $ROOT
mkdir -p var/log \
    var/lib/redis \
    var/lib/mongodb \
    var/lib/mlocate \
    data \
    tmp
sudo chown -R 1000 $ROOT
