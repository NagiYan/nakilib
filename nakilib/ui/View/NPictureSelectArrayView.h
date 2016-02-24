//
//  NPictureSelectArrayView.h
//
//
//  Created by NAGI on 15/11/2.
//  Copyright © 2015年 NAGI. All rights reserved.
//
// select picture and show as cells, can delete. can replace, use masonary;
// to enable autoheight, make sure the view is the last view of superview(you can put it in a container view)
#import <UIKit/UIKit.h>

@interface NPictureSelectArrayView : UIView


// the number per line, default is 5
@property (assign, nonatomic)NSInteger column;

// the limit of cells, 0=no limit default is 5
@property (assign, nonatomic)NSInteger limit;

// the current select images array
@property (readonly, nonatomic)NSArray* images;

// the size of the image limit, defaulte is 700
@property (assign, nonatomic)float imageSizeFix;

// force the image to square, default is yes
@property (assign, nonatomic)BOOL squareFix;

// must be set
@property (assign, nonatomic)UIViewController* parentVC;

@end

/* sample
NPictureSelectArrayView* selection = [[NPictureSelectArrayView new] autorelease];
[container addSubview:selection];
[selection setParentVC:self];
[selection setColumn:column];
[selection setLimit:limit];
[selection mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(lastView.mas_bottom).with.offset(10);
    make.left.right.equalTo(_container);
}];
*/