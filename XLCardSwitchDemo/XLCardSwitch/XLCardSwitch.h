//
//  XLCardSwitch.h
//  XLCardSwitchDemo
//
//  Created by Apple on 2017/1/20.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XLCardSwitchDelegate <NSObject>

@optional

//滚动代理方法
-(void)XLCardSwitchDidSelectedAt:(NSInteger)index;

@end

@interface XLCardSwitch : UIView

@property (strong,nonatomic) NSArray *models;

@property (weak,nonatomic) id<XLCardSwitchDelegate>delegate;

@end
