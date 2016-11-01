//
//  NUIMenuList.h
//  west dean delicious
//
//  Created by westonnaki on 15/6/9.
//  Copyright (c) 2015年 westonnaki. All rights reserved.
//  在当前页面弹出一个菜单列表，适用于选项比较少的情况，建议少于5个

#import <UIKit/UIKit.h>

@protocol NUIMenuListDelegate <NSObject>

- (void)didSelectItem:(UIView*)menu index:(NSInteger)index;

@end

@interface NUIMenuList : UIWindow

// 选项列表数据源
@property (strong, nonatomic)NSArray* sourceData;
// 默认选中项
@property (assign, nonatomic)NSInteger indexSelected;

@property (weak, nonatomic)id<NUIMenuListDelegate> menuDelegate;

// 需要在设置完属性后调用
- (void)makeWindow;

@end
