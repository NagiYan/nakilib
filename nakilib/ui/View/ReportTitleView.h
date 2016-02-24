//
//  ReportTitleView.h
//  phm
//
//  Created by GAREA on 15/3/3.
//  Copyright (c) 2015年 GAREA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportTitleView : UIView


@property(retain,nonatomic)UIView *titleView;

@property(retain,nonatomic)UILabel *titleLabel;

- (id)initWithFrame:(CGRect)frame withColor:(UIColor*)color title:(NSString*)title;

- (void)setCornerRadii:(int)radius;
@end
