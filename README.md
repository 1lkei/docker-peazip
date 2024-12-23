# docker-peazip

### 解决NAS无图形化解压缩软件方案

### [docker hub地址](https://hub.docker.com/r/1lkei/peazip)
### [github地址](https://github.com/1lkei/docker-peazip)

## 运行
```
docker run -d \
    --name=peazip \
    --restart=unless-stopped \
    --security-opt seccomp=unconfined \
    --net=host \
    --shm-size="1gb" \
    -m 2g \
    -v /config:/config \
    -e PUID=1000 \
    -e PGID=1000 \
    -e TZ=Asia/Shanghai \
    -e CUSTOM_PORT=3000 \
    -e CUSTOM_HTTPS_PORT=3001 \
    -e CUSTOM_USER=user \
    -e PASSWORD=pw \
    -e START_DOCKER=false \
    -e LC_ALL=zh_CN.UTF-8 \
    1lkei/peazip:latest
```
http端口(默认值)
`-e CUSTOM_PORT=3000`
https端口(默认值)
`-e CUSTOM_HTTPS_PORT=3001`

登陆账号
`-e CUSTOM_USER=user`
登陆密码
`-e PASSWORD=pw`
**请及时修改账号密码！**

禁用docker in docker
`-e START_DOCKER=false`

添加以下环境变量启用cn等语言支持  
`-e DOCKER_MODS=linuxserver/mods:universal-package-install `  
`-e INSTALL_PACKAGES=fonts-noto-cjk`
添加以下环境变量启用硬件加速  
`--device /dev/dri:/dev/dri`  
`-e DRINODE=/dev/dri/renderD128`

更多选项请前往<https://github.com/linuxserver/docker-baseimage-kasmvnc?tab=readme-ov-file#options>了解