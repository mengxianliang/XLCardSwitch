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

@interface ViewController ()<XLCardSwitchDelegate>

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
    
    XLCardSwitch *switchView = [[XLCardSwitch alloc] initWithFrame:self.view.bounds];
    switchView.center = self.view.center;
    switchView.models = models;
    switchView.delegate = self;
    [self.view addSubview:switchView];
    
}

#pragma mark -
#pragma mark XLSlideSwitchDelegate

-(void)XLCardSwitchDidSelectedAt:(NSInteger)index
{
    NSLog(@"滚动到第%zd张卡片",index);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
