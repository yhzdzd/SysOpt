#!/bin/bash
# bench_network.sh
# Simple network performance benchmark script
# Author: Wang Hongxiang
# License: MIT

set -e

echo "📡 SysOpt Network Performance Benchmark"
echo "-----------------------------------"

check_cmd() {
    if ! command -v "$1" &> /dev/null; then
        echo "❌ Missing dependency: $1"
        exit 1
    fi
}

check_cmd ping
check_cmd curl
check_cmd wget

TARGET="8.8.8.8"
SPEEDTEST_URL="http://speedtest.tele2.net/100MB.zip"
TMP_FILE="/tmp/net_test_file"

echo "🔍 Testing Ping latency to $TARGET"
ping -c 4 $TARGET

echo
echo "🔍 Testing download speed (100MB file)"
START=$(date +%s)
wget -O $TMP_FILE $SPEEDTEST_URL >/dev/null 2>&1
END=$(date +%s)
SIZE_MB=100
TIME=$((END - START))
if [ $TIME -gt 0 ]; then
    SPEED=$((SIZE_MB / TIME))
    echo "✅ Approximate download speed: ${SPEED} MB/s"
else
    echo "⚠️ Unable to measure download speed"
fi
rm -f $TMP_FILE

echo
echo "🔍 Testing HTTP response time"
curl -o /dev/null -s -w "✅ Response time: %{time_total}s\n" https://www.google.com

echo
echo "✅ Network benchmark completed"
