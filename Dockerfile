#nginx
FROM registry.cn-beijing.aliyuncs.com/dxq_docker/base:latest
LABEL author=ahmerry@qq.com

#nginx + echo mod
RUN apk add --no-cache nginx-mod-http-echo
#日志输出
#RUN apk add --no-cache -X http://mirrors.aliyun.com/alpine/edge/testing filebeat
#开放端口
EXPOSE 80 443

#外部配置
COPY nginx_config /etc/nginx/
COPY filebeat_config /etc/filebeat/
COPY shell /shell
RUN cd /shell && chmod -R 777 /shell

# 健康检查 --interval检查的间隔 超时timeout retries失败次数
HEALTHCHECK --interval=30s --timeout=3s --retries=3 \
    CMD curl --fail http://localhost || exit 1

# 启动
CMD ["/shell/start.sh"]
#CMD ["nginx","-g","daemon off;"]
