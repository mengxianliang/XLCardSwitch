//
//  XLCardSwitch.h
//  XLCardSwitchDemo
//
//  Created by Apple on 2017/1/20.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLCardModel.h"

@protocol XLCardSwitchDelegate <NSObject>

@optional

/**
 点击卡片代理方法
 */
-(void)cardSwitchDidClickAtIndex:(NSInteger)index;

/**
 滚动卡片代理方法
 */
-(void)cardSwitchDidScrollToIndex:(NSInteger)index;

@end

@interface XLCardSwitch : UIView
/**
 当前选中位置
 */
@property (nonatomic, assign, readwrite) NSInteger selectedIndex;
/**
 设置数据源
 */
@property (nonatomic, strong) NSArray <XLCardModel *>*models;
/**
 代理
 */
@property (nonatomic, weak) id<XLCardSwitchDelegate>delegate;

/**
 是否分页，默认为true
 */
@property (nonatomic, assign) BOOL pagingEnabled;

/**
 手动滚动到某个卡片位置
 */
- (void)switchToIndex:(NSInteger)index animated:(BOOL)animated;



@end
