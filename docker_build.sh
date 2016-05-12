PREFIX=$(cd "$(dirname "$0")"; pwd)
cd docker
docker build -t="tz/world" .


