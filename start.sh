#!/bin/zsh

echo "====== ������ MuMu 一键控制台 ======"
echo "1. 生成木马"
echo "2. 启动监听器"
echo "3. 退出"

echo -n "请选择操作 [默认 1]: "
read action
action=${action:-1}

case $action in
  1)
    ~/script/mumu_create.sh
    ;;
  2)
    ~/script/mumu_listen.sh
    ;;
  3)
    echo "������ 退出 MuMu"
    exit 0
    ;;
  *)
    echo "❌ 无效选项"
    exit 1
    ;;
esac

