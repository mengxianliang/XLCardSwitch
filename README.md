# XLCardSwitch
利用余弦函数实现的图片浏览工具
 <br>
## 显示效果如下
 <br>
 ![image](https://github.com/mengxianliang/XLCardSwitch/blob/master/1.gif)
 <br>
# 使用方法
<br>
```objc
    创建方法
    _cardSwitch = [[XLCardSwitch alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    _cardSwitch.models = models;
    _cardSwitch.delegate = self;
    [self.view addSubview:_cardSwitch];
    代理方法
-(void)XLCardSwitchDidSelectedAt:(NSInteger)index
{
    NSLog(@"选中了：%zd",index);
}
```
<br>
## 实现原理请参考[我的博文](http://blog.csdn.net/u013282507/article/details/54136812)
