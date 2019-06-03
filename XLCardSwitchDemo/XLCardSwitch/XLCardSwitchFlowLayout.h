//
//  XLCardSwitchFlowLayout.h
//  XLCardSwitchDemo
//
//  Created by Apple on 2017/1/20.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^XLCenterIndexPathBlock)(NSIndexPath *indexPath);

@interface XLCardSwitchFlowLayout : UICollectionViewFlowLayout

@property (nonatomic , strong) XLCenterIndexPathBlock centerBlock;

@end
