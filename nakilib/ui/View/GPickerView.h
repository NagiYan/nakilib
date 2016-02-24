//
//  GPickerView.h
//  etong
//
//  Created by GAREA on 15/4/3.
//  Copyright (c) 2015年 Gareamac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GPickerViewDelegate<NSObject>

- (void) onSelectedValue:(int)value byConfirm:(BOOL)bConfirm;

@end

@interface GPickerView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic,retain)id<GPickerViewDelegate> delegate;

- (id)initWithTitle:(NSString*)title withValue:(NSString *)value andPickerViewValueOfRow:(NSArray *)rowsArray withThemeColor:(UIColor*)color  ;
;

-(id)setDefaultsValueOfPickerView:(int)value;

@end
