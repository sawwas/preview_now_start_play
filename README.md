# preview_play

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

### 提交代码前运行：
1、dart fix --dry-run 找到需要修复的代码
2、dart fix --apply 修复代码

！！！只格式自己写的代码，不要格式化其他人的代码！！！

### 抓包：
telnet 192.168.1.192:9090

### 切换环境：
run ```flutter run --dart-define=isProd=true -v --flavor prod``` or ```flutter run --dart-define=isProd=false -v --flavor dev```

### melos:
- install melos ```dart pub global activate melos```
- run melos clean 
- run melos bootstrap 
- run melos build-apk-dev``` or ```flutter build apk --dart-define-from-file=env/dev.json```
- run melos build0-ipa-dev``` or ```flutter build ipa --dart-define-from-file=env/dev.json```


A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
