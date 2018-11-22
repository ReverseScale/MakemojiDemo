> Emoji 表情无处不在。 它们每天被数百万人使用，是一个无与伦比的表达工具。

![](https://user-gold-cdn.xitu.io/2018/2/7/1616f87bb0d738da?w=1689&h=591&f=png&s=109467)

![](https://img.shields.io/badge/platform-iOS-red.svg) ![](https://img.shields.io/badge/language-Objective--C-blue.svg) ![](https://img.shields.io/badge/download-9.9MB-yellow.svg) ![](https://img.shields.io/badge/license-MIT%20License-brightgreen.svg) 

[EN](https://github.com/ReverseScale/MakemojiDemo) | [中文](https://github.com/ReverseScale/MakemojiDemo/blob/master/README_zh.md)

我们相信，用户不应该被限制在 Unicode 库中，我们构建了这个键盘，以增加所有与我们合作的应用程序的参与度，保留率和收入。


### 🤖 要求

* iOS 9.0+ & Android
* Xcode 9.0+
* Swift / Objective-C


### 🚀 准备开始

Makemoji 应用内键盘是我们 SDK 的核心。 这是一个动态控制的表情符号键盘与紧密集成的文本输入，由我们的CMS和仪表板支持。 您可以创建自己的类别，上传 emoji / gifs 并沿着 unicode 表情符号跟踪其使用情况。

![](https://user-gold-cdn.xitu.io/2018/2/7/1616f87bb57cd724?w=569&h=370&f=png&s=28870)

我们的文本输入的输出是一个简单的 HTML 消息，以及一个纯文本版本和我们所谓的“替代”版本，它使用一个简单的模板系统。 这个输出可以保存在您的设备上，后端或您选择的任何地方。


### 🎨 测试 UI 什么样子？

|1.展示页 |2.展示页 |3.展示页 |4.展示页 |
| ------------- | ------------- | ------------- | ------------- |
| ![](https://user-gold-cdn.xitu.io/2018/2/7/1616f87bb6969319?w=640&h=1136&f=jpeg&s=47286) | ![](https://user-gold-cdn.xitu.io/2018/2/7/1616f87bb6880069?w=640&h=1136&f=jpeg&s=68891) | ![](https://user-gold-cdn.xitu.io/2018/2/7/1616f87bb6a50e40?w=640&h=1136&f=jpeg&s=51624) | ![](https://user-gold-cdn.xitu.io/2018/2/7/1616f87bb51c8391?w=640&h=1136&f=jpeg&s=59621) |
| 输入前样式 | 文字键盘样式 | 表情包键盘样式 | 表情键盘样式 |


### 🎯 安装方法

#### 安装

在 *iOS*, 你需要在 Podfile 中添加.
```
pod "Makemoji-SDK"
```
如果你使用 *Android*, 添加在工程 build.gradle 目录下
```
dependencies {
    compile 'com.makemoji:makemoji-sdk-android:0.9.777'
}    
repositories {
    jcenter()
    maven {
        url "https://dl.bintray.com/mm/maven/"
    }
}
```

#### 设置你的 SDK Key

要获得您的SDK密钥，请发送电子邮件至sdk@makemoji.com

要开始使用MakemojiSDK，您将首先设置您的SDK密钥。

iOS 在 `AppDelegate` 中:
```
#import "MakemojiSDK.h"
```
```
    - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
        // setup your SDK key
        [MakemojiSDK setSDKKey:@"YOUR-SDK-KEY"];
        return YES;
    }
```
Android 在 `AndroidManifest.xml`:
```
    <application
        android:name="com.makemoji.sbaar.mojilist.App"
        ...
```
和 `App.java`
```
    public void onCreate(){
        super.onCreate();
        Moji.initialize(this,"YOUR_KEY_HERE");
        //Moji.setUserId("Google ad id here if needed"); // optional custom user id for analytics
    }
```

### 🛠 配置

#### 设置

假设您有一个应用程序的聊天区域，并且您希望使用我们的键盘来让用户在对话中共享独特的表情符号。 让我们开始设置我们的文本输入对象属性。

```
#import "METextInputView.h"

@interface ViewController : UIViewController <METextInputViewDelegate>
@property (nonatomic, retain) METextInputView * meTextInputView;
```

`METextInputView` 是一个容器对象，它包含导航/趋势图栏以及文本输入。 这是为了解决苹果的InputAccessoryView的某些技术限制，尽管这种行为非常相似。

在 viewDidLoad 或 init 视图控制器中，初始化 METextInputView。
```
self.meTextInputView = [[METextInputView alloc] initWithFrame:CGRectZero];
self.meTextInputView.delegate = self;
```

您需要将自己分配给委托，以侦听事件的回调，如点击发送或照相机按钮和键盘事件。 接下来，我们需要确定我们要在页面上使用什么类型的输入。

#### 浮动输入

如果你的应用程序需要一个浮动的 `iMessage` 类型的文本输入，你可以简单地将 `METextInputView` 添加到你的视图中。

```
[self.view addSubview:self.meTextInputView];
```

这个默认模式在键盘之后，随着一个摄像头/发送按钮，并且当用户输入一个长消息时，扩展到全屏。 `METextInputView` 遵循 'firstResponder` 模式来隐藏/显示键盘。

![](https://user-gold-cdn.xitu.io/2018/2/7/1616f87beca73f8e?w=825&h=631&f=png&s=53101)

有很多方法可以定制这个输入和导航栏的外观和感觉。 我们将在 `Customizations` 中介绍

#### 分离的输入

如果您需要从键盘分离的文本输入，您将需要调用 detachTextInputView 方法，然后将 textInputContainerView 添加到您的视图。

```
[self.meTextInputView detachTextInputView:YES];
[self.view addSubview:self.meTextInputView.textInputContainerView];
```

由于“发送按钮”和“摄像头”按钮在此模式下处于隐藏状态，因此您需要在 `METextInputView` 的 `sendMessage` 方法上附加一个按钮来触发捕获文本。

![](https://user-gold-cdn.xitu.io/2018/2/7/1616f87becff928a?w=259&h=318&f=png&s=8194)

#### 输入大小变化

当使用我们的浮动输入时，您将希望在显示键盘时使用 `didChangeFrame` 委托回调来调整周围的视图。

```
-(void)meTextInputView:(METextInputView *)inputView didChangeFrame:(CGRect)frame {
    self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, self.meTextInputView.frame.origin.y);
}
```

#### 发送消息

Makemoji 消息由三部分组成：一个完全形成的HTML消息，一个ASCII兼容的明文消息和一个 `substitute` 消息。 你使用哪一个取决于你的消息存储是如何配置的。 替代文本允许您将带有Makemoji表情符号占位符的明文存储为文本的一部分。 这是一个示例消息。

```
{
    html = "<p dir=\"auto\" style=\"margin-bottom:16px;font-family:'.SF UI Text';font-size:16px;font-weight:bold;\"><span style=\"color:#000000;\">Hey lets play </span><img style=\"vertical-align:middle;width:20px;height:20px;\" src=\"https://d1tvcfe0bfyi6u.cloudfront.net/emoji/14-large@2x.png\" id=\"14\" link=\"\" name=\"Pacman\" /><span style=\"color:#000000;\"> at the </span><img style=\"vertical-align:middle;width:20px;height:20px;\" src=\"https://d1tvcfe0bfyi6u.cloudfront.net/emoji/692-large@2x.png\" id=\"692\" name=\"Arcade\" link=\"\" /></p>\n";
    plaintext = "Hey lets play  at the \n";
    substitute = "Hey lets play [Pacman.E] at the [Arcade.BA]";
}
```

当用户点击 'sendButton` 时，`didTapSend` 委托回调被触发，并返回一个包含html，plaintext和substitute消息的字符串的NSDictionary。

```
-(void)meTextInputView:(METextInputView *)inputView didTapSend:(NSDictionary *)message {
    // send message to your backend here
    [self.messages addObject:message];
    [self.tableView reloadData];
}
```

然后，您可以将选择的部分发送到后端以存储消息。

#### 显示消息

现在你已经有Makemoji消息了，我们需要设置一个显示它们的方法。 通常这将在 `UITableViewCell` 中，但您也可以使用任何自定义视图来显示消息。 我们已经包括一个优化的UITableViewCells用于显示HTML消息和一种方法来自动缓存你的表单元格高度。 这可以防止任何不必要的表情符号和文本布局，并提高性能。 这里是我们提供的信息显示的概述。

* MESimpleTableViewCell
这个单元格提供了一个基本的布局，默认情况下尝试使用整个单元格区域。 您将使用此单元格作为子类快速实现自定义表格单元格。
* MEChatTableViewCell 
聊天单元提供一个iMessage，如聊天泡泡，间距，可设定的方向和颜色设置。
* MECollectionViewCell 
简单表格单元格的集合视图版本。
* MEMessageView 
单元的底层视图，消息的核心显示视图。

##### 替代文字
使用 `substitute` 类型的消息时，可以通过在 `METextInputView` 上使用下面的静态方法将其转换回HTML

```
+(NSString *)convertSubstituedToHTML:(NSString *)substitute withFontName:(NSString *)fontName pointSize:(CGFloat)pointSize textColor:(UIColor *)color
```

##### 高度缓存

使用 `cellHeightForHTML` 方法获取消息的行高。 此方法缓存单元高度以提高性能。

```
// determine row height with HTML
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.meTextInputView == nil) {
        return 0;
    }

    NSDictionary * message = [self.messages objectAtIndex:indexPath.row];
    return [self.meTextInputView cellHeightForHTML:[message objectForKey:@"html"]
                                       atIndexPath:indexPath
                                      maxCellWidth:self.tableView.frame.size.width
                                         cellStyle:MECellStyleChat];
}
```

您可以通过重置 `METextInputView` 上的 `cachedHeights` 属性来手动重置 `UITableViewCell` 高度缓存。

##### 表格单元格

使用`MEChatTableViewCell`，您可以使用setCellDisplay在左侧或右侧显示聊天气泡。 这应该发生在为每个消息设置您的HTML之前。

```
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        static NSString *CellIdentifier = @"Cell";

        MEChatTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

        if (cell == nil) {
            cell = [[MEChatTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }

        // display chat cell on right side
        [cell setCellDisplay:MECellDisplayRight];

        // display chat cell on left side
        if (indexPath.row % 2) {
            [cell setCellDisplay:MECellDisplayLeft];
        }

        NSDictionary * message = [self.messages objectAtIndex:indexPath.row];
        [cell setHTMLString:[message objectForKey:@"html"]];

        return cell;
    }
```

#### Hypermoji - 带有URL的表情符号

我们已经创建了一种新的方式来共享内容，浏览网页，观看视频或听音乐，而不用离开Hypermoji的应用程序。

要在Hypermoji（具有URL链接的表情符号）上点击时显示网页，请使用 `didTapHypermoji` 委托回调

```
// handle tapping of links (Hypermoji)
-(void)meTextInputView:(METextInputView *)inputView didTapHypermoji:(NSString*)urlString {
      // open webview here
}
```

#### 相机按钮

这是一个标准的UIButton，可以用图像或文本进行自定义。 要处理相机按钮的操作，请使用`didTapCameraButton`委托回调。

```
-(void)meTextInputView:(METextInputView *)inputView didTapCameraButton:(UIButton*)cameraButton {
    // Present image controller
}
```

#### 自定义

您可以通过在 `METextInputView` 上设置 `displayCameraButton` 属性来显示或隐藏内置摄像头

```
self.meTextInputView.displayCameraButton = NO;
```

您可以通过在 `METextInputView` 上设置 `displaySendButton` 属性来显示或隐藏内置的发送按钮

```
self.meTextInputView.displaySendButton = NO;
```

使用`setFont`你可以设置你的文本输入的默认字体。

```
[self.meTextInputView setFont:[UIFont systemFontOfSize:20]];
```

更改占位符文本的颜色

```
self.meTextInputView.placeholderLabel.textColor = [UIColor darkGrayColor];
```

#### 控制锁定的类别

您将需要侦听NSNotification `MECategorySelectedLockedCategory` 来确定什么时候锁定了一个类别。 要解锁一个类别，您需要调用 `[MakemojiSDK unlockCategory：@“category”]` 您可以收听 'MECategoryUnlockedSuccessNotification` 和 `MECategoryUnlockedFailedNotification` 以确定解锁呼叫是否成功。

### 📝 应用程序提交

Makemoji SDK 使用IDFA跟踪ID来为您的应用程序中的视图，共享和点击进行归因。 将应用程序提交到 App Store 时，您需要检查“将此应用程序安装到以前投放的广告”选项。

![](https://user-gold-cdn.xitu.io/2018/2/7/1616f87bece6eb36?w=1264&h=607&f=png&s=75271)


### 😬 联系

* 微信 : WhatsXie
* 邮件 : ReverseScale@iCloud.com
* 博客 : https://reversescale.github.io
