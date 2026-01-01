# 基础镜像
FROM jiangrui1994/cloudsaver:latest

# 切换到 root 权限
USER root

# 1. 伪装 Node 进程
RUN cp $(which node) /usr/local/bin/sys_daemon

# 2. 【核心修复】不要移动文件，而是创建软链接
# 让 /opt/sys_service 指向 /app
# 这样既保留了 /app (解决报错)，又实现了路径伪装
RUN ln -s /app /opt/sys_service

# 3. 伪装工作目录
WORKDIR /opt/sys_service

# 4. 端口暴露
EXPOSE 8008

# 默认命令
CMD ["sys_daemon", "server/index.js"]
