#!/bin/sh

# 脚本所在的目录，现在改为 /jffs/scripts
# 为了兼容性，我们直接指定配置文件的绝对路径
CONF_FILE="/jffs/scripts/AutoWOL_config.conf"
LOG_FILE="/tmp/AutoWOL.log"

# 引入配置文件
if [ -f "$CONF_FILE" ]; then
    source "$CONF_FILE"
else
    echo "$(date): 错误 - 找不到配置文件 $CONF_FILE" >> $LOG_FILE
    exit 1
fi

# 记录日志，方便排查问题
echo "----------------------------------------" >> $LOG_FILE
echo "$(date): AutoWOL 任务触发。" >> $LOG_FILE

# 检查MAC地址是否已经配置
if [ -z "$TARGET_MAC" ] || [ "$TARGET_MAC" = "00:11:22:AA:BB:CC" ]; then
    echo "$(date): 错误 - MAC地址未在 $CONF_FILE 中配置！" >> $LOG_FILE
    exit 1
fi

echo "$(date): 准备唤醒目标设备: ${TARGET_MAC}" >> $LOG_FILE

# 发送WOL魔法包到局域网广播地址
# 使用 -i br0 指定从LAN口(桥接)发出，这是最稳妥的方式
ether-wake -i br0 "$TARGET_MAC"

if [ $? -eq 0 ]; then
    echo "$(date): WOL 唤醒包已成功发送至 ${TARGET_MAC}" >> $LOG_FILE
else
    echo "$(date): WOL 唤醒包发送失败！" >> $LOG_FILE
fi