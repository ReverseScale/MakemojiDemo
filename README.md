# MakemojiDemo

> Emojis are everywhere. They're used by millions of people every day and are an unparalleled expressive tool. 

![](https://user-gold-cdn.xitu.io/2018/2/7/1616f87bb0d738da?w=1689&h=591&f=png&s=109467)

![](https://img.shields.io/badge/platform-iOS-red.svg) ![](https://img.shields.io/badge/language-Objective--C-blue.svg) ![](https://img.shields.io/badge/download-9.9MB-yellow.svg) ![](https://img.shields.io/badge/license-MIT%20License-brightgreen.svg) 

[EN](https://github.com/ReverseScale/MakemojiDemo) | [中文](https://github.com/ReverseScale/MakemojiDemo/blob/master/README_zh.md)

We believe that users should not be limited to the Unicode library and we built this keyboard to increase engagement, retention and revenue for all of the apps we work with. 


### 🤖 Requirements

* iOS 9.0+ & Android
* Xcode 9.0+
* Swift / Objective-C


### 🚀 Getting started

The Makemoji in-app keyboard is the core of our SDK. It is a dynamically controlled emoji keyboard with an tightly integrated text input that is backed by our CMS and Dashboard. You can create your own categories, upload emoji/gifs and track their usage along side unicode emoji.

![](https://user-gold-cdn.xitu.io/2018/2/7/1616f87bb57cd724?w=569&h=370&f=png&s=28870)

The output of our text input is a simple HTML message, along with a plaintext version and what we called 'substitued' version, which uses a simple template system. This output can then be saved on your device, in your backend or wherever you choose.


### 🎨 Why test the UI?

|1.Show Page |2.Show Page |3.Show Page |4.Show Page |
| ------------- | ------------- | ------------- | ------------- |
| ![](https://user-gold-cdn.xitu.io/2018/2/7/1616f87bb6969319?w=640&h=1136&f=jpeg&s=47286) | ![](https://user-gold-cdn.xitu.io/2018/2/7/1616f87bb6880069?w=640&h=1136&f=jpeg&s=68891) | ![](https://user-gold-cdn.xitu.io/2018/2/7/1616f87bb6a50e40?w=640&h=1136&f=jpeg&s=51624) | ![](https://user-gold-cdn.xitu.io/2018/2/7/1616f87bb51c8391?w=640&h=1136&f=jpeg&s=59621) |
| Before the input style | Writing style of keyboard | Keyboard style expression package | The expression style of keyboard |


### 🎯 Installation

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

### 🛠 Configuration

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

![](https://user-gold-cdn.xitu.io/2018/2/7/1616f87beca73f8e?w=825&h=631&f=png&s=53101)

There are many ways available to customize the look and feel of this input and navigation bar. We'll cover that in `Customizations`

#### Detached Input

If you need the Text Input detached from the keyboard, you will need to call the detachTextInputView method and then add textInputContainerView to your view.

```
[self.meTextInputView detachTextInputView:YES];
[self.view addSubview:self.meTextInputView.textInputContainerView];
```

Since the Send Button and Camera button are hidden in this mode, you will need to attach a button to the `sendMessage` method on `METextInputView` to trigger capturing the text.

![](https://user-gold-cdn.xitu.io/2018/2/7/1616f87becff928a?w=259&h=318&f=png&s=8194)

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

### 📝 App Submission

The Makemoji SDK uses the IDFA tracking id to attribute views, shares, clicks in your app. You will need to check the "Attribute this app installation to a previously served advertisment" option when submitting your app to the App Store.

![](https://user-gold-cdn.xitu.io/2018/2/7/1616f87bece6eb36?w=1264&h=607&f=png&s=75271)


### 😬 Contributions

* WeChat : WhatsXie
* Email : ReverseScale@iCloud.com
* Blog : https://reversescale.github.io
