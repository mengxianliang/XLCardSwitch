//
//  Card.m
//  CardSwitchDemo
//
//  Created by Apple on 2016/11/9.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "XLCardCell.h"
#import "XLCardModel.h"

@interface XLCardCell ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation XLCardCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI {
    self.layer.cornerRadius = 10.0f;
    self.layer.masksToBounds = true;
    self.backgroundColor = [UIColor whiteColor];
    
    CGFloat labelHeight = self.bounds.size.height * 0.20f;
    CGFloat imageViewHeight = self.bounds.size.height - labelHeight;
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, imageViewHeight)];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.layer.masksToBounds = true;
    [self addSubview:self.imageView];
    
    self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, imageViewHeight, self.bounds.size.width, labelHeight)];
    self.textLabel.textColor = [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1];
    self.textLabel.font = [UIFont systemFontOfSize:22];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.adjustsFontSizeToFitWidth = true;
    [self addSubview:self.textLabel];
}

- (void)setModel:(XLCardModel *)model {
    self.imageView.image = [UIImage imageNamed:model.imageName];
    self.textLabel.text = model.title;
}

@end
