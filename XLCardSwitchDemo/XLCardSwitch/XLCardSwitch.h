//
//  CardSwitchView.h
//  CardSwitchDemo
//
//  Created by Apple on 2016/11/9.
//  Copyright © 2016年 Apple. All rights reserved.
//  图片切换效果视图

#import <UIKit/UIKit.h>

@protocol XLCardSwitchDelegate <NSObject>

@optional

-(void)XLCardSwitchDidSelectedAt:(NSInteger)index;

@end

@interface XLCardSwitch : UIView

@property (strong,nonatomic) NSArray *models;

@property (weak,nonatomic) id<XLCardSwitchDelegate>delegate;

@end
