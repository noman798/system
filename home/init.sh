
mkdir ~/.hgplugin
curl https://bitbucket.org/GrahamHelliwell/hg-sync/raw/cdb1d3f0ca68766d775746b02b301547ce3af0df/sync.py > ~/.hgplugin/sync.py
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
