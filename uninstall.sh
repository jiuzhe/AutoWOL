#!/bin/sh

# 脚本安装路径 - 改为 /jffs/scripts
scripts_dir=/jffs/scripts

# 从cru中删除定时任务
cru d AutoWOL

# 删除相关文件
rm -f ${scripts_dir}/AutoWOL_script.sh
rm -f ${scripts_dir}/AutoWOL_config.conf

# 删除可能存在的日志文件
rm -f /tmp/AutoWOL.log

echo "AutoWOL 插件已成功卸载！"