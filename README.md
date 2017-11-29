# MakemojiDemo
在线 Emoji 键盘 SDK —— Makemoji-SDK Demo

---
![](https://img.shields.io/badge/platform-iOS-red.svg) 
![](https://img.shields.io/badge/language-Objective--C-orange.svg) 
![](https://img.shields.io/badge/download-9.9MB-brightgreen.svg)
![](https://img.shields.io/badge/license-MIT%20License-brightgreen.svg) 

表情包已经成为继英语之后的第二大语言，我们的生活也渐渐离不开这种生动形象的表达方式，借助 Makemoji-SDK 我们也可以快速的实现这一功能。

| 名称 |1.展示页 |2.展示页 |3.展示页 |3.展示页 |
| ------------- | ------------- | ------------- | ------------- | ------------- |
| 截图 | ![](http://og1yl0w9z.bkt.clouddn.com/17-11-29/34552577.jpg) | ![](http://og1yl0w9z.bkt.clouddn.com/17-11-29/26563646.jpg) | ![](http://og1yl0w9z.bkt.clouddn.com/17-11-29/21718798.jpg) | ![](http://og1yl0w9z.bkt.clouddn.com/17-11-29/18066034.jpg) |
| 描述 | 输入前样式 | 文字键盘样式 | 表情包键盘样式 | 表情键盘样式 |


## Advantage 框架的优势
* 1.文件少，代码简洁
* 2.专门维护的 SDK
* 3.同时支持静态/Gif表情包
* 4.使用即时通讯场景，自带典 Message 结构
* 5.具备较高自定义性

## Installation 安装
### 1.手动安装:
`下载Demo后,将功能文件夹拖入到项目中, 导入头文件后开始使用。`
### 2.CocoaPods安装:
修改“Podfile”文件
```
pod 'Makemoji-SDK', '~> 1.2.5'
```
控制台执行 Pods 安装命令 （ 简化安装：pod install --no-repo-update ）
```
pod install
```
> 如果 pod search 发现不是最新版本，在终端执行pod setup命令更新本地spec镜像缓存，重新搜索就OK了

## Requirements 要求
* iOS 7+
* Xcode 8+


## Usage 使用方法
### 第一步 引入头文件
```
#import "MakemojiSDK.h"
```
### 第二步 didFinishLaunchingWithOptions 中注册
```
[MakemojiSDK setSDKKey:@"940ced93abf2ca4175a4a865b38f1009d8848a58"];
```

使用简单、效率高效、进程安全~~~如果你有更好的建议,希望不吝赐教!


## License 许可证
OrderedDictionaryTools 使用 MIT 许可证，详情见 LICENSE 文件。


## Contact 联系方式:
* WeChat : WhatsXie
* Email : ReverseScale@iCloud.com
* Blog : https://reversescale.github.io
