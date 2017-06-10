# XLCardSwitch

利用余弦函数的曲线特性实现的图片居中放大浏览工具，内部是利用UICollectionview的滚动实现的，有兴趣的可以看一下我的博文，里面有具体的实现原理，还是挺好玩儿的。本工具也只是想传递这个这个居中放大的算法，为了方便使用也做了些功能性的封装；

## 功能

- [x] 手指拖动切换卡片
- [x] 调用方法切换卡片
- [x] 可设置是否分页滚动

## 效果 

|正常滑动|调用方法切换|分页滑动|
|:---:|:---:|:---:|
|![image](https://github.com/mengxianliang/XLCardSwitch/blob/master/GIF/3.gif)|![image](https://github.com/mengxianliang/XLCardSwitch/blob/master/GIF/2.gif)|![image](https://github.com/mengxianliang/XLCardSwitch/blob/master/GIF/1.gif)|

## 使用方法 

**创建方法:**

```objc
    //设置卡片浏览器
    _cardSwitch = [[XLCardSwitch alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    _cardSwitch.items = items;
    //设置代理
    _cardSwitch.delegate = self;
    //设置是否打开分页滑动
    _cardSwitch.pagingEnabled = true;
    //设置初始位置，默认为0
    _cardSwitch.selectedIndex = 3;
    [self.view addSubview:_cardSwitch];
```

**切换位置:**

```objc
[_cardSwitch switchToIndex:3 animated:true];
```
或
```objc
_cardSwitch.selectedIndex = 3;
```

**代理方法:**

```objc
- (void)XLCardSwitchDidSelectedAt:(NSInteger)index {
    NSLog(@"选中了：%zd",index);
}
```

### 实现原理请参考[我的博文](http://blog.csdn.net/u013282507/article/details/54136812) 

### 个人开发过的UI工具集合 [XLUIKit](https://github.com/mengxianliang/XLUIKit)
