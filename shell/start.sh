#!/bin/bash
# 检查日志目录
bash /shell/check_dir.sh
# 启动nginx
nginx
# 定时
echo "0 3 * * * /bin/bash /shell/check_dir.sh" > /var/spool/cron/crontabs/root
#启动定时任务
crond
# 日志同步
#filebeat -c /etc/filebeat/filebeat.yml
tail -f /dev/null