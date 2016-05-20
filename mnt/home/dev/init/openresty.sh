PREFIX=$(cd "$(dirname "$0")"; pwd)
cd /tmp

rm openresty.zip
rm -rf openresty-

wget `curl -s https://api.github.com/repos/openresty/openresty/tags | grep zipball_url | head -n 1 | cut -d '"' -f 4` -O openresty.zip -c
unzip openresty.zip
rm openresty.zip
cd openresty-*/
make try-luajit
cd openresty-*/
./configure --with-luajit
make && sudo make install
sudo useradd nginx


sudo mkdir -p /var/log/nginx /etc/nginx/conf.d/
sudo chown -R nginx:nginx /var/log/nginx /etc/nginx

cp $PREFIX/config/nginx.conf /etc/nginx/
rm /usr/local/openresty/nginx/conf/nginx.conf
ln -s /etc/nginx/nginx.conf /usr/local/openresty/nginx/conf/nginx.conf

cd $PREFIX
rm -rf openresty-


sudo ln -s $PREFIX/supervisord/nginx.conf /etc/supervisor/conf.d/
sudo supervisorctl reload 
sudo supervisorctl restart nginx 
