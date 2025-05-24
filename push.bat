chcp 65001
@echo off

echo 设置远程仓库为 shadowOats/Mumu-Msfconsole...
git remote set-url origin https://github.com/shadowOats/Mumu-Msfconsole.git

echo 添加更改...
git add .

echo 提交更改...
git commit -m "没啥事，就是玩。。。"

echo 推送到 GitHub...
git push origin main

echo ✅ 推送完成！
pause