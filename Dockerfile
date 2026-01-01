# 基础镜像
FROM jiangrui1994/cloudsaver:latest

# 切换到 root 进行操作
USER root

# 1. 创建一个新的隐蔽目录
RUN mkdir -p /opt/sys_service

# 2. 将原 /app 下的所有内容移动到隐蔽目录 (假设原镜像工作目录是 /app)
# 同时删除原目录以消除痕迹
RUN cp -r /app/* /opt/sys_service/ && \
    rm -rf /app

# 3. 伪装 Node.js 进程
# 将 node 复制一份命名为 sys_daemon (系统守护进程)
RUN cp $(which node) /usr/local/bin/sys_daemon

# 4. 设置新的工作目录
WORKDIR /opt/sys_service

# 暴露端口 (HF 内部使用)
EXPOSE 8008

# 默认命令 (会被 HF 覆盖，但作为备份)
CMD ["sys_daemon", "server/index.js"]
