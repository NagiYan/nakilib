//
//  ToastView.h
//  Community
//
//  Created by BST on 13-6-15.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ToastView : UILabel {
    
}

+(void) showWithParent:(UIView*)parent text:(NSString*)text;
+(void) showWithParent:(UIView*)parent text:(NSString*)text afterDelay:(float)delay;
+(void) showWithParent:(UIView*)parent text:(NSString*)text pos:(NSInteger)height;
+(void) showWithParent:(UIView*)parent text:(NSString*)text afterDelay:(float)delay pos:(NSInteger)height;

-(id) initWithText:(NSString*)text delay:(float)delay;

@end
