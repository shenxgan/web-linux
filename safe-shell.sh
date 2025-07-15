#!/bin/bash

trap '' EXIT HUP INT TERM  # 拦截 Ctrl+C、Ctrl+D 等

echo "🔒 安全终端启动：exit 和 Ctrl+D 已禁用。"

while true; do
    bash --noprofile  # 启动真正的 bash 子 shell，支持彩色、交互、补全
    echo "❌ 禁止退出终端（exit/logout 已拦截）。"
done
