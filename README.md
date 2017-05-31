# XLCardSwitch

利用余弦函数的曲线特性实现的图片居中放大浏览工具，内部是利用UICollectionview的滚动实现的，有兴趣的可以看一下我的博文，里面有具体的实现原理，还是挺好玩儿的。

## 功能

- [x] 手指拖动实现卡片切换
- [x] 调用方法实现卡片切换

## 效果 

|手指拖动切换|调用方法切换|
|:---:|:---:|
|<img src="https://github.com/mengxianliang/XLCardSwitch/blob/master/GIF/1.gif" width=300 height=538 />|<img src="https://github.com/mengxianliang/XLCardSwitch/blob/master/GIF/2.gif" width=300 height=538 />|


## 使用方法 

**创建方法:**

```objc
-(void)addCardSwitch
{
    _cardSwitch = [[XLCardSwitch alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    _cardSwitch.models = models;
    _cardSwitch.delegate = self;
    [self.view addSubview:_cardSwitch];
}
```

**切换位置:**

```objc
[_cardSwitch switchToIndex:3 animated:true];
或
_cardSwitch.selectedIndex = 3;
```

**代理方法:**

```objc
-(void)XLCardSwitchDidSelectedAt:(NSInteger)index
{
    NSLog(@"选中了：%zd",index);
}
```

### 实现原理请参考[我的博文](http://blog.csdn.net/u013282507/article/details/54136812) 

### 个人开发过的UI工具集合 [XLUIKit](https://github.com/mengxianliang/XLUIKit)
