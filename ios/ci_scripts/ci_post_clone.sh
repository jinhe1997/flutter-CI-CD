#!/bin/sh
set -e

# 預設的腳本執行目錄是 ci_scripts 目錄。
cd $CI_PRIMARY_REPOSITORY_PATH # 切換工作目錄到您Clone的 repo 的根目錄。

# 使用 git 安裝 Flutter。
git clone https://github.com/flutter/flutter.git -b stable $HOME/flutter
export PATH="$PATH:$HOME/flutter/bin"

cd $HOME/flutter
# 切換到對應的版本分支,自行調整
git checkout 4d9e56e694b656610ab87fcf2efbcd226e0ed8cf

cd $CI_PRIMARY_REPOSITORY_PATH

# 安裝 iOS (--ios) 或 macOS (--macos) 平台的 Flutter 工件。
flutter precache --ios

# 安裝 Flutter 依賴的套件。
flutter pub get

# 使用 Homebrew 安裝 CocoaPods。
HOMEBREW_NO_AUTO_UPDATE=1 # 禁用 homebrew 的自動更新。
brew install cocoapods

# 安裝 CocoaPods 依賴的套件。
cd ios && pod install # 在 `ios` 目錄下運行 `pod install`。

exit 0