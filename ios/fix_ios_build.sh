#!/bin/bash

echo "🚨 正在清理 Xcode 缓存和 Flutter 构建环境..."

# 1. 清理 Xcode DerivedData（缓存）
echo "🧹 清理 Xcode DerivedData..."
rm -rf ~/Library/Developer/Xcode/DerivedData

# 2. CocoaPods 清理并重新安装
echo "🧹 清理并重新安装 CocoaPods..."
pod deintegrate
pod cache clean --all
rm -rf Pods Podfile.lock
pod install
cd ..

# 3. 清理 Flutter 缓存并重新获取依赖
echo "🧼 Flutter clean 和依赖安装..."
flutter clean
flutter pub get

# 4. 构建 IPA 文件
echo "🚀 正在构建 iOS IPA（dev 环境）..."
flutter build ipa --flavor dev --export-options-plist=ExportOptionsDevelopment.plist

echo "✅ 修复完成！如果还有问题，请确认 Xcode CLI 工具版本并重启 Xcode。"