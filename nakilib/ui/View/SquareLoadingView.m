//
//  SquareLoadingView.m
//  west dean delicious
//
//  Created by westonnaki on 16/3/7.
//  Copyright © 2016年 westonnaki. All rights reserved.
//

#import "SquareLoadingView.h"
#import "ReactiveCocoa.h"
#import "Masonry.h"
#import "pop.h"

@interface SquareLoadingView()

// 四角四块
@property (strong, nonatomic)UIView* blockLT;
@property (strong, nonatomic)UIView* blockLB;
@property (strong, nonatomic)UIView* blockRT;
@property (strong, nonatomic)UIView* blockRB;
@property (strong, nonatomic)NSArray* viewArray;
@end

@implementation SquareLoadingView

- (instancetype)init
{
    self = [super init];
    _margin = 5;
    _color = [UIColor blackColor];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    _margin = 5;
    _color = [UIColor blackColor];
    return self;
}

- (void)setMargin:(CGFloat)margin
{
    if (_margin != margin)
    {
        _margin = margin;
        [self p_updateLayout];
    }
}

- (void)beginAnimation
{
    [self p_initViews];
    
    if (!_viewArray) {
        _viewArray = @[_blockLT, _blockRT, _blockRB, _blockLB];
    }
    
    [_blockLT pop_removeAllAnimations];
    [_blockRT pop_removeAllAnimations];
    [_blockRB pop_removeAllAnimations];
    [_blockLB pop_removeAllAnimations];
    
    [self p_performAnimationA:0];
}

- (void)stopAnimation
{
    [_blockLT pop_removeAllAnimations];
    [_blockRT pop_removeAllAnimations];
    [_blockRB pop_removeAllAnimations];
    [_blockLB pop_removeAllAnimations];
    
    [_blockLT removeFromSuperview];
    [_blockRT removeFromSuperview];
    [_blockRB removeFromSuperview];
    [_blockLB removeFromSuperview];
    
    _blockLT = nil;
    _blockRT = nil;
    _blockRB = nil;
    _blockLB = nil;
}

// 单个动画前半段
- (void)p_performAnimationA:(NSInteger)index
{
    index = index<=3?index:0;
    UIView* theView = _viewArray[index];
    
    POPBasicAnimation* animationA = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerBackgroundColor];
    [animationA setDuration:0.2];
    animationA.fromValue = self.color;
    CGFloat red = 0.0;
    CGFloat green = 0.0;
    CGFloat blue = 0.0;
    CGFloat alpha = 0.0;
    [self.color getRed:&red green:&green blue:&blue alpha:&alpha];
    animationA.fromValue = self.color;
    animationA.toValue = [UIColor colorWithRed:red
                                          green:green blue:blue alpha:alpha*0.8];
    @weakify(self)
    [animationA setCompletionBlock:^(POPAnimation * _animationA, BOOL finbished)
    {
        @strongify(self)
        [self p_performAnimationB:index];
        [self p_performAnimationA:index+1];
    }];
    [theView.layer pop_removeAllAnimations];
    [theView.layer pop_addAnimation:animationA forKey:@"a"];
}

// 单个动画后半段
- (void)p_performAnimationB:(NSInteger)index
{
    index = index<=3?index:0;
    UIView* theView = _viewArray[index];
    POPBasicAnimation* animationA = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerBackgroundColor];
    [animationA setDuration:0.6];
    animationA.fromValue = self.color;
    CGFloat red = 0.0;
    CGFloat green = 0.0;
    CGFloat blue = 0.0;
    CGFloat alpha = 0.0;
    [self.color getRed:&red green:&green blue:&blue alpha:&alpha];
    animationA.fromValue = [UIColor colorWithRed:red
                                           green:green blue:blue alpha:alpha*0.8];
    animationA.toValue = [UIColor colorWithRed:red
                                         green:green blue:blue alpha:0.0];
    [theView.layer pop_removeAllAnimations];
    [theView.layer pop_addAnimation:animationA forKey:@"b"];
}

// 更新布局
- (void)p_updateLayout
{
    [self p_initViews];
    
    [_blockRT mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self->_blockLT.mas_right).with.offset(self->_margin);
    }];
    
    [_blockLB mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_blockLT.mas_bottom).with.offset(self->_margin);
    }];
    
    [_blockRB mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self->_blockLB.mas_right).with.offset(self->_margin);
        make.top.equalTo(self->_blockRT.mas_bottom).with.offset(self->_margin);
    }];
}

- (void)p_initViews
{
    if (!_blockLB)
    {
        _blockLB = [UIView new];
        [self addSubview:_blockLB];
        
        _blockLT = [UIView new];
        [self addSubview:_blockLT];
        
        _blockRB = [UIView new];
        [self addSubview:_blockRB];
        
        _blockRT = [UIView new];
        [self addSubview:_blockRT];
        
        [_blockLT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self);
        }];
        
        [_blockRT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.equalTo(self);
            make.width.equalTo(self->_blockLT.mas_width);
            make.left.equalTo(self->_blockLT.mas_right).with.offset(self->_margin);
        }];
        
        [_blockLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.equalTo(self);
            make.height.equalTo(self->_blockLT.mas_height);
            make.top.equalTo(self->_blockLT.mas_bottom).with.offset(self->_margin);
        }];
        
        [_blockRB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.equalTo(self);
            make.width.equalTo(self->_blockLB.mas_width);
            make.height.equalTo(self->_blockRT.mas_height);
            make.left.equalTo(self->_blockLB.mas_right).with.offset(self->_margin);
            make.top.equalTo(self->_blockRT.mas_bottom).with.offset(self->_margin);
        }];
        
        RAC(_blockLT, backgroundColor) = RACObserve(self, color);
        RAC(_blockLB, backgroundColor) = RACObserve(self, color);
        RAC(_blockRT, backgroundColor) = RACObserve(self, color);
        RAC(_blockRB, backgroundColor) = RACObserve(self, color);
    }
}

@end
