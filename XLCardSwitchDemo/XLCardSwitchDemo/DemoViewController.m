//
//  DemoViewController.m
//  XLCardSwitchDemo
//
//  Created by Apple on 2017/1/20.
//  Copyright © 2017年 Apple. All rights reserved.
// 

#import "DemoViewController.h"
#import "XLCardSwitch.h"

@interface DemoViewController ()<XLCardSwitchDelegate>

@property (nonatomic, strong) XLCardSwitch *cardSwitch;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) NSMutableArray *models;


@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"XLCardSwitch";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self configNavigationBar];
    
    [self addImageView];
    
    [self addCardSwitch];
    
    [self buildData];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.imageView.frame = self.view.bounds;
    self.cardSwitch.frame = self.view.bounds;
}

- (void)configNavigationBar {
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Previous" style:UIBarButtonItemStylePlain target:self action:@selector(switchPrevious)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(switchNext)];
    
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:@[@"正常滚动",@"自动居中"]];
    seg.selectedSegmentIndex = 0;
    [seg addTarget:self action:@selector(segMethod:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = seg;
}

- (void)addImageView {
    self.imageView = [[UIImageView alloc] init];
    [self.view addSubview:self.imageView];
    
    //毛玻璃效果
    UIBlurEffect* effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView* effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = self.view.bounds;
    [self.imageView addSubview:effectView];
}

- (void)addCardSwitch {
    //初始化
    self.cardSwitch = [[XLCardSwitch alloc] initWithFrame:self.view.bounds];
    //设置代理方法
    self.cardSwitch.delegate = self;
    //分页切换
    self.cardSwitch.pagingEnabled = false;
    [self.view addSubview:self.cardSwitch];
}

- (void)buildData {
    //初始化数据源
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"DataPropertyList" ofType:@"plist"];
    NSArray *arr = [NSArray arrayWithContentsOfFile:filePath];
    self.models = [NSMutableArray new];
    for (NSDictionary *dic in arr) {
        XLCardModel *model = [[XLCardModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [self.models addObject:model];
    }
    
    //设置卡片数据源
    self.cardSwitch.models = self.models;
    
    //更新背景图
    [self configImageViewOfIndex:self.cardSwitch.selectedIndex];
}

//开关分页效果
- (void)segMethod:(UISegmentedControl *)seg {
    switch (seg.selectedSegmentIndex) {
        case 0:
            self.cardSwitch.pagingEnabled = false;
            break;
        case 1:
            self.cardSwitch.pagingEnabled = true;
            break;
        default:
            break;
    }
}

#pragma mark -
#pragma mark CardSwitchDelegate
- (void)cardSwitchDidClickAtIndex:(NSInteger)index {
    NSLog(@"点击了：%zd",index);
    [self configImageViewOfIndex:index];
}

- (void)cardSwitchDidScrollToIndex:(NSInteger)index {
    NSLog(@"滚动到了击了：%zd",index);
    [self configImageViewOfIndex:index];
}

#pragma mark -
#pragma mark 更新imageView
- (void)configImageViewOfIndex:(NSInteger)index {
    //更新背景图
    XLCardModel *model = self.models[index];
    self.imageView.image = [UIImage imageNamed:model.imageName];
}

#pragma mark -
#pragma mark 手动切换方法
- (void)switchPrevious {
    NSInteger index = self.cardSwitch.selectedIndex - 1;
    index = index < 0 ? 0 : index;
    [self.cardSwitch switchToIndex:index animated:true];
}

- (void)switchNext {
    NSInteger index = self.cardSwitch.selectedIndex + 1;
    index = index > self.models.count - 1 ? self.models.count - 1 : index;
    [self.cardSwitch switchToIndex:index animated:true];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
