# MakemojiDemo

> Emojis are everywhere. They're used by millions of people every day and are an unparalleled expressive tool. 

![](http://og1yl0w9z.bkt.clouddn.com/17-11-30/88204422.jpg)

![](https://img.shields.io/badge/platform-iOS-red.svg) ![](https://img.shields.io/badge/language-Objective--C-blue.svg) ![](https://img.shields.io/badge/download-9.9MB-yellow.svg) ![](https://img.shields.io/badge/license-MIT%20License-brightgreen.svg) 

We believe that users should not be limited to the Unicode library and we built this keyboard to increase engagement, retention and revenue for all of the apps we work with. 


### :robot: Requirements

iOS 9.0+
Xcode 9.0+
Swift / Objective-C


### :rocket: Getting started

The Makemoji in-app keyboard is the core of our SDK. It is a dynamically controlled emoji keyboard with an tightly integrated text input that is backed by our CMS and Dashboard. You can create your own categories, upload emoji/gifs and track their usage along side unicode emoji.

![](http://og1yl0w9z.bkt.clouddn.com/17-11-30/64201647.jpg)

The output of our text input is a simple HTML message, along with a plaintext version and what we called 'substitued' version, which uses a simple template system. This output can then be saved on your device, in your backend or wherever you choose.


### :art: Why test the UI?

| Name |1.Show Page |2.Show Page |3.Show Page |3.Show Page |
| ------------- | ------------- | ------------- | ------------- | ------------- |
| Screenshot | ![](http://og1yl0w9z.bkt.clouddn.com/17-11-29/34552577.jpg) | ![](http://og1yl0w9z.bkt.clouddn.com/17-11-29/26563646.jpg) | ![](http://og1yl0w9z.bkt.clouddn.com/17-11-29/21718798.jpg) | ![](http://og1yl0w9z.bkt.clouddn.com/17-11-29/18066034.jpg) |
| Describe | Before the input style | Writing style of keyboard | Keyboard style expression package | The expression style of keyboard |


### :zap: How does it work?

#### Install

For *iOS*, you will need to add the following to your Podfile.
```
pod "Makemoji-SDK"
```
If you are using *Android*, add this to your projects build.gradle file
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

#### Setup Your SDK Key

To obtain your SDK key please email: sdk@makemoji.com

To start using the MakemojiSDK you will first have to set your SDK key.

iOS in your `AppDelegate`:
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
Android in `AndroidManifest.xml`:
```
    <application
        android:name="com.makemoji.sbaar.mojilist.App"
        ...
```
and `App.java`
```
    public void onCreate(){
        super.onCreate();
        Moji.initialize(this,"YOUR_KEY_HERE");
        //Moji.setUserId("Google ad id here if needed"); // optional custom user id for analytics
    }
```

### :hammer_and_wrench: Configuration

#### Setup

Let's say you have a chat area of your app and you would like to use our keyboard there to let users share unique emoji in conversations. Lets start off by setting up our text input object property.

```
#import "METextInputView.h"

@interface ViewController : UIViewController <METextInputViewDelegate>
@property (nonatomic, retain) METextInputView * meTextInputView;
```

`METextInputView` is a container object that houses the Navigation/Trending bar along with the Text Input. This was done to get around certain technical limitations with Apple's InputAccessoryView, though the behavior is very similar.

In your view controller during viewDidLoad or init, initialize the METextInputView.
```
self.meTextInputView = [[METextInputView alloc] initWithFrame:CGRectZero];
self.meTextInputView.delegate = self;
```

You'll need to assign self to the delegate here to listen for callbacks on events like tapping the send or camera button and keyboard events. Next we'll need to determine what kind of input we want to use on our page.

#### Floating Input
If your app calls for a floating 'iMessage' type text input, you can simply just add the `METextInputView` to your view.

```
[self.view addSubview:self.meTextInputView];
```

This default mode follows the keyboard, comes with a camera/send button and expands to fill the full screen if a user types a long message. `METextInputView` follows `firstResponder` pattern to hide / show the keyboard.

![](http://og1yl0w9z.bkt.clouddn.com/17-11-30/148522.jpg)

There are many ways available to customize the look and feel of this input and navigation bar. We'll cover that in `Customizations`

#### Detached Input

If you need the Text Input detached from the keyboard, you will need to call the detachTextInputView method and then add textInputContainerView to your view.

```
[self.meTextInputView detachTextInputView:YES];
[self.view addSubview:self.meTextInputView.textInputContainerView];
```

Since the Send Button and Camera button are hidden in this mode, you will need to attach a button to the `sendMessage` method on `METextInputView` to trigger capturing the text.

![](http://og1yl0w9z.bkt.clouddn.com/17-11-30/48111428.jpg)

#### Input Size Changes

When using our floating input, you will want to use the `didChangeFrame` delegate callback to adjust your surrounding views when the keyboard is shown.

```
-(void)meTextInputView:(METextInputView *)inputView didChangeFrame:(CGRect)frame {
    self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, self.meTextInputView.frame.origin.y);
}
```

#### Sending a Message

Makemoji messages consist of three parts: A fully formed HTML message, a ascii compatible plaintext message and a `substitute` message. Which one you use depends on how your message store is configured. The Substituted text allows you to store plaintext with Makemoji emoji placeholders as part of the text. Here's an example message.

```
{
    html = "<p dir=\"auto\" style=\"margin-bottom:16px;font-family:'.SF UI Text';font-size:16px;font-weight:bold;\"><span style=\"color:#000000;\">Hey lets play </span><img style=\"vertical-align:middle;width:20px;height:20px;\" src=\"https://d1tvcfe0bfyi6u.cloudfront.net/emoji/14-large@2x.png\" id=\"14\" link=\"\" name=\"Pacman\" /><span style=\"color:#000000;\"> at the </span><img style=\"vertical-align:middle;width:20px;height:20px;\" src=\"https://d1tvcfe0bfyi6u.cloudfront.net/emoji/692-large@2x.png\" id=\"692\" name=\"Arcade\" link=\"\" /></p>\n";
    plaintext = "Hey lets play  at the \n";
    substitute = "Hey lets play [Pacman.E] at the [Arcade.BA]";
}
```

When the user taps the `sendButton`, the `didTapSend` delegate callback is triggered and returns a `NSDictionary` containing strings for html, plaintext and substitue messages.

```
-(void)meTextInputView:(METextInputView *)inputView didTapSend:(NSDictionary *)message {
    // send message to your backend here
    [self.messages addObject:message];
    [self.tableView reloadData];
}
```

You would then send the part of your choice to your backend to store the message.

#### Displaying Messages

Now that you have Makemoji messages, we'll need to setup a way to display them. Typically this would be in a `UITableViewCell`, but you can also use any custom view to display messages. We have included a optimized UITableViewCells for displaying HTML messages and a method to automatically cache your table cell heights. This prevents any unnecessary layouts of emoji and text and improves performance. Here is a rundown of the views we provide for message display.

* MESimpleTableViewCell
This cell provides a basic layout that by default attempts to use the full cell area. You would use this cell to quickly implement a custom table cell as a subclass.
* MEChatTableViewCell 
The chat cell provides a iMessage like chat bubble with spacing, settable direction and color settings.
* MECollectionViewCell 
A collection view version of the simple table cell.
* MEMessageView 
The underlying view for the cells, the core display view for messages.

##### Substitue Text
When using `substitute` type messages you can convert this back into HTML by using the following static method on `METextInputView`

```
+(NSString *)convertSubstituedToHTML:(NSString *)substitute withFontName:(NSString *)fontName pointSize:(CGFloat)pointSize textColor:(UIColor *)color
```

##### Height Caching

Use the `cellHeightForHTML` method to get the row height for a message. This method caches cell heights for increased performance.

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

You can manually reset our cache of `UITableViewCell` heights by resetting the `cachedHeights` property on `METextInputView`.


##### Table Cells

With the `MEChatTableViewCell` you can display the chat bubble on the left or right hand side using setCellDisplay. This should happen before setting your HTML for each message.

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

#### Hypermoji - Emoji with a URL

We have created a new way to share content, navigate the web, watch videos or listen to music all without leaving your app with Hypermoji.

To handle the display of a webpage when tapping on a Hypermoji ( a emoji with a URL link), use the `didTapHypermoji` delegate callback

```
// handle tapping of links (Hypermoji)
-(void)meTextInputView:(METextInputView *)inputView didTapHypermoji:(NSString*)urlString {
      // open webview here
}
```

#### Camera Button

This is a standard UIButton that can be customized with a image or text. To handle a action for the camera button use the `didTapCameraButton` delegate callback.

```
-(void)meTextInputView:(METextInputView *)inputView didTapCameraButton:(UIButton*)cameraButton {
    // Present image controller
}
```

#### Customizations

You can show or hide the built-in camera by setting the `displayCameraButton` property on `METextInputView`

```
self.meTextInputView.displayCameraButton = NO;
```

You can show or hide the built-in send button by setting the `displaySendButton` property on `METextInputView`

```
self.meTextInputView.displaySendButton = NO;
```

Using `setFont` you can set the default font of your text input.

```
[self.meTextInputView setFont:[UIFont systemFontOfSize:20]];
```

Chage the color of the placeholder text

```
self.meTextInputView.placeholderLabel.textColor = [UIColor darkGrayColor];
```

#### Controlling Locked Categories

You will need to listen for the NSNotification `MECategorySelectedLockedCategory` to determine when a locked category was tapped on. To unlock a category, you will need to call `[MakemojiSDK unlockCategory:@"category"]` You can listen to `MECategoryUnlockedSuccessNotification` and `MECategoryUnlockedFailedNotification` to determine if the unlock call was successful.

#### App Submission

The Makemoji SDK uses the IDFA tracking id to attribute views, shares, clicks in your app. You will need to check the "Attribute this app installation to a previously served advertisment" option when submitting your app to the App Store.

![](http://og1yl0w9z.bkt.clouddn.com/17-11-30/54698832.jpg)


-------

#中文介绍
------

> Emoji 表情无处不在。 它们每天被数百万人使用，是一个无与伦比的表达工具。

![](http://og1yl0w9z.bkt.clouddn.com/17-11-30/88204422.jpg)

![](https://img.shields.io/badge/platform-iOS-red.svg) ![](https://img.shields.io/badge/language-Objective--C-blue.svg) ![](https://img.shields.io/badge/download-9.9MB-yellow.svg) ![](https://img.shields.io/badge/license-MIT%20License-brightgreen.svg) 


我们相信，用户不应该被限制在 Unicode 库中，我们构建了这个键盘，以增加所有与我们合作的应用程序的参与度，保留率和收入。


### :robot: 要求

iOS 9.0+
Xcode 9.0+
Swift / Objective-C


### :rocket: 准备开始

Makemoji 应用内键盘是我们 SDK 的核心。 这是一个动态控制的表情符号键盘与紧密集成的文本输入，由我们的CMS和仪表板支持。 您可以创建自己的类别，上传 emoji / gifs 并沿着 unicode 表情符号跟踪其使用情况。

![](http://og1yl0w9z.bkt.clouddn.com/17-11-30/64201647.jpg)

我们的文本输入的输出是一个简单的 HTML 消息，以及一个纯文本版本和我们所谓的“替代”版本，它使用一个简单的模板系统。 这个输出可以保存在您的设备上，后端或您选择的任何地方。


### :art: 测试 UI 什么样子？

| 名称 |1.展示页 |2.展示页 |3.展示页 |3.展示页 |
| ------------- | ------------- | ------------- | ------------- | ------------- |
| 截图 | ![](http://og1yl0w9z.bkt.clouddn.com/17-11-29/34552577.jpg) | ![](http://og1yl0w9z.bkt.clouddn.com/17-11-29/26563646.jpg) | ![](http://og1yl0w9z.bkt.clouddn.com/17-11-29/21718798.jpg) | ![](http://og1yl0w9z.bkt.clouddn.com/17-11-29/18066034.jpg) |
| 描述 | 输入前样式 | 文字键盘样式 | 表情包键盘样式 | 表情键盘样式 |


### :zap: 怎么使用？

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

### :hammer_and_wrench: 配置

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

![](http://og1yl0w9z.bkt.clouddn.com/17-11-30/148522.jpg)

有很多方法可以定制这个输入和导航栏的外观和感觉。 我们将在 `Customizations` 中介绍

#### 分离的输入

如果您需要从键盘分离的文本输入，您将需要调用 detachTextInputView 方法，然后将 textInputContainerView 添加到您的视图。

```
[self.meTextInputView detachTextInputView:YES];
[self.view addSubview:self.meTextInputView.textInputContainerView];
```

由于“发送按钮”和“摄像头”按钮在此模式下处于隐藏状态，因此您需要在 `METextInputView` 的 `sendMessage` 方法上附加一个按钮来触发捕获文本。

![](http://og1yl0w9z.bkt.clouddn.com/17-11-30/48111428.jpg)

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

#### 应用程序提交

Makemoji SDK 使用IDFA跟踪ID来为您的应用程序中的视图，共享和点击进行归因。 将应用程序提交到 App Store 时，您需要检查“将此应用程序安装到以前投放的广告”选项。

![](http://og1yl0w9z.bkt.clouddn.com/17-11-30/54698832.jpg)
