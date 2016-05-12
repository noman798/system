PREFIX=$(cd "$(dirname "$0")"; pwd)
cd $PREFIX
docker build -t="tz/world" .


