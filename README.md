# RSLiveGiftThumbDemo
直播类 App 中刷礼物、点赞功能，学习使用 NegHao.W 的项目整理。

![](https://img.shields.io/badge/platform-iOS-red.svg) 
![](https://img.shields.io/badge/language-Objective--C-orange.svg) 
![](https://img.shields.io/badge/download-26.6MB-brightgreen.svg)
![](https://img.shields.io/badge/license-MIT%20License-brightgreen.svg) 

之前在做图像处理的相关功能，突然想到可以做个直播类 App 中刷礼物、点赞功能，看到 NegHao.W 在 Github 上的 Demo 就拿来整理套用一下。

| 名称 |1.列表页 |2.点赞页 |3.汽车页 |2.飞机页 |3.鲜花页 |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| 截图 | ![](http://og1yl0w9z.bkt.clouddn.com/17-9-4/32861512.jpg) | ![](http://og1yl0w9z.bkt.clouddn.com/17-9-4/32274136.jpg) | ![](http://og1yl0w9z.bkt.clouddn.com/17-9-4/82980872.jpg) | ![](http://og1yl0w9z.bkt.clouddn.com/17-9-4/68683185.jpg) | ![](http://og1yl0w9z.bkt.clouddn.com/17-9-4/4034930.jpg) |
| 描述 | 通过 storyboard 搭建基本框架 | 无限随机浮动效果点赞 | 从左上到右下汽车划过 | 右上到左下飞机划过 | 可重复计数鲜花 |


## Requirements 要求
* iOS 7+
* Xcode 8+


## Usage 使用方法
### 第一步 引入头文件
分了两个文件夹
* NHGiftAnimtionSDK -> 礼物 🎁 SDK
* PraiseAnimationSDK -> 点赞 👍 SDK
```
#import "NHHeader.h"
#import "NHCarViews.h"
#import "NHPlaneViews.h"
```
### 第二步 简单调用
2.1 点赞功能代码段：

```
UIImageView *imageView = [[UIImageView alloc] init];
imageView.frame = CGRectMake(self.thumbButton.frame.origin.x , self.thumbButton.frame.origin.y - 35, 35, 35);
imageView.image = [UIImage imageNamed:@"heart"];
imageView.backgroundColor = [UIColor clearColor];
imageView.clipsToBounds = YES;
[self.view addSubview:imageView];

CGFloat scale = round(random() % 2) + 1.0;
CGFloat speed = 1 / round(random() % 900) + 0.6;
int imageName = round(random() % 12);

[UIView beginAnimations:nil context:(__bridge void *_Nullable)(imageView)];
[UIView setAnimationDuration:7 * speed];

imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"resource.bundle/heart%d.png",imageName]];
imageView.frame = CGRectMake(self.thumbButton.frame.origin.x, 0, 35 * scale, 35 * scale);

[UIView setAnimationDidStopSelector:@selector(onAnimationComplete:finished:context:)];
[UIView setAnimationDelegate:self];
[UIView commitAnimations];
```

2.2 飞机、汽车、鲜花功能代码段：

```
// 汽车🚗
NHCarViews *car = [NHCarViews loadCarViewWithPoint:CGPointZero];
NSMutableArray *pointArrs = [[NSMutableArray alloc] init];
CGFloat width = [UIScreen mainScreen].bounds.size.width / 2;
[pointArrs addObject:NSStringFromCGRect(CGRectMake(width, 300, width, 300))];
car.curveControlAndEndPoints = pointArrs;
[car addAnimationsMoveToPoint:CGPointMake(0, 100) endPoint:CGPointMake(self.view.bounds.size.width +166, 500)];
[self.view addSubview:car];

// 飞机✈️
NHPlaneViews *plane = [NHPlaneViews loadPlaneViewWithPoint:CGPointMake(NHBounds.width + 232, 0)];
[plane addAnimationsMoveToPoint:CGPointMake(NHBounds.width, 100) endPoint:CGPointMake(-500, 410)];
[self.view addSubview:plane];

// 鲜花🌹
if (_flower == nil) {
    [self addFlowerView];
} else {
    _flower.effect = NHSendEffectSpring;
    [_flower continuePresentFlowers];
}
- (void)addFlowerView{
    NHPresentFlower *flower = [[NHPresentFlower alloc] initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, 50)presentFlowerEffect:NHSendEffectShake];
    flower.autoHiddenTime = 5;
    [self.view addSubview:flower];
    _flower = flower;
}
```

使用简单、效率高效、进程安全~~~如果你有更好的建议,希望不吝赐教!


## License 许可证
RSLiveGiftThumbDemo 使用 MIT 许可证，详情见 LICENSE 文件。


## Contact 联系方式:
* WeChat : WhatsXie
* Email : ReverseScale@iCloud.com
* Blog : https://reversescale.github.io
