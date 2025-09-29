#!/bin/sh

# 软件中心会将插件包解压到 /tmp 目录下，插件名即为文件夹名
source_dir=/tmp/AutoWOL

# 目标安装路径 - 改为 /jffs
target_base=/jffs
scripts_dir=${target_base}/scripts

# 在可写的jffs分区创建必要的目录
mkdir -p ${scripts_dir}

# 复制文件到路由器的永久存储位置
cp -f ${source_dir}/wol_script.sh ${scripts_dir}/AutoWOL_script.sh
cp -f ${source_dir}/config.conf ${scripts_dir}/AutoWOL_config.conf

# 赋予脚本执行权限
chmod +x ${scripts_dir}/AutoWOL_script.sh

# 添加定时任务到cru
# "0 7 * * *" 表示每天早上7点0分执行
# "AutoWOL" 是这个任务的名称，方便我们管理
cru a AutoWOL "0 7 * * * ${scripts_dir}/AutoWOL_script.sh"

# 给用户安装成功的提示信息
echo "================================================="
echo "    AutoWOL 自动唤醒插件 安装成功！"
echo "-------------------------------------------------"
echo "插件已设置在每天早上 7:00 自动唤醒。"
echo "请务必通过SSH登录路由器, 编辑以下文件:"
echo "vi ${scripts_dir}/AutoWOL_config.conf"
echo "将里面的 TARGET_MAC 修改为你需要唤醒的电脑的MAC地址！"
echo "================================================="