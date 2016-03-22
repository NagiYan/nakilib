//
//  GPickerView.m
//  etong
//
//  Created by GAREA on 15/4/3.
//  Copyright (c) 2015年 Gareamac. All rights reserved.
//

#import "GPickerView.h"
#import "GScreen.h"

@implementation GPickerView

{
    UILabel* _labeltitle;
    UIPickerView* _select;
   
    int _value;
    NSString* _title;
    NSArray* _rowsArray;
}

- (id)initWithTitle:(NSString *)title withValue:(NSString *)value andPickerViewValueOfRow:(NSArray *)rowsArray withThemeColor:(UIColor *)color
{
    self = [super init];
    _title = title;
    _rowsArray = [[NSArray alloc]initWithArray:rowsArray];
    
    NSInteger viewWidth = GScreenWidth - 44;
    [self setFrame:CGRectMake(22, GScreenHeight/2 - 100, viewWidth, 210)];
    self.layer.cornerRadius = 5;
    
    // 标题栏背景
    UIView* titleBkg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, 44)];
    [titleBkg setBackgroundColor:color];
    titleBkg.layer.cornerRadius = 5;
    
    // 标题
   _labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(viewWidth/2 - 100, 0, 200, 44)];
    [_labeltitle setTextAlignment:NSTextAlignmentCenter];
    [_labeltitle setText:[NSString stringWithFormat:@"%@ %@",_title,value]];
    [_labeltitle setTextColor:[UIColor whiteColor]];
    
    //选择器
     _select = [[UIPickerView alloc]initWithFrame:CGRectMake(2, 30, viewWidth, 80)];
    _select.dataSource = self;
    _select.delegate = self;
    
    // 确定按钮
    UIButton* btnOK = [[UIButton alloc] initWithFrame:CGRectMake(viewWidth/2 - 120, 175, 80, 30)];
    [btnOK setTitle:@"确定" forState:UIControlStateNormal];
    [btnOK addTarget:self action:@selector(onClickOK) forControlEvents:UIControlEventTouchUpInside];
    [btnOK setBackgroundColor:color];
    [btnOK.layer setCornerRadius:5];
    
    // 取消按钮
    UIButton* btnCancel = [[UIButton alloc] initWithFrame:CGRectMake(viewWidth/2 + 40, 175, 80, 30)];
    [btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    [btnCancel addTarget:self action:@selector(onClickCancel) forControlEvents:UIControlEventTouchUpInside];
    [btnCancel setBackgroundColor:[UIColor grayColor]];
    [btnCancel.layer setCornerRadius:5];
    
    [self addSubview:titleBkg];
    [self addSubview:_labeltitle];
    [self addSubview:_select];
    [self addSubview:btnOK];
    [self addSubview:btnCancel];

    return self;
}

- (void)onClickOK
{
    [[self delegate] onSelectedValue:_value byConfirm:YES];
}

- (void)onClickCancel
{
    [self.delegate onSelectedValue:-1 byConfirm:NO];
}

-(id)setDefaultsValueOfPickerView:(int)value;
{
    [_select selectRow:value inComponent:0 animated:YES];
    return self;
}

#pragma mark -pickerView delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _rowsArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _rowsArray[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _value = (int)row;
    [_labeltitle setText:[NSString stringWithFormat:@"%@ %@",_title,_rowsArray[row]]];
}
@end
