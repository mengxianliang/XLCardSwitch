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

@interface DemoViewController ()<XLCardSwitchDelegate>
{
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
    [self.view addSubview:_cardSwitch];
}

-(void)XLCardSwitchDidSelectedAt:(NSInteger)index
{
    NSLog(@"选中了：%zd",index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
