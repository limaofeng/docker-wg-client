# 使用一个轻量级的 base image
FROM alpine:latest

# 安装必要的包
RUN apk update && \
    apk add iptables ip6tables wireguard-tools && \
    # clean-up
    rm -rf /root/.cache && mkdir -p /root/.cache && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/*

ENV APP_NAME="vpnc-app"

COPY run.sh /app/

# 创建一个卷，以方便共享配置文件、密钥和其他所需文件
VOLUME [ "/etc/wireguard" ]

WORKDIR /app

# 设置默认命令来启动 wireguard
ENTRYPOINT ["/app/run.sh"]
CMD ["vpnc-app"]