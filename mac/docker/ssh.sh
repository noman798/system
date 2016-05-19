docker-machine start
eval "$(docker-machine env default)"
docker start tz

IP=`docker-machine ip`
echo "DOCKER IP = "$IP
ssh -p20000 dev@$IP
