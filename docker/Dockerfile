FROM ubuntu

ENV DEBIAN_FRONTEND noninteractive


# setting up ssh
RUN mkdir -p /var/run/sshd
RUN useradd dev -m -p idatadev -s /bin/bash
RUN echo "dev:TZworld" | chpasswd

# chinese language package
RUN locale-gen zh_CN.UTF-8

COPY bin/* /usr/bin/
RUN chmod ugo+x /usr/bin/*

# change timezone 
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

COPY resolv.conf /etc/resolv.conf
RUN echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.0 multiverse" > /etc/apt/sources.list.d/mongodb-org.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10

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
        avoscloud-code \
        js2coffee \
        avoscloud-sdk \
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
        underscore.string

# install vim-plugin
COPY vimrc /etc/vim/vimrc.local 
RUN git clone https://github.com/gmarik/Vundle.vim.git /usr/share/vim/vimfiles/bundle/Vundle.vim
RUN vim +PluginInstall +qall
#ENV YCM_DIR /usr/share/vim/vimfiles/bundle/YouCompleteMe
#WORKDIR $YCM_DIR
#RUN ./install.sh --clang-completer


WORKDIR /home/dev
RUN apt-get install -y rubygems
RUN gem sources --add https://ruby.taobao.org/ --remove https://rubygems.org/
RUN gem install sass gist 

RUN pip install virtualenv trash-cli
RUN apt-get install -y python3-markupsafe
USER dev
RUN mkdir /home/dev/.hgplugin
RUN curl https://bitbucket.org/GrahamHelliwell/hg-sync/raw/cdb1d3f0ca68766d775746b02b301547ce3af0df/sync.py > /home/dev/.hgplugin/sync.py
COPY tmux_default /home/dev/.tmux_default
COPY coffeelint.json /home/dev/.coffeelint.json
COPY hgrc /home/dev/.hgrc
COPY hgignore /home/dev/.hgignore
COPY requirement.txt /home/dev/requirement.txt
COPY bashrc /home/dev/.bashrc

# python libs
RUN virtualenv -p /usr/bin/python3.5 /home/dev/.py3env
RUN ["/bin/bash", "-c", "source ~/.py3env/bin/activate && pip3.5 install -e hg+https://btyh17mxy@bitbucket.org/pypa/wheel#egg=python-whell"]
RUN /bin/bash -c "source ~/.py3env/bin/activate && pip3.5 install -r /home/dev/requirement.txt"
RUN git clone https://github.com/wting/autojump.git 


USER root
COPY fix_print.py /usr/lib/python3.5/lib2to3/fixes/fix_print.py
COPY rc.local /etc/rc.local

WORKDIR /root
ENTRYPOINT ["/etc/rc.local"]
