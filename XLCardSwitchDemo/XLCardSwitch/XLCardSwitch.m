//
//  CardSwitchView.m
//  CardSwitchDemo
//
//  Created by Apple on 2016/11/9.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "XLCardSwitch.h"
#import "XLCard.h"

#import "CardModel.h"

//播放器界面的的宽度所占的比例
static float viewScale = 0.70f;

@interface XLCardSwitch ()<UIScrollViewDelegate>
{
    //用于切换的ScrollView
    UIScrollView *_scrollView;
    //用于保存各个视图
    NSMutableArray *_cards;
    //滚动之前的位置
    CGFloat _startPointX;
    //滚动之后的位置
    CGFloat _endPointX;
    //需要居中显示的index
    NSInteger _currentIndex;
    //背景图
    UIImageView *_backImageView;
}
@end

@implementation XLCardSwitch

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self buildLayout];
    }
    return self;
}

-(void)buildLayout
{
    
    _backImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:_backImageView];
    
    UIBlurEffect* effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView* effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = _backImageView.bounds;
    [_backImageView addSubview:effectView];
    
    //初始化ScrollView
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = false;
    [self addSubview:_scrollView];
    
    //初始化其他参数
    _cards = [[NSMutableArray alloc] init];
    _currentIndex = 0;
}

#pragma mark -
#pragma mark 视图Frame配置

//卡片宽度
-(float)cardWidth
{
    return viewScale*self.bounds.size.width;
}

//卡片间隔
-(float)margin
{
    return (self.bounds.size.width - [self cardWidth])/4;
}
//卡片起始位置
-(float)startX
{
    return (self.bounds.size.width - [self cardWidth])/2.0f;
}

#pragma mark -
#pragma mark 配置轮播图片

-(void)setModels:(NSArray *)models
{
    _models = models;
    //初始化各个卡片器位置
    for (NSInteger i = 0; i<models.count; i++ ) {
        //第一步 在ScrollView上添加卡片
        CGFloat cardHeight = self.bounds.size.height * viewScale;
        CGFloat cardY = (self.bounds.size.height - cardHeight)/2.0f;
        float viewX = [self startX] + i*([self cardWidth] + [self margin]);
        XLCard* card = [[XLCard alloc] initWithFrame:CGRectMake(viewX, cardY, [self cardWidth], cardHeight)];
        card.model = models[i];
        [_scrollView addSubview:card];
        [_cards addObject:card];
        [_scrollView setContentSize:CGSizeMake(card.frame.origin.x + [self cardWidth] + 2*[self margin], 0)];
    }
    //更新卡片的大小
    [self updateCardTransform];
    
    [self configBackGroundImage];

}


#pragma mark -
#pragma mark ScrollView代理方法
//开始拖动时保存起始位置
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _startPointX = scrollView.contentOffset.x;
}

//当ScrollView拖动时 变换每个view的大小，并保证居中屏幕的view高度最高
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self updateCardTransform];
}

//滚动结束，自动回弹到居中卡片
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //卡片滚动到视图中间位置
    dispatch_async(dispatch_get_main_queue(), ^{
        [self scrollToCurrentCard];
    });
}

//卡片自动居中
-(void)scrollToCurrentCard
{
    _endPointX = _scrollView.contentOffset.x;
    //设置滚动最小生效范围，滚动超过scrollMiniDistance 即视为有切换卡片的意向
    float scrollMiniDistance = self.bounds.size.width/30.0f;
    if (_startPointX - _endPointX > scrollMiniDistance) {
//        NSLog(@"向右滑动屏幕");
        if (_currentIndex != 0) {
            _currentIndex -= 1;
        }
    }else if (_endPointX - _startPointX  > scrollMiniDistance)
    {
//        NSLog(@"向左滑动屏幕");
        if (_currentIndex != _cards.count - 1) {
            _currentIndex += 1;
        }
    }
    float viewX = [self startX] + _currentIndex*([self cardWidth] + [self margin]);
    float needX = viewX - [self startX];
    [_scrollView setContentOffset:CGPointMake(needX, 0) animated:true];
    
    [self configBackGroundImage];
    
    if ([_delegate respondsToSelector:@selector(XLCardSwitchDidSelectedAt:)]) {
        [_delegate XLCardSwitchDidSelectedAt:_currentIndex];
    }
}


//更新每个卡片的大小
-(void)updateCardTransform
{
    for (XLCard *card in _cards) {
        //获取卡片所在index
        //获取ScrollView滚动的位置
        CGFloat scrollOffset = _scrollView.contentOffset.x;
        //获取卡片中间位置滚动的相对位置
        CGFloat cardCenterX = card.center.x - scrollOffset;
        //获取卡片中间位置和俯视图中间位置的间距，目标是间距越大卡片越短
        CGFloat apartLength = fabs(self.bounds.size.width/2.0f - cardCenterX);
        //移动的距离和屏幕宽度的的比例
        CGFloat apartScale = apartLength/self.bounds.size.width;
        //把卡片移动范围固定到 -π/4到 +π/4这一个范围内
        CGFloat scale = fabs(cos(apartScale * M_PI/4));
        //设置卡片的缩放
        card.transform = CGAffineTransformMakeScale(1.0, scale);
    }
}


-(void)configBackGroundImage
{
    if (!_models) {return;}
    
    CardModel *model = _models[_currentIndex];
    _backImageView.image = [UIImage imageNamed:model.imageName];
}


@end
