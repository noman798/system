# 先修改 /etc/mongo.conf 为 disabled 然后运行这个脚本， 然后再改回去，重启 mongodb
# security:
#     # authorization : disabled
#     authorization : enabled

echo 'db.createUser( { user: "root", pwd: "ce9tLyQdAMhtutBJ", roles: [ { role: "userAdminAnyDatabase", db: "admin" } ] })' | mongo admin --port 20100
