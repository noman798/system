FROM ubuntu:xenial

ENV DEBIAN_FRONTEND noninteractive


# setting up ssh
RUN mkdir -p /var/run/sshd
RUN useradd dev -m -p TZworld -s /bin/bash
RUN echo "dev:TZworld" | chpasswd

# chinese language package
RUN locale-gen zh_CN.UTF-8

COPY bin/* /usr/bin/
RUN chmod ugo+x /usr/bin/*

# change timezone 
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

COPY resolv.conf /etc/resolv.conf

# update
RUN apt-get update
RUN set -x \
        && apt-get install -y \
        software-properties-common \
        curl

        
RUN curl --silent --location https://deb.nodesource.com/setup_4.x | bash -
RUN add-apt-repository ppa:fkrull/deadsnakes -y && apt-get update
RUN apt-get dist-upgrade -y

# install basic software
RUN apt-get -y install \
    sudo \
    rsyslog \
    libzbar-dev \
    nmap \
    doxygen \
    dnsutils \
    unzip \
    build-essential \
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
    libjpeg-dev \
    libjpeg8-dev \
    libssl-dev \
    lsof \
    make \
    mercurial \
    mlocate \
    nodejs \
    openssh-client \
    openssh-server \
    perl \
    python-dev \
    python-pip \
    python3.5 \
    python3.5-dev \
    redis-server \
    rpl \
    rubygems-integration \
    silversearcher-ag \
    tmux \
    tree \
    vim \
    libtidy-0.99-0 \
    xtail

RUN echo "dev ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# changel npm to local source
RUN npm config set strict-ssl false
RUN npm install -g cnpm --registry=https://registry.npm.taobao.org

# install frontend tools
# RUN cnpm install -g \
RUN npm install -g \
        js2coffee \
        base-x \
        body-parser \
        clean-css \
        coffee-script \
        cookie-parser \
        coffeelint \
        dateformat \
        dynamic-dedupe \
        ejs \
        escape-html \
        express \
        fis3 \
        fis3-postpackager-loader \
        fis3-hook-commonjs \
        hiredis \
        html-minifier \
        html-to-text \
        ioredis \
        leanengine \
        marked \
        node-dev \
        node-uuid \
        q \
        qiniu \
        redis-evalsha \
        request \
        rootpath \
        to-markdown \
        underscore \
        underscore.string \
        rubygems \
        python3-markupsafe

# install vim-plugin
RUN git clone https://github.com/gmarik/Vundle.vim.git /usr/share/vim/vimfiles/bundle/Vundle.vim
COPY vimrc /etc/vim/vimrc.local 
RUN vim +PluginInstall +qall
#ENV YCM_DIR /usr/share/vim/vimfiles/bundle/YouCompleteMe
#WORKDIR $YCM_DIR
#RUN ./install.sh --clang-completer


RUN pip install virtualenv trash-cli
WORKDIR /home/dev
RUN gem sources --add https://ruby.taobao.org/ --remove https://rubygems.org/
RUN gem install sass gist 


USER root
COPY fix_print.py /usr/lib/python3.5/lib2to3/fixes/fix_print.py
COPY rc.local /etc/rc.local

WORKDIR /root
ENTRYPOINT ["/etc/rc.local"]
