#!/bin/bash

echo "====== ������ MuMu 自动部署开始 ======"

# 1. 创建 ~/script 目录并移动脚本
mkdir -p ~/script
mv -f mumu_create.sh mumu_listen.sh start.sh ~/script/

# 2. 添加可执行权限
chmod +x ~/script/mumu_create.sh ~/script/mumu_listen.sh ~/script/start.sh

# 3. 添加 alias 到 ~/.zshrc（避免重复添加）
if ! grep -q "alias msf=" ~/.zshrc; then
    echo "" >> ~/.zshrc
    echo "# ������ MuMu 自动添加的快捷命令" >> ~/.zshrc
    echo "alias msf='~/script/start.sh'" >> ~/.zshrc
    echo "✅ 已添加 alias：msf -> ~/script/start.sh"
else
    echo "⚠️ alias 已存在，跳过添加"
fi

# 4. 成功提示
echo ""
echo "✅ MuMu 脚本已部署完毕！"
echo "������ 请输入命令：msf"
echo "������ 即可启动 msfconsole 控制台（带监听）"
echo ""


