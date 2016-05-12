mkdir -p ~/dev/log
docker run -d -v ~/dev:/home/dev -v ~/dev/log:/var/log --name tz -p 20000:22 -p 20001-20100:20001-20100 -p 8081-8082:8081-8082 80:80 tz/world
