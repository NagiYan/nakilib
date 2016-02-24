//
//  ReportTitleView.m
//  phm
//
//  Created by GAREA on 15/3/3.
//  Copyright (c) 2015年 GAREA. All rights reserved.
//

#import "ReportTitleView.h"

@implementation ReportTitleView

- (id)initWithFrame:(CGRect)frame withColor:(UIColor*)color title:(NSString*)title
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleView =[[UIView alloc]init];
        [self.titleView setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self.titleView setBackgroundColor:color];
        [self addSubview:self.titleView];
        
        self.titleLabel =[[UILabel alloc]init];
        [self.titleLabel setText:title];
        [self.titleLabel setFrame:CGRectMake(0, 0, self.titleView.bounds.size.width, self.titleView.bounds.size.height)];
        [self.titleLabel setTextAlignment:1];
        [self.titleLabel setTextColor:[UIColor whiteColor]];
        [self.titleView addSubview:self.titleLabel];
    }
    
    return self;
}

- (void)setCornerRadii:(int)radius
{
    UIBezierPath *maskPath=[UIBezierPath bezierPathWithRoundedRect:self.titleView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(radius,radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.titleView.bounds;
    maskLayer.path = maskPath.CGPath;
    self.titleView.layer.mask = maskLayer;
}
@end
