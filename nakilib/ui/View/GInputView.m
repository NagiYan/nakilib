//
//  GInputView.m
//  etong
//
//  Created by Gareamac on 15/3/31.
//  Copyright (c) 2015年 Gareamac. All rights reserved.
//

#import "GInputView.h"
#import "GScreen.h"

@implementation GInputView
{
    UITextField* _edit;
    NSString* _value;
}

- (id)initWithTitle:(NSString*)title andDefaultValue:(NSString*)value withThemeColor:(UIColor *)color withKeyboardType:(UIKeyboardType)keyboardType
{
    self = [super init];
    _value = value;
    self.layer.cornerRadius = 5;
    
    [self setBackgroundColor:[UIColor whiteColor]];
    
    NSInteger viewWidth = GScreenWidth - 44;

    [self setFrame:CGRectMake(22, GScreenHeight/2 - 100, viewWidth, 150)];

    // 标题栏背景
    UIView* titleBkg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, 44)];
    [titleBkg setBackgroundColor:color];
    //圆角
    UIBezierPath *maskPath=[UIBezierPath bezierPathWithRoundedRect:titleBkg.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5,5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = titleBkg.bounds;
    maskLayer.path = maskPath.CGPath;
    titleBkg.layer.mask = maskLayer;
    
    // 标题
    UILabel* labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(viewWidth/2 - 100, 0, 200, 30)];
    [labeltitle setText:title];
    [labeltitle setTextAlignment:NSTextAlignmentCenter];
    [labeltitle setText:title];
    [labeltitle setTextColor:[UIColor whiteColor]];
    
    // 输入框
    _edit = [[UITextField alloc] initWithFrame:CGRectMake(10, 55, viewWidth - 20, 30)];
    [_edit setText:value];
    [_edit becomeFirstResponder];
    [_edit setSelected:YES];
    [_edit setBorderStyle:UITextBorderStyleBezel];
    [_edit setTextAlignment:NSTextAlignmentCenter];
    [_edit selectAll:self];
    [_edit setKeyboardType:keyboardType];
    [_edit setBackgroundColor:[UIColor whiteColor]];
    [_edit setClearButtonMode:UITextFieldViewModeAlways];
    
    // 确定按钮
    UIButton* btnOK = [[UIButton alloc] initWithFrame:CGRectMake(viewWidth/2 - 120, 100, 80, 30)];
    [btnOK setTitle:@"确定" forState:UIControlStateNormal];
    [btnOK addTarget:self action:@selector(onClickOK) forControlEvents:UIControlEventTouchUpInside];
    [btnOK setBackgroundColor:color];
    btnOK.layer.cornerRadius = 3;
    
    // 取消按钮
    UIButton* btnCancel = [[UIButton alloc] initWithFrame:CGRectMake(viewWidth/2 + 40, 100, 80, 30)];
    [btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    [btnCancel addTarget:self action:@selector(onClickCancel) forControlEvents:UIControlEventTouchUpInside];
    [btnCancel setBackgroundColor:[UIColor grayColor]];
    btnCancel.layer.cornerRadius = 3;
    
    [self addSubview:titleBkg];
    [self addSubview:labeltitle];
    [self addSubview:_edit];
    [self addSubview:btnOK];
    [self addSubview:btnCancel];
    
    return self;
}

- (void)onClickOK
{
    if ([_edit.text isEqualToString:@""])
    {
        [self.delegate onInputFinishWithValue:@"" byConfirm:NO];
        return;
    }
    
    [[self delegate] onInputFinishWithValue:_edit.text  byConfirm:YES];
}

- (void)onClickCancel
{
    [self.delegate onInputFinishWithValue:@"" byConfirm:NO];
}

@end
