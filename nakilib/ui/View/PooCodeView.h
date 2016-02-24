//
//  PooCodeView.h
//  Code
//
//  Created by crazypoo on 14-4-14.
//  Copyright (c) 2014年 crazypoo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum _CodeType{
    CODE_TYPE_CUSTOM    =   0   ,   // 自定义类型
    CODE_TYPE_NUMBER            ,   // 数字类型
    CODE_TYPE_ALPHA             ,   // 数字字母
}CodeType;

@interface PooCodeView : UIView
@property (assign, nonatomic) CodeType  codeType;
@property (assign, nonatomic) NSInteger codeLength;
@property (nonatomic, retain) NSArray *changeArray;
@property (nonatomic, retain) NSMutableString *changeString;
@property (nonatomic, retain) UILabel *codeLabel;

- (void)update;

@end
