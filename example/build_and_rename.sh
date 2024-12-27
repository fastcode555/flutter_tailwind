#!/bin/bash

# 设置变量
OUTPUT_DIR="./output"
APK_NAME="MyApp-$(date +%Y%m%d)-release.apk"

# 确保输出目录存在
mkdir -p $OUTPUT_DIR

# 打包 APK
fvm flutter build apk --release --target lib/main_facebook.dart && mv build/app/outputs/flutter-apk/app-release.apk output/main_facebook.apk


echo "APK 打包完成，已保存到 $OUTPUT_DIR/$APK_NAME"
