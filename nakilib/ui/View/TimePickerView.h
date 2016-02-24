//
//  TimePickerView.h
//  west dean delicious
//
//  Created by westonnaki on 15/7/7.
//  Copyright (c) 2015年 westonnaki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimePickerView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>

- (id)initWithFrame:(CGRect)frame withSeconds:(NSInteger)seconds;

- (NSInteger)getTime;

@end
