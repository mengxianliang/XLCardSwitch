//
//  ViewController.m
//  XLCardSwitchDemo
//
//  Created by Apple on 2017/1/6.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "XLCardSwitch.h"
#import "CardModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"权力的游戏";
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"DataPropertyList" ofType:@"plist"];
    NSArray *arr = [NSArray arrayWithContentsOfFile:filePath];
    NSMutableArray *models = [NSMutableArray new];
    for (NSDictionary *dic in arr) {
        CardModel *model = [CardModel new];
        [model setValuesForKeysWithDictionary:dic];
        [models addObject:model];
    }
    
    XLCardSwitch *switchView = [[XLCardSwitch alloc] initWithFrame:CGRectMake(0, 0, [self ScreenWidth], [self ScreenHeight])];
    switchView.center = self.view.center;
    //设置显示卡片的数量
    switchView.models = models;
    [self.view addSubview:switchView];
    
}

//屏幕宽度
-(CGFloat)ScreenWidth
{
    return [UIScreen mainScreen].bounds.size.width;
}
//屏幕高度
-(CGFloat)ScreenHeight
{
    return [UIScreen mainScreen].bounds.size.height;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
