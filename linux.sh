ROOT=/home/tzol

PREFIX=$(cd "$(dirname "$0")"; pwd)

mkdir -p $ROOT
rsync -avC $PREFIX/mnt/ $ROOT/
rsync -avC $ROOT/root/ $ROOT/home/dev/
sudo cp ~/.ssh  $ROOT/

cd $ROOT
mkdir -p var/log \
    var/lib/redis \
    var/lib/mongodb \
    var/lib/mlocate \
    data \
    tmp
sudo chown -R 1000 $ROOT
