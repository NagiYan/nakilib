//
//  GInputView.h
//  etong
//
//  Created by Gareamac on 15/3/31.
//  Copyright (c) 2015年 Gareamac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GInputViewDelegate<NSObject>

- (void) onInputFinishWithValue:(NSString*)value byConfirm:(BOOL)bConfirm;

@end


@interface GInputView : UIView

@property ( nonatomic,retain)id<GInputViewDelegate> delegate;

- (id)initWithTitle:(NSString*)title andDefaultValue:(NSString*)value withThemeColor:(UIColor*)color withKeyboardType:(UIKeyboardType)keyboardType;
@end
