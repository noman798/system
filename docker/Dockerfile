FROM ubuntu:xenial

ENV DEBIAN_FRONTEND noninteractive

COPY bin/* /usr/bin/

# change timezone

COPY resolv.conf /etc/resolv.conf


RUN \
mkdir -p /var/run/sshd;\
locale-gen zh_CN.UTF-8;\
chmod ugo+x /usr/bin/*;\
useradd dev -m -p TZworld -s /bin/bash;\
echo "dev:TZworld" | chpasswd;\
mkdir -p /home/dev;chown dev:dev /home/dev;\
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime;\
sed -i 's/http:\/\/archive\.ubuntu\.com\/ubuntu\//http:\/\/mirrors\.ustc\.edu\.cn\/ubuntu\//g' /etc/apt/sources.list;\
apt-get update;\
set -x \
&& apt-get install -y \
software-properties-common \
curl; \
curl --silent --location https://deb.nodesource.com/setup_4.x | bash - ;\
add-apt-repository ppa:jonathonf/python-3.6 -y ;\
add-apt-repository ppa:fkrull/deadsnakes -y ; \
apt-get dist-upgrade -y

RUN apt-get clean;\
apt-get update --fix-missing; \
apt-get -y install \
postgresql postgresql-contrib postgresql-server-dev-all \
clang-format timelimit \
gettext \
net-tools \
netcat \
borgbackup \
ntpdate \
run-one \
realpath \
sudo \
dos2unix \
liblz4-tool \
bash-completion \
rsyslog \
libzbar-dev \
nmap \
doxygen \
dnsutils \
unzip \
build-essential \
cython \
iputils-ping \
clang \
cmake \
coffeescript \
dstat \
git \
git-all \
htop \
ipython \
aptitude \
libclang-dev \
libncurses5-dev \
libevent-dev \
libssl-dev \
libpcre3-dev \
libreadline-dev \
supervisor \
libjpeg-dev \
libjpeg8-dev \
libssl-dev \
lsof \
make \
mercurial \
mlocate \
nodejs \
opencc \
libopencc-dev \
openssh-client \
openssh-server \
perl \
python-dev \
python-pip \
python3.6 \
python3.6-dev \
vim \
rubygems \
silversearcher-ag \
tmux \
rpl \
tree \
rubygems-integration \
libtidy-0.99-0 \
xtail


# install frontend tools
# RUN cnpm install -g \
#RUN npm install -g cnpm --registry=https://registry.npm.taobao.org

    RUN echo "dev ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers ; \
        npm config set strict-ssl false ; \
        npm install -g \
        async-module-loader \
        js-beautify \
        avalon2 \
        babel-core \
        babel-loader \
        babel-plugin-transform-runtime \
        babel-preset-es2015 \
        babel-runtime \
        base-x \
        bluebird \
        body-parser \
        bundle-loader \
        child_process \
        clean-css \
        co \
        coffee-loader \
        coffee-script \
        coffee-script \
        coffeelint \
        cookie-parser \
        css-loader \
        dateformat \
        dynamic-dedupe \
        ejs \
        escape-html \
        express \
        extract-text-webpack-plugin \
        file-loader \
        fis3 \
        fis3-hook-commonjs \
        fis3-postpackager-loader \
        fis3-postprocessor-autoprefixer \
        get-parameter-names \
        gulp-develop-server \
        gulp \
        hiredis \
        html-loader \
        html-minifier \
        html-minify-loader \
        html-to-text \
        html-webpack-plugin \
        image-webpack-loader \
        ioredis \
        jquery \
        js-yaml \
        js2coffee \
        jsonwebtoken \
        knex \
        lodash \
        lodash.clonedeep \
        marked \
        negotiator \
        node-dev \
        node-sass \
        node-uuid \
        optimize-css-assets-webpack-plugin \
        pg \
        pg-native \
        q \
        qiniu \
        raw-loader \
        reconnecting-websocket \
        redis-evalsha \
        request \
        rootpath \
        rubygems \
        sass-loader \
        scriptjs \
        slideout \
        slm-loader \
        store \
        style-loader \
        to-markdown \
        underscore \
        url-loader \
        uws \
        webpack \
        webpack-dev-server \
        websocket-extensions \
        underscore.string



        COPY vimrc /etc/vim/vimrc.local
# install vim-plugin

        WORKDIR /home/dev
        RUN git clone https://github.com/gmarik/Vundle.vim.git /usr/share/vim/vimfiles/bundle/Vundle.vim;\
            python3.6 -m pip install --upgrade pip setuptools wheel; \
            pip3 install --upgrade pip virtualenv trash-cli hg-git thefuck autopep8 flake8 yapf mako;\
            vim +PluginInstall +qall;\
            sed -i '/colorscheme/ i colorscheme solarized'  /etc/vim/vimrc.local ;\
            gem sources --add https://ruby.taobao.org/ --remove https://rubygems.org/; gem install sass gist ;

            USER root
            COPY fix_print.py /usr/lib/python3.5/lib2to3/fixes/fix_print.py
            COPY rc.local /etc/rc.local

            WORKDIR /root
            ENTRYPOINT ["/etc/rc.local"]
