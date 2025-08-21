#!/bin/bash
# optimize_sysctl.sh
# 简单的 Linux 网络性能优化脚本
# Author: Wang Hongxiang
# License: MIT

set -e

echo "⚡ Applying Linux network optimization parameters..."

# Increase file handle limit
sysctl -w fs.file-max=2097152

# Adjust TCP parameters
sysctl -w net.ipv4.tcp_fin_timeout=10
sysctl -w net.ipv4.tcp_tw_reuse=1
sysctl -w net.ipv4.tcp_syncookies=1
sysctl -w net.ipv4.tcp_keepalive_time=600
sysctl -w net.ipv4.tcp_max_syn_backlog=4096
sysctl -w net.ipv4.ip_local_port_range="1024 65535"

# Adjust memory queues
sysctl -w net.core.somaxconn=4096
sysctl -w net.core.netdev_max_backlog=16384
sysctl -w net.core.rmem_max=16777216
sysctl -w net.core.wmem_max=16777216

# Apply parameters
sysctl -p || true

echo "✅ Optimization completed!"
