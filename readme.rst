
国内先用迅雷下载 https://github.com/boot2docker/boot2docker/releases/download/v1.11.1/boot2docker.iso 放到 /Users/$USER/.docker/machine/cache/boot2docker.iso

## 初始化 Docker 环境
### Mac 用户

#. 运行 mac/docker/init.sh 初始化 docker 环境 ， 全新机器可以直接运行 mac/init.sh
#. 以后每次运行 mac/ssh.sh 进入 docker 环境即可 ； 默认密码 TZworld 

### 非 Mac 用户

安装完成 docker 后，运行 docker/build.sh
然后参考 mac/init.sh 构建开发环境


## 初始化开放环境

#. ssh 登录后，dev 目录下应该有 ./init 目录，运行 ./init
