# 先修改 /etc/mongo.conf 为 disabled 然后运行这个脚本， 然后再改回去，重启 mongodb
# security:
#     # authorization : disabled
#     authorization : enabled

mongo admin --port 20100 --eval 'db.createUser( { user: "root", pwd: "ce9tLyQdAMhtutBJ", roles: [ { role: "userAdminAnyDatabase", db: "admin" } ] })' 
mongo tzdev --port 20100 --eval 'db.createUser({ user: "dev", pwd: "JOlSVJvKCzxvDAwV", roles: [ { role: "readWrite", db: "tzdev" } ] });' 
