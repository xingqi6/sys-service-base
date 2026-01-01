# 基础镜像
FROM jiangrui1994/cloudsaver:latest

# 切换到 root
USER root

# 1. 伪装 Node.js 进程 (复制二进制文件)
RUN cp $(which node) /usr/local/bin/sys_daemon

# 2. 【关键修复】创建目录软链接，而不是移动文件
# $(pwd) 会获取原镜像的实际工作目录（通常是 /app）
# 我们建立一个 /opt/sys_service 指向该目录
# 这样 /opt/sys_service/server/index.js 就一定存在
RUN ln -s $(pwd) /opt/sys_service

# 3. 设置工作目录为我们的伪装目录
WORKDIR /opt/sys_service

# 4. 暴露端口
EXPOSE 8008

# 默认启动命令
CMD ["sys_daemon", "server/index.js"]
