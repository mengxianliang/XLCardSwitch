//
//  DemoViewController.m
//  XLCardSwitchDemo
//
//  Created by Apple on 2017/1/20.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "DemoViewController.h"
#import "XLCardSwitch.h"

@interface DemoViewController ()<XLCardSwitchDelegate> {
    
    XLCardSwitch *_cardSwitch;
    
    UIImageView *_imageView;
}

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"XLCardSwitch";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Previous" style:UIBarButtonItemStylePlain target:self action:@selector(switchPrevious)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(switchNext)];
    
    [self addImageView];
    
    [self addCardSwitch];
}

- (void)addImageView {
    _imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_imageView];
    
    UIBlurEffect* effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView* effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = _imageView.bounds;
    [_imageView addSubview:effectView];
}

- (void)addCardSwitch {
    //初始化数据源
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"DataPropertyList" ofType:@"plist"];
    NSArray *arr = [NSArray arrayWithContentsOfFile:filePath];
    NSMutableArray *items = [NSMutableArray new];
    for (NSDictionary *dic in arr) {
        XLCardItem *item = [[XLCardItem alloc] init];
        [item setValuesForKeysWithDictionary:dic];
        [items addObject:item];
    }
    
    //设置卡片浏览器
    _cardSwitch = [[XLCardSwitch alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    _cardSwitch.items = items;
    _cardSwitch.delegate = self;
    //分页切换
    _cardSwitch.pagingEnabled = true;
    //设置初始位置，默认为0
    _cardSwitch.selectedIndex = 3;
    [self.view addSubview:_cardSwitch];
}

#pragma mark -
#pragma mark CardSwitchDelegate

- (void)XLCardSwitchDidSelectedAt:(NSInteger)index {
    NSLog(@"选中了：%zd",index);
    
    //更新背景图
    XLCardItem *item = _cardSwitch.items[index];
    _imageView.image = [UIImage imageNamed:item.imageName];
}


- (void)switchPrevious {
    
    NSInteger index = _cardSwitch.selectedIndex - 1;
    index = index < 0 ? 0 : index;
    [_cardSwitch switchToIndex:index animated:true];
}

- (void)switchNext {
    NSInteger index = _cardSwitch.selectedIndex + 1;
    index = index > _cardSwitch.items.count - 1 ? _cardSwitch.items.count - 1 : index;
    [_cardSwitch switchToIndex:index animated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
