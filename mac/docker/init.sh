brew install xhyve docker docker-machine docker-compose ssh-copy-id 
brew link --overwrite docker-machine
brew install docker-machine-driver-xhyve
echo ""
echo "请输入 sudo 密码"
sudo chown root:wheel $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve
sudo chmod u+s $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve


ROOT=/Users/$USER/docker
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


export XHYVE_EXPERIMENTAL_NFS_SHARE=1
docker-machine create default --driver xhyve 
docker-machine start

eval "$(docker-machine env default)"

DOCKER=$PREFIX/docker
$DOCKER/build.sh

echo "Try docker run ..."
dao pull catatnight/postfix
docker run -e maildomain=mail.xtco2o.com -e smtp_user=macxuser:x51ymmux --name postfix -d catatnight/postfix 
docker run -d -v $ROOT/home:/home \
    -v $ROOT/var/log:/var/log \
    -v $ROOT/tmp:/tmp  \
    -v $ROOT/root:/root  \
    -v $ROOT/var/lib/redis:/var/lib/redis \
    -v $ROOT/var/lib/mongodb:/var/lib/mongodb \
    -v $ROOT/var/lib/mlocate:/var/lib/mlocate \
    -v $ROOT/data:/data \
    --link postfix:postfix \
    --name tz \
    -p 20000:22 -p 20001-20100:20001-20100 -p 8081-8082:8081-8082 -p 80:80 -p 443:443 \
    tz/world

IP=`docker-machine ip`
echo "DOCKER IP = "$IP
echo ""
echo "请输入密码 TZworld"
echo ""
ssh-copy-id -p20000 dev@$IP
