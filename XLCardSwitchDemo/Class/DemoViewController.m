//
//  DemoViewController.m
//  XLCardSwitchDemo
//
//  Created by Apple on 2017/1/20.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "DemoViewController.h"
#import "XLCardSwitch.h"
#import "XLCardModel.h"

@interface DemoViewController ()<XLCardSwitchDelegate> {
    XLCardSwitch *_cardSwitch;
}

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"XLCardSwitch";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"DataPropertyList" ofType:@"plist"];
    NSArray *arr = [NSArray arrayWithContentsOfFile:filePath];
    NSMutableArray *models = [NSMutableArray new];
    for (NSDictionary *dic in arr) {
        XLCardModel *model = [XLCardModel new];
        [model setValuesForKeysWithDictionary:dic];
        [models addObject:model];
    }
    
    _cardSwitch = [[XLCardSwitch alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    _cardSwitch.models = models;
    _cardSwitch.delegate = self;
    //设置初始位置，默认为0
    _cardSwitch.selectedIndex = 3;
    [self.view addSubview:_cardSwitch];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Previous" style:UIBarButtonItemStylePlain target:self action:@selector(switchPrevious)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(switchNext)];
 }

- (void)XLCardSwitchDidSelectedAt:(NSInteger)index {
    NSLog(@"选中了：%zd",index);
}

- (void)switchPrevious {
    
    NSInteger nextIndex = _cardSwitch.selectedIndex - 1;
    nextIndex = nextIndex < 0 ? 0 : nextIndex;
    [_cardSwitch switchToIndex:nextIndex animated:true];
}

- (void)switchNext {
    NSInteger nextIndex = _cardSwitch.selectedIndex + 1;
    nextIndex = nextIndex > _cardSwitch.models.count + 1 ? _cardSwitch.models.count + 1 : nextIndex;
    [_cardSwitch switchToIndex:nextIndex animated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
