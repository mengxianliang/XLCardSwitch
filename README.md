# XLCardSwitch

利用余弦函数的曲线特性实现的图片居中放大浏览工具，内部是利用UICollectionview的滚动实现的，有兴趣的可以看一下我的博文，里面有具体的实现原理，还是挺好玩儿的。本工具也只是想传递这个这个居中放大的算法，为了方便使用也做了些功能性的封装；

## 功能

- [x] 手指拖动切换卡片
- [x] 调用方法切换卡片
- [x] 可设置分页滚动

## 效果 

|正常滚动|自动居中|调用方法切换|
|:---:|:---:|:---:|
|![image](https://github.com/mengxianliang/ImageRepository/blob/master/XLCardSwitch/GIF/1.gif)|![image](https://github.com/mengxianliang/ImageRepository/blob/master/XLCardSwitch/GIF/2.gif)|![image](https://github.com/mengxianliang/ImageRepository/blob/master/XLCardSwitch/GIF/3.gif)|

## 使用方法 

### OC版本

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

### Swift版本


#### 1、创建

```swift
lazy var cardSwitch: XLCardSwitch = {
    let temp = XLCardSwitch.init()
    temp.frame = self.view.bounds
    temp.dataSource = self
    temp.delegate = self
    //注册cell
    temp.register(cellClass: CustomCollectionViewCell.self, forCellWithReuseIdentifier:"CustomCellID")
    return temp
    }()
```

#### 2、DataSource

*注：使用时必须接入DataSource方法，且需要自定义一个UICollectionviewcell，使用方法和UICollectionview一样，先注册，再使用；XLCardSwitch只负责缩放效果，不关心其他数据和UI*

```swift
//DataSource方法，返回总共卡片个数
func cardSwitchNumberOfCard() -> (Int) {
    return self.cellInfoArr().count
}
    
//DataSource方法，返回UICollectionViewCell
    func cardSwitchCellForItemAtIndex(index: Int) -> (UICollectionViewCell) {
    let cell = self.cardSwitch.dequeueReusableCell(withReuseIdentifier:"CustomCellID", for: index) as! CustomCollectionViewCell
    cell.imageView.image = UIImage.init(named: self.cellInfoArr()[index].0)
    cell.textLabel.text = self.cellInfoArr()[index].1
    return cell
    }
```

#### 3、Delegate

```swift
//滑动切换到新的位置回调
@objc optional func cardSwitchDidScrollToIndex(index: Int) -> ()
//手动点击了
@objc optional func cardSwitchDidSelectedAtIndex(index: Int) -> ()
```

### 实现原理请参考[我的博文](http://blog.csdn.net/u013282507/article/details/54136812) 

### 个人开发过的UI工具集合 [XLUIKit](https://github.com/mengxianliang/XLUIKit)
