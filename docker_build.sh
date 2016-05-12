PREFIX=$(cd "$(dirname "$0")"; pwd)
cd $PREFIX/docker
docker build -t="tz/world" .


